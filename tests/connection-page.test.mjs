import assert from 'node:assert/strict'
import fs from 'node:fs'
import vm from 'node:vm'

const demo = new URL('../JPush_Hbuilder_Demo/', import.meta.url)
const stateSource = fs.readFileSync(new URL('common/connection-state.js', demo), 'utf8')
const registrationSource = fs.readFileSync(new URL('common/registration-state.js', demo), 'utf8')
const script = name => fs.readFileSync(new URL(name, demo), 'utf8').match(/<script>([\s\S]*?)<\/script>/)[1]
let checks = 0

for (const timing of ['register', 'init', 'after-page']) {
  const bus = new Map(), calls = [], callbacks = {}, pending = new Map(), toasts = []
  const messageListeners = ['addNotificationListener', 'addCustomMessageListener', 'addInMessageListener', 'addLocalNotificationListener', 'addTagAliasListener', 'addMobileNumberListener']
  let nativeConnection = timing === 'register' ? true : null
  // Model the native bridge contract; the Java tests exercise the real dispatchers.
  const publish = (method, value) => {
    if (callbacks[method]) callbacks[method](value)
    else {
      if (!pending.has(method)) pending.set(method, [])
      pending.get(method).push(value)
    }
  }
  const register = (method, callback) => {
    callbacks[method] = callback
    for (const value of pending.get(method) || []) callback(value)
    pending.delete(method)
  }
  globalThis.uni = {
    $emit(name, value) { for (const handler of [...(bus.get(name) || [])]) handler(value) },
    $on(name, handler) { if (!bus.has(name)) bus.set(name, new Set()); bus.get(name).add(handler) },
    $off(name, handler) { bus.get(name)?.delete(handler) },
    showToast: options => toasts.push(JSON.parse(options.title)),
    getSystemInfoSync: () => ({ platform: 'android' }),
    requireNativePlugin: () => plugin
  }
  const plugin = new Proxy({}, { get(_, key) {
    if (key === 'setLoggerEnable') return () => calls.push('logger')
    if (key === 'addConnectEventListener') return callback => {
      calls.push('listen'); callbacks.connection = callback
      if (nativeConnection !== null) callback({ connectEnable: nativeConnection })
    }
    if (key === 'initJPushService') return () => {
      calls.push('init')
      if (timing === 'init') {
        nativeConnection = true
        callbacks.connection?.({ connectEnable: true })
      }
      publish('addCommandListener', { command: 2005, commandResult: 0, commandMessage: 'early-rid' })
      for (const method of messageListeners) publish(method, { source: method, sequence: 7, code: 0 })
    }
    if (key === 'getRegistrationID') return callback => {
      assert.equal(typeof callbacks.command, 'function'); checks++
      callback({ registerID: 'test-rid', code: 0 })
    }
    if (key === 'addCommandListener') return callback => {
      callbacks.command = callback
      register(key, callback)
    }
    if (messageListeners.includes(key)) return callback => register(key, callback)
    return () => {}
  } })
  const state = await import('data:text/javascript;base64,' + Buffer.from(stateSource + '\n// ' + timing).toString('base64'))
  const registration = await import('data:text/javascript;base64,' + Buffer.from(registrationSource + '\n// ' + timing).toString('base64'))
  const context = { uni, console: { log() {} }, ...state, ...registration }
  const load = filename => vm.runInNewContext(script(filename)
    .replace(/^\s*import .*$/gm, '').replace('export default', 'result ='), { ...context, result: null })
  const app = load('App.vue')
  app.onLaunch()
  assert.ok(calls.indexOf('logger') < calls.indexOf('init')); checks++
  assert.equal(registration.getCachedRegistrationID(), 'early-rid'); checks++
  assert.deepEqual(toasts.map(value => value.source), messageListeners.slice(0, 4)); checks++
  load('pages/index/tags.vue')
  assert.deepEqual(toasts.at(-1), { source: 'addTagAliasListener', sequence: 7, code: 0 }); checks++
  assert.equal(pending.get('addMobileNumberListener').length, 1); checks++
  load('pages/index/other.vue')
  assert.deepEqual(toasts.at(-1), { source: 'addMobileNumberListener', sequence: 7, code: 0 }); checks++
  assert.deepEqual(toasts.map(value => value.source), messageListeners); checks++
  assert.equal(pending.size, 0); checks++
  const page = load('pages/index/index.vue')
  const instance = { ...page.data() }
  for (const [key, method] of Object.entries(page.methods)) instance[key] = method.bind(instance)
  page.onLoad.call(instance); page.onShow.call(instance)
  if (timing === 'after-page') {
    assert.equal(state.getConnectionState(), null); checks++
    callbacks.connection({ connectEnable: true })
  }
  assert.equal(instance.connectStatus, '已连接'); checks++
  assert.equal(instance.registrationID, 'test-rid'); checks++
  callbacks.command({ command: 2005, commandResult: 0, commandMessage: 'async-rid' })
  assert.equal(instance.registrationID, 'async-rid'); checks++
  registration.updateRegistrationID('')
  assert.equal(instance.registrationID, 'async-rid'); checks++
  callbacks.command({ command: 2005, commandResult: 1, commandMessage: 'failed' })
  assert.equal(instance.registrationID, 'async-rid'); checks++
  callbacks.connection({ connectEnable: false })
  assert.equal(instance.connectStatus, '未连接'); checks++
  callbacks.connection({ connectEnable: true })
  assert.equal(instance.connectStatus, '已连接'); checks++
  let otherPageEvents = 0
  uni.$on('connectStatusChange', () => otherPageEvents++)
  page.onUnload.call(instance)
  callbacks.connection({ connectEnable: false })
  assert.equal(otherPageEvents, 1); checks++
  assert.equal(instance.connectStatus, '已连接'); checks++
  page.onLoad.call(instance); page.onShow.call(instance)
  assert.equal(instance.connectStatus, '未连接'); checks++
  assert.equal(instance.registrationID, 'test-rid'); checks++
}
console.log(`PASS: ${checks} App/page integration checks across early/replayed/late events`)
