import assert from 'node:assert/strict'
import fs from 'node:fs'
import vm from 'node:vm'

const demo = new URL('../JPush_Hbuilder_Demo/', import.meta.url)
const stateSource = fs.readFileSync(new URL('common/connection-state.js', demo), 'utf8')
const registrationSource = fs.readFileSync(new URL('common/registration-state.js', demo), 'utf8')
const script = name => fs.readFileSync(new URL(name, demo), 'utf8').match(/<script>([\s\S]*?)<\/script>/)[1]
let checks = 0

for (const timing of ['register', 'init', 'after-page']) {
  const bus = new Map(), calls = [], callbacks = {}
  globalThis.uni = {
    $emit(name, value) { for (const handler of [...(bus.get(name) || [])]) handler(value) },
    $on(name, handler) { if (!bus.has(name)) bus.set(name, new Set()); bus.get(name).add(handler) },
    $off(name, handler) { bus.get(name)?.delete(handler) },
    getSystemInfoSync: () => ({ platform: 'android' }),
    requireNativePlugin: () => plugin
  }
  const plugin = new Proxy({}, { get(_, key) {
    if (key === 'setLoggerEnable') return () => calls.push('logger')
    if (key === 'addConnectEventListener') return callback => {
      calls.push('listen'); callbacks.connection = callback
      if (timing === 'register') callback({ connectEnable: true })
    }
    if (key === 'initJPushService') return () => {
      calls.push('init')
      if (timing === 'init') callbacks.connection({ connectEnable: true })
    }
    if (key === 'getRegistrationID') return callback => callback({ registerID: 'test-rid', code: 0 })
    if (key === 'addCommandListener') return callback => { callbacks.command = callback }
    return () => {}
  } })
  const state = await import('data:text/javascript;base64,' + Buffer.from(stateSource + '\n// ' + timing).toString('base64'))
  const registration = await import('data:text/javascript;base64,' + Buffer.from(registrationSource + '\n// ' + timing).toString('base64'))
  const context = { uni, console: { log() {} }, ...state, ...registration }
  const load = filename => vm.runInNewContext(script(filename)
    .replace(/^\s*import .*$/gm, '').replace('export default', 'result ='), { ...context, result: null })
  const app = load('App.vue')
  app.onLaunch()
  assert.deepEqual(calls.slice(0, 3), ['logger', 'listen', 'init']); checks++
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
