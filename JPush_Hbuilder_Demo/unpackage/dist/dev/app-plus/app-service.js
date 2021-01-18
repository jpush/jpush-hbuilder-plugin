(this["webpackJsonp"] = this["webpackJsonp"] || []).push([["app-service"],[
/* 0 */
/*!***********************************************************************************!*\
  !*** /Users/huangshuni/Desktop/jpush-hbuilder-plugin/JPush_Hbuilder_Demo/main.js ***!
  \***********************************************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";
eval("__webpack_require__(/*! uni-pages */ 1);var _vue = _interopRequireDefault(__webpack_require__(/*! vue */ 8));\nvar _App = _interopRequireDefault(__webpack_require__(/*! ./App */ 9));function _interopRequireDefault(obj) {return obj && obj.__esModule ? obj : { default: obj };}function ownKeys(object, enumerableOnly) {var keys = Object.keys(object);if (Object.getOwnPropertySymbols) {var symbols = Object.getOwnPropertySymbols(object);if (enumerableOnly) symbols = symbols.filter(function (sym) {return Object.getOwnPropertyDescriptor(object, sym).enumerable;});keys.push.apply(keys, symbols);}return keys;}function _objectSpread(target) {for (var i = 1; i < arguments.length; i++) {var source = arguments[i] != null ? arguments[i] : {};if (i % 2) {ownKeys(Object(source), true).forEach(function (key) {_defineProperty(target, key, source[key]);});} else if (Object.getOwnPropertyDescriptors) {Object.defineProperties(target, Object.getOwnPropertyDescriptors(source));} else {ownKeys(Object(source)).forEach(function (key) {Object.defineProperty(target, key, Object.getOwnPropertyDescriptor(source, key));});}}return target;}function _defineProperty(obj, key, value) {if (key in obj) {Object.defineProperty(obj, key, { value: value, enumerable: true, configurable: true, writable: true });} else {obj[key] = value;}return obj;}\n\n_vue.default.config.productionTip = false;\n\n_App.default.mpType = 'app';\n\nvar app = new _vue.default(_objectSpread({},\n_App.default));\n\napp.$mount();//# sourceURL=[module]\n//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbInVuaS1hcHA6Ly8vbWFpbi5qcyJdLCJuYW1lcyI6WyJWdWUiLCJjb25maWciLCJwcm9kdWN0aW9uVGlwIiwiQXBwIiwibXBUeXBlIiwiYXBwIiwiJG1vdW50Il0sIm1hcHBpbmdzIjoiQUFBQSx3Q0FBbUI7QUFDbkIsdUU7O0FBRUFBLGFBQUlDLE1BQUosQ0FBV0MsYUFBWCxHQUEyQixLQUEzQjs7QUFFQUMsYUFBSUMsTUFBSixHQUFhLEtBQWI7O0FBRUEsSUFBTUMsR0FBRyxHQUFHLElBQUlMLFlBQUo7QUFDTEcsWUFESyxFQUFaOztBQUdBRSxHQUFHLENBQUNDLE1BQUoiLCJmaWxlIjoiMC5qcyIsInNvdXJjZXNDb250ZW50IjpbImltcG9ydCAndW5pLXBhZ2VzJztpbXBvcnQgVnVlIGZyb20gJ3Z1ZSdcclxuaW1wb3J0IEFwcCBmcm9tICcuL0FwcCdcclxuXHJcblZ1ZS5jb25maWcucHJvZHVjdGlvblRpcCA9IGZhbHNlXHJcblxyXG5BcHAubXBUeXBlID0gJ2FwcCdcclxuXHJcbmNvbnN0IGFwcCA9IG5ldyBWdWUoe1xyXG4gICAgLi4uQXBwXHJcbn0pXHJcbmFwcC4kbW91bnQoKSJdLCJzb3VyY2VSb290IjoiIn0=\n//# sourceURL=webpack-internal:///0\n");

/***/ }),
/* 1 */
/*!**************************************************************************************!*\
  !*** /Users/huangshuni/Desktop/jpush-hbuilder-plugin/JPush_Hbuilder_Demo/pages.json ***!
  \**************************************************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {


if (typeof Promise !== 'undefined' && !Promise.prototype.finally) {
  Promise.prototype.finally = function (callback) {
    var promise = this.constructor;
    return this.then(
    function (value) {return promise.resolve(callback()).then(function () {return value;});},
    function (reason) {return promise.resolve(callback()).then(function () {
        throw reason;
      });});

  };
}

if (uni.restoreGlobal) {
  uni.restoreGlobal(weex, plus, setTimeout, clearTimeout, setInterval, clearInterval);
}
__definePage('pages/index/index', function () {return Vue.extend(__webpack_require__(/*! pages/index/index.vue?mpType=page */ 2).default);});

/***/ }),
/* 2 */
/*!*************************************************************************************************************!*\
  !*** /Users/huangshuni/Desktop/jpush-hbuilder-plugin/JPush_Hbuilder_Demo/pages/index/index.vue?mpType=page ***!
  \*************************************************************************************************************/
/*! no static exports found */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _index_vue_vue_type_template_id_2be84a3c_mpType_page__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./index.vue?vue&type=template&id=2be84a3c&mpType=page */ 3);\n/* harmony import */ var _index_vue_vue_type_script_lang_js_mpType_page__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./index.vue?vue&type=script&lang=js&mpType=page */ 5);\n/* harmony reexport (unknown) */ for(var __WEBPACK_IMPORT_KEY__ in _index_vue_vue_type_script_lang_js_mpType_page__WEBPACK_IMPORTED_MODULE_1__) if(__WEBPACK_IMPORT_KEY__ !== 'default') (function(key) { __webpack_require__.d(__webpack_exports__, key, function() { return _index_vue_vue_type_script_lang_js_mpType_page__WEBPACK_IMPORTED_MODULE_1__[key]; }) }(__WEBPACK_IMPORT_KEY__));\n/* harmony import */ var _Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ../../../../../../../Applications/HBuilderX.app/Contents/HBuilderX/plugins/uniapp-cli/node_modules/@dcloudio/vue-cli-plugin-uni/packages/vue-loader/lib/runtime/componentNormalizer.js */ 7);\n\nvar renderjs\n\n\n\n\n/* normalize component */\n\nvar component = Object(_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_2__[\"default\"])(\n  _index_vue_vue_type_script_lang_js_mpType_page__WEBPACK_IMPORTED_MODULE_1__[\"default\"],\n  _index_vue_vue_type_template_id_2be84a3c_mpType_page__WEBPACK_IMPORTED_MODULE_0__[\"render\"],\n  _index_vue_vue_type_template_id_2be84a3c_mpType_page__WEBPACK_IMPORTED_MODULE_0__[\"staticRenderFns\"],\n  false,\n  null,\n  null,\n  null,\n  false,\n  _index_vue_vue_type_template_id_2be84a3c_mpType_page__WEBPACK_IMPORTED_MODULE_0__[\"components\"],\n  renderjs\n)\n\ncomponent.options.__file = \"pages/index/index.vue\"\n/* harmony default export */ __webpack_exports__[\"default\"] = (component.exports);//# sourceURL=[module]\n//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbbnVsbF0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiJBQUFBO0FBQUE7QUFBQTtBQUFBO0FBQUE7QUFBNkg7QUFDN0g7QUFDb0U7QUFDTDs7O0FBRy9EO0FBQ2dOO0FBQ2hOLGdCQUFnQixpTkFBVTtBQUMxQixFQUFFLHNGQUFNO0FBQ1IsRUFBRSwyRkFBTTtBQUNSLEVBQUUsb0dBQWU7QUFDakI7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBLEVBQUUsK0ZBQVU7QUFDWjtBQUNBOztBQUVBO0FBQ2UsZ0YiLCJmaWxlIjoiMi5qcyIsInNvdXJjZXNDb250ZW50IjpbImltcG9ydCB7IHJlbmRlciwgc3RhdGljUmVuZGVyRm5zLCByZWN5Y2xhYmxlUmVuZGVyLCBjb21wb25lbnRzIH0gZnJvbSBcIi4vaW5kZXgudnVlP3Z1ZSZ0eXBlPXRlbXBsYXRlJmlkPTJiZTg0YTNjJm1wVHlwZT1wYWdlXCJcbnZhciByZW5kZXJqc1xuaW1wb3J0IHNjcmlwdCBmcm9tIFwiLi9pbmRleC52dWU/dnVlJnR5cGU9c2NyaXB0Jmxhbmc9anMmbXBUeXBlPXBhZ2VcIlxuZXhwb3J0ICogZnJvbSBcIi4vaW5kZXgudnVlP3Z1ZSZ0eXBlPXNjcmlwdCZsYW5nPWpzJm1wVHlwZT1wYWdlXCJcblxuXG4vKiBub3JtYWxpemUgY29tcG9uZW50ICovXG5pbXBvcnQgbm9ybWFsaXplciBmcm9tIFwiIS4uLy4uLy4uLy4uLy4uLy4uLy4uL0FwcGxpY2F0aW9ucy9IQnVpbGRlclguYXBwL0NvbnRlbnRzL0hCdWlsZGVyWC9wbHVnaW5zL3VuaWFwcC1jbGkvbm9kZV9tb2R1bGVzL0BkY2xvdWRpby92dWUtY2xpLXBsdWdpbi11bmkvcGFja2FnZXMvdnVlLWxvYWRlci9saWIvcnVudGltZS9jb21wb25lbnROb3JtYWxpemVyLmpzXCJcbnZhciBjb21wb25lbnQgPSBub3JtYWxpemVyKFxuICBzY3JpcHQsXG4gIHJlbmRlcixcbiAgc3RhdGljUmVuZGVyRm5zLFxuICBmYWxzZSxcbiAgbnVsbCxcbiAgbnVsbCxcbiAgbnVsbCxcbiAgZmFsc2UsXG4gIGNvbXBvbmVudHMsXG4gIHJlbmRlcmpzXG4pXG5cbmNvbXBvbmVudC5vcHRpb25zLl9fZmlsZSA9IFwicGFnZXMvaW5kZXgvaW5kZXgudnVlXCJcbmV4cG9ydCBkZWZhdWx0IGNvbXBvbmVudC5leHBvcnRzIl0sInNvdXJjZVJvb3QiOiIifQ==\n//# sourceURL=webpack-internal:///2\n");

/***/ }),
/* 3 */
/*!*******************************************************************************************************************************************!*\
  !*** /Users/huangshuni/Desktop/jpush-hbuilder-plugin/JPush_Hbuilder_Demo/pages/index/index.vue?vue&type=template&id=2be84a3c&mpType=page ***!
  \*******************************************************************************************************************************************/
/*! exports provided: render, staticRenderFns, recyclableRender, components */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_webpack_preprocess_loader_index_js_ref_10_0_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_webpack_uni_app_loader_filter_modules_template_js_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_webpack_uni_app_loader_page_meta_js_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_vue_loader_lib_index_js_vue_loader_options_index_vue_vue_type_template_id_2be84a3c_mpType_page__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../../../../Applications/HBuilderX.app/Contents/HBuilderX/plugins/uniapp-cli/node_modules/@dcloudio/vue-cli-plugin-uni/packages/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!../../../../../../../Applications/HBuilderX.app/Contents/HBuilderX/plugins/uniapp-cli/node_modules/@dcloudio/vue-cli-plugin-uni/packages/webpack-preprocess-loader??ref--10-0!../../../../../../../Applications/HBuilderX.app/Contents/HBuilderX/plugins/uniapp-cli/node_modules/@dcloudio/vue-cli-plugin-uni/packages/webpack-uni-app-loader/filter-modules-template.js!../../../../../../../Applications/HBuilderX.app/Contents/HBuilderX/plugins/uniapp-cli/node_modules/@dcloudio/vue-cli-plugin-uni/packages/webpack-uni-app-loader/page-meta.js!../../../../../../../Applications/HBuilderX.app/Contents/HBuilderX/plugins/uniapp-cli/node_modules/@dcloudio/vue-cli-plugin-uni/packages/vue-loader/lib??vue-loader-options!./index.vue?vue&type=template&id=2be84a3c&mpType=page */ 4);
/* harmony reexport (safe) */ __webpack_require__.d(__webpack_exports__, "render", function() { return _Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_webpack_preprocess_loader_index_js_ref_10_0_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_webpack_uni_app_loader_filter_modules_template_js_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_webpack_uni_app_loader_page_meta_js_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_vue_loader_lib_index_js_vue_loader_options_index_vue_vue_type_template_id_2be84a3c_mpType_page__WEBPACK_IMPORTED_MODULE_0__["render"]; });

/* harmony reexport (safe) */ __webpack_require__.d(__webpack_exports__, "staticRenderFns", function() { return _Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_webpack_preprocess_loader_index_js_ref_10_0_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_webpack_uni_app_loader_filter_modules_template_js_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_webpack_uni_app_loader_page_meta_js_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_vue_loader_lib_index_js_vue_loader_options_index_vue_vue_type_template_id_2be84a3c_mpType_page__WEBPACK_IMPORTED_MODULE_0__["staticRenderFns"]; });

/* harmony reexport (safe) */ __webpack_require__.d(__webpack_exports__, "recyclableRender", function() { return _Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_webpack_preprocess_loader_index_js_ref_10_0_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_webpack_uni_app_loader_filter_modules_template_js_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_webpack_uni_app_loader_page_meta_js_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_vue_loader_lib_index_js_vue_loader_options_index_vue_vue_type_template_id_2be84a3c_mpType_page__WEBPACK_IMPORTED_MODULE_0__["recyclableRender"]; });

/* harmony reexport (safe) */ __webpack_require__.d(__webpack_exports__, "components", function() { return _Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_vue_loader_lib_loaders_templateLoader_js_vue_loader_options_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_webpack_preprocess_loader_index_js_ref_10_0_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_webpack_uni_app_loader_filter_modules_template_js_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_webpack_uni_app_loader_page_meta_js_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_vue_loader_lib_index_js_vue_loader_options_index_vue_vue_type_template_id_2be84a3c_mpType_page__WEBPACK_IMPORTED_MODULE_0__["components"]; });



/***/ }),
/* 4 */
/*!***********************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/@dcloudio/vue-cli-plugin-uni/packages/vue-loader/lib/loaders/templateLoader.js??vue-loader-options!./node_modules/@dcloudio/vue-cli-plugin-uni/packages/webpack-preprocess-loader??ref--10-0!./node_modules/@dcloudio/vue-cli-plugin-uni/packages/webpack-uni-app-loader/filter-modules-template.js!./node_modules/@dcloudio/vue-cli-plugin-uni/packages/webpack-uni-app-loader/page-meta.js!./node_modules/@dcloudio/vue-cli-plugin-uni/packages/vue-loader/lib??vue-loader-options!/Users/huangshuni/Desktop/jpush-hbuilder-plugin/JPush_Hbuilder_Demo/pages/index/index.vue?vue&type=template&id=2be84a3c&mpType=page ***!
  \***********************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************/
/*! exports provided: render, staticRenderFns, recyclableRender, components */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "render", function() { return render; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "staticRenderFns", function() { return staticRenderFns; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "recyclableRender", function() { return recyclableRender; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "components", function() { return components; });
var components
var render = function() {
  var _vm = this
  var _h = _vm.$createElement
  var _c = _vm._self._c || _h
  return _c("div", [
    _c("button", {
      attrs: { _i: 1 },
      on: { click: _vm.requestNotificationAuthorization }
    }),
    _c("br"),
    _c("button", {
      attrs: { _i: 3 },
      on: { click: _vm.openSettingsForNotification }
    }),
    _c("br"),
    _c("button", { attrs: { _i: 5 }, on: { click: _vm.setLoggerEnable } }),
    _c("br"),
    _c("button", { attrs: { _i: 7 }, on: { click: _vm.setLoggerUnEnable } }),
    _c("br"),
    _c("button", { attrs: { _i: 9 }, on: { click: _vm.addTags } }),
    _c("br"),
    _c("button", { attrs: { _i: 11 }, on: { click: _vm.updateTags } }),
    _c("br"),
    _c("button", { attrs: { _i: 13 }, on: { click: _vm.deleteTag } }),
    _c("br"),
    _c("button", { attrs: { _i: 15 }, on: { click: _vm.deleteTags } }),
    _c("br"),
    _c("button", { attrs: { _i: 17 }, on: { click: _vm.queryTags } }),
    _c("br"),
    _c("button", { attrs: { _i: 19 }, on: { click: _vm.queryTag } }),
    _c("br"),
    _c("button", { attrs: { _i: 21 }, on: { click: _vm.setAlias } }),
    _c("br"),
    _c("button", { attrs: { _i: 23 }, on: { click: _vm.deleteAlias } }),
    _c("br"),
    _c("button", { attrs: { _i: 25 }, on: { click: _vm.queryAlias } }),
    _c("br")
  ])
}
var recyclableRender = false
var staticRenderFns = []
render._withStripped = true



/***/ }),
/* 5 */
/*!*************************************************************************************************************************************!*\
  !*** /Users/huangshuni/Desktop/jpush-hbuilder-plugin/JPush_Hbuilder_Demo/pages/index/index.vue?vue&type=script&lang=js&mpType=page ***!
  \*************************************************************************************************************************************/
/*! no static exports found */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_babel_loader_lib_index_js_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_webpack_preprocess_loader_index_js_ref_6_1_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_webpack_uni_app_loader_using_components_js_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_vue_loader_lib_index_js_vue_loader_options_index_vue_vue_type_script_lang_js_mpType_page__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../../../../Applications/HBuilderX.app/Contents/HBuilderX/plugins/uniapp-cli/node_modules/babel-loader/lib!../../../../../../../Applications/HBuilderX.app/Contents/HBuilderX/plugins/uniapp-cli/node_modules/@dcloudio/vue-cli-plugin-uni/packages/webpack-preprocess-loader??ref--6-1!../../../../../../../Applications/HBuilderX.app/Contents/HBuilderX/plugins/uniapp-cli/node_modules/@dcloudio/vue-cli-plugin-uni/packages/webpack-uni-app-loader/using-components.js!../../../../../../../Applications/HBuilderX.app/Contents/HBuilderX/plugins/uniapp-cli/node_modules/@dcloudio/vue-cli-plugin-uni/packages/vue-loader/lib??vue-loader-options!./index.vue?vue&type=script&lang=js&mpType=page */ 6);\n/* harmony import */ var _Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_babel_loader_lib_index_js_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_webpack_preprocess_loader_index_js_ref_6_1_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_webpack_uni_app_loader_using_components_js_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_vue_loader_lib_index_js_vue_loader_options_index_vue_vue_type_script_lang_js_mpType_page__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_babel_loader_lib_index_js_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_webpack_preprocess_loader_index_js_ref_6_1_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_webpack_uni_app_loader_using_components_js_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_vue_loader_lib_index_js_vue_loader_options_index_vue_vue_type_script_lang_js_mpType_page__WEBPACK_IMPORTED_MODULE_0__);\n/* harmony reexport (unknown) */ for(var __WEBPACK_IMPORT_KEY__ in _Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_babel_loader_lib_index_js_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_webpack_preprocess_loader_index_js_ref_6_1_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_webpack_uni_app_loader_using_components_js_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_vue_loader_lib_index_js_vue_loader_options_index_vue_vue_type_script_lang_js_mpType_page__WEBPACK_IMPORTED_MODULE_0__) if(__WEBPACK_IMPORT_KEY__ !== 'default') (function(key) { __webpack_require__.d(__webpack_exports__, key, function() { return _Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_babel_loader_lib_index_js_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_webpack_preprocess_loader_index_js_ref_6_1_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_webpack_uni_app_loader_using_components_js_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_vue_loader_lib_index_js_vue_loader_options_index_vue_vue_type_script_lang_js_mpType_page__WEBPACK_IMPORTED_MODULE_0__[key]; }) }(__WEBPACK_IMPORT_KEY__));\n /* harmony default export */ __webpack_exports__[\"default\"] = (_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_babel_loader_lib_index_js_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_webpack_preprocess_loader_index_js_ref_6_1_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_webpack_uni_app_loader_using_components_js_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_vue_loader_lib_index_js_vue_loader_options_index_vue_vue_type_script_lang_js_mpType_page__WEBPACK_IMPORTED_MODULE_0___default.a); //# sourceURL=[module]\n//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbbnVsbF0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiJBQUFBO0FBQUE7QUFBQTtBQUFBO0FBQWd1QixDQUFnQixzdEJBQUcsRUFBQyIsImZpbGUiOiI1LmpzIiwic291cmNlc0NvbnRlbnQiOlsiaW1wb3J0IG1vZCBmcm9tIFwiLSEuLi8uLi8uLi8uLi8uLi8uLi8uLi9BcHBsaWNhdGlvbnMvSEJ1aWxkZXJYLmFwcC9Db250ZW50cy9IQnVpbGRlclgvcGx1Z2lucy91bmlhcHAtY2xpL25vZGVfbW9kdWxlcy9iYWJlbC1sb2FkZXIvbGliL2luZGV4LmpzIS4uLy4uLy4uLy4uLy4uLy4uLy4uL0FwcGxpY2F0aW9ucy9IQnVpbGRlclguYXBwL0NvbnRlbnRzL0hCdWlsZGVyWC9wbHVnaW5zL3VuaWFwcC1jbGkvbm9kZV9tb2R1bGVzL0BkY2xvdWRpby92dWUtY2xpLXBsdWdpbi11bmkvcGFja2FnZXMvd2VicGFjay1wcmVwcm9jZXNzLWxvYWRlci9pbmRleC5qcz8/cmVmLS02LTEhLi4vLi4vLi4vLi4vLi4vLi4vLi4vQXBwbGljYXRpb25zL0hCdWlsZGVyWC5hcHAvQ29udGVudHMvSEJ1aWxkZXJYL3BsdWdpbnMvdW5pYXBwLWNsaS9ub2RlX21vZHVsZXMvQGRjbG91ZGlvL3Z1ZS1jbGktcGx1Z2luLXVuaS9wYWNrYWdlcy93ZWJwYWNrLXVuaS1hcHAtbG9hZGVyL3VzaW5nLWNvbXBvbmVudHMuanMhLi4vLi4vLi4vLi4vLi4vLi4vLi4vQXBwbGljYXRpb25zL0hCdWlsZGVyWC5hcHAvQ29udGVudHMvSEJ1aWxkZXJYL3BsdWdpbnMvdW5pYXBwLWNsaS9ub2RlX21vZHVsZXMvQGRjbG91ZGlvL3Z1ZS1jbGktcGx1Z2luLXVuaS9wYWNrYWdlcy92dWUtbG9hZGVyL2xpYi9pbmRleC5qcz8/dnVlLWxvYWRlci1vcHRpb25zIS4vaW5kZXgudnVlP3Z1ZSZ0eXBlPXNjcmlwdCZsYW5nPWpzJm1wVHlwZT1wYWdlXCI7IGV4cG9ydCBkZWZhdWx0IG1vZDsgZXhwb3J0ICogZnJvbSBcIi0hLi4vLi4vLi4vLi4vLi4vLi4vLi4vQXBwbGljYXRpb25zL0hCdWlsZGVyWC5hcHAvQ29udGVudHMvSEJ1aWxkZXJYL3BsdWdpbnMvdW5pYXBwLWNsaS9ub2RlX21vZHVsZXMvYmFiZWwtbG9hZGVyL2xpYi9pbmRleC5qcyEuLi8uLi8uLi8uLi8uLi8uLi8uLi9BcHBsaWNhdGlvbnMvSEJ1aWxkZXJYLmFwcC9Db250ZW50cy9IQnVpbGRlclgvcGx1Z2lucy91bmlhcHAtY2xpL25vZGVfbW9kdWxlcy9AZGNsb3VkaW8vdnVlLWNsaS1wbHVnaW4tdW5pL3BhY2thZ2VzL3dlYnBhY2stcHJlcHJvY2Vzcy1sb2FkZXIvaW5kZXguanM/P3JlZi0tNi0xIS4uLy4uLy4uLy4uLy4uLy4uLy4uL0FwcGxpY2F0aW9ucy9IQnVpbGRlclguYXBwL0NvbnRlbnRzL0hCdWlsZGVyWC9wbHVnaW5zL3VuaWFwcC1jbGkvbm9kZV9tb2R1bGVzL0BkY2xvdWRpby92dWUtY2xpLXBsdWdpbi11bmkvcGFja2FnZXMvd2VicGFjay11bmktYXBwLWxvYWRlci91c2luZy1jb21wb25lbnRzLmpzIS4uLy4uLy4uLy4uLy4uLy4uLy4uL0FwcGxpY2F0aW9ucy9IQnVpbGRlclguYXBwL0NvbnRlbnRzL0hCdWlsZGVyWC9wbHVnaW5zL3VuaWFwcC1jbGkvbm9kZV9tb2R1bGVzL0BkY2xvdWRpby92dWUtY2xpLXBsdWdpbi11bmkvcGFja2FnZXMvdnVlLWxvYWRlci9saWIvaW5kZXguanM/P3Z1ZS1sb2FkZXItb3B0aW9ucyEuL2luZGV4LnZ1ZT92dWUmdHlwZT1zY3JpcHQmbGFuZz1qcyZtcFR5cGU9cGFnZVwiIl0sInNvdXJjZVJvb3QiOiIifQ==\n//# sourceURL=webpack-internal:///5\n");

/***/ }),
/* 6 */
/*!******************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/babel-loader/lib!./node_modules/@dcloudio/vue-cli-plugin-uni/packages/webpack-preprocess-loader??ref--6-1!./node_modules/@dcloudio/vue-cli-plugin-uni/packages/webpack-uni-app-loader/using-components.js!./node_modules/@dcloudio/vue-cli-plugin-uni/packages/vue-loader/lib??vue-loader-options!/Users/huangshuni/Desktop/jpush-hbuilder-plugin/JPush_Hbuilder_Demo/pages/index/index.vue?vue&type=script&lang=js&mpType=page ***!
  \******************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";
eval("Object.defineProperty(exports, \"__esModule\", { value: true });exports.default = void 0; //\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n//\n\n// 首先需要通过 uni.requireNativePlugin(\"ModuleName\") 获取 module \nvar jpushModule = uni.requireNativePlugin(\"JG-JPush\");\nvar seq = 1;var _default =\n{\n  methods: {\n\n    openSettingsForNotification: function openSettingsForNotification() {\n      jpushModule.openSettingsForNotification(function (result) {\n        uni.showToast({\n          icon: 'none',\n          title: JSON.stringify(result),\n          duration: 3000 });\n\n      });\n    },\n\n    requestNotificationAuthorization: function requestNotificationAuthorization() {\n      jpushModule.requestNotificationAuthorization(function (result) {\n        uni.showToast({\n          icon: 'none',\n          title: JSON.stringify(result),\n          duration: 3000 });\n\n      });\n    },\n\n    setLoggerEnable: function setLoggerEnable() {\n      jpushModule.setLoggerEnable(true);\n    },\n\n    setLoggerUnEnable: function setLoggerUnEnable() {\n      jpushModule.setLoggerEnable(false);\n    },\n\n    addTags: function addTags() {\n      jpushModule.addTags({\n        'tags': ['fat', 'old'],\n        'sequence': seq++ },\n      function (result) {\n        uni.showToast({\n          icon: 'none',\n          title: JSON.stringify(result),\n          duration: 3000 });\n\n      });\n    },\n\n    updateTags: function updateTags() {\n      jpushModule.updateTags({\n        'tags': ['fat', 'thin', 'young'],\n        'sequence': seq++ },\n      function (result) {\n        uni.showToast({\n          icon: 'none',\n          title: JSON.stringify(result),\n          duration: 3000 });\n\n      });\n    },\n\n    deleteTag: function deleteTag() {\n      jpushModule.deleteTag({\n        'tags': ['fat'],\n        'sequence': seq++ },\n      function (result) {\n        uni.showToast({\n          icon: 'none',\n          title: JSON.stringify(result),\n          duration: 3000 });\n\n      });\n    },\n\n    deleteTags: function deleteTags() {\n      jpushModule.deleteTags({\n        'sequence': seq++ },\n      function (result) {\n        uni.showToast({\n          icon: 'none',\n          title: JSON.stringify(result),\n          duration: 3000 });\n\n      });\n    },\n\n    queryTag: function queryTag() {\n      jpushModule.queryTag({\n        'tag': 'thin',\n        'sequence': seq++ },\n      function (result) {\n        uni.showToast({\n          icon: 'none',\n          title: JSON.stringify(result),\n          duration: 3000 });\n\n      });\n    },\n\n    queryTags: function queryTags() {\n      jpushModule.queryTags({\n        'sequence': seq++ },\n      function (result) {\n        uni.showToast({\n          icon: 'none',\n          title: JSON.stringify(result),\n          duration: 3000 });\n\n      });\n    },\n\n    setAlias: function setAlias() {\n      jpushModule.setAlias({\n        'alias': 'jgcolder',\n        'sequence': seq++ },\n      function (result) {\n        uni.showToast({\n          icon: 'none',\n          title: JSON.stringify(result),\n          duration: 3000 });\n\n      });\n    },\n\n    deleteAlias: function deleteAlias() {\n      jpushModule.deleteAlias({\n        'sequence': seq++ },\n      function (result) {\n        uni.showToast({\n          icon: 'none',\n          title: JSON.stringify(result),\n          duration: 3000 });\n\n      });\n    },\n\n    queryAlias: function queryAlias() {\n      jpushModule.queryAlias({\n        'sequence': seq++ },\n      function (result) {\n        uni.showToast({\n          icon: 'none',\n          title: JSON.stringify(result),\n          duration: 3000 });\n\n      });\n    },\n\n    showToast: function showToast(title, content) {\n\n    } } };exports.default = _default;//# sourceURL=[module]\n//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbInVuaS1hcHA6Ly8vcGFnZXMvaW5kZXgvaW5kZXgudnVlIl0sIm5hbWVzIjpbImpwdXNoTW9kdWxlIiwidW5pIiwicmVxdWlyZU5hdGl2ZVBsdWdpbiIsInNlcSIsIm1ldGhvZHMiLCJvcGVuU2V0dGluZ3NGb3JOb3RpZmljYXRpb24iLCJyZXN1bHQiLCJzaG93VG9hc3QiLCJpY29uIiwidGl0bGUiLCJKU09OIiwic3RyaW5naWZ5IiwiZHVyYXRpb24iLCJyZXF1ZXN0Tm90aWZpY2F0aW9uQXV0aG9yaXphdGlvbiIsInNldExvZ2dlckVuYWJsZSIsInNldExvZ2dlclVuRW5hYmxlIiwiYWRkVGFncyIsInVwZGF0ZVRhZ3MiLCJkZWxldGVUYWciLCJkZWxldGVUYWdzIiwicXVlcnlUYWciLCJxdWVyeVRhZ3MiLCJzZXRBbGlhcyIsImRlbGV0ZUFsaWFzIiwicXVlcnlBbGlhcyIsImNvbnRlbnQiXSwibWFwcGluZ3MiOiJ3RkFBQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBOztBQUVJO0FBQ0EsSUFBSUEsV0FBVyxHQUFHQyxHQUFHLENBQUNDLG1CQUFKLENBQXdCLFVBQXhCLENBQWxCO0FBQ0gsSUFBSUMsR0FBRyxHQUFHLENBQVYsQztBQUNrQjtBQUNYQyxTQUFPLEVBQUU7O0FBRWRDLCtCQUZjLHlDQUVnQjtBQUM3QkwsaUJBQVcsQ0FBQ0ssMkJBQVosQ0FBd0MsVUFBQ0MsTUFBRCxFQUFVO0FBQ2pETCxXQUFHLENBQUNNLFNBQUosQ0FBYztBQUNiQyxjQUFJLEVBQUMsTUFEUTtBQUViQyxlQUFLLEVBQUVDLElBQUksQ0FBQ0MsU0FBTCxDQUFlTCxNQUFmLENBRk07QUFHYk0sa0JBQVEsRUFBRSxJQUhHLEVBQWQ7O0FBS0Es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QUFmLENBRk07QUFHYk0sa0JBQVEsRUFBRSxJQUhHLEVBQWQ7O0FBS0EsT0FSRDtBQVNBLEtBN0lhOztBQStJZEwsYUEvSWMscUJBK0lKRSxLQS9JSSxFQStJRWdCLE9BL0lGLEVBK0lVOztBQUV2QixLQWpKYSxFQURFLEUiLCJmaWxlIjoiNi5qcyIsInNvdXJjZXNDb250ZW50IjpbIi8vXG4vL1xuLy9cbi8vXG4vL1xuLy9cbi8vXG4vL1xuLy9cbi8vXG4vL1xuLy9cbi8vXG4vL1xuLy9cbi8vXG4vL1xuLy9cbi8vXG4vL1xuLy9cbi8vXG4vL1xuLy9cbi8vXG4vL1xuLy9cbi8vXG4vL1xuLy9cbi8vXG4vL1xuXG4gICAgLy8g6aaW5YWI6ZyA6KaB6YCa6L+HIHVuaS5yZXF1aXJlTmF0aXZlUGx1Z2luKFwiTW9kdWxlTmFtZVwiKSDojrflj5YgbW9kdWxlIFxuICAgIHZhciBqcHVzaE1vZHVsZSA9IHVuaS5yZXF1aXJlTmF0aXZlUGx1Z2luKFwiSkctSlB1c2hcIilcblx0dmFyIHNlcSA9IDFcbiAgICBleHBvcnQgZGVmYXVsdCB7XG4gICAgICAgIG1ldGhvZHM6IHtcblx0XHRcdFxuXHRcdFx0b3BlblNldHRpbmdzRm9yTm90aWZpY2F0aW9uKCkge1xuXHRcdFx0XHRqcHVzaE1vZHVsZS5vcGVuU2V0dGluZ3NGb3JOb3RpZmljYXRpb24oKHJlc3VsdCk9Pntcblx0XHRcdFx0XHR1bmkuc2hvd1RvYXN0KHtcblx0XHRcdFx0XHRcdGljb246J25vbmUnLFxuXHRcdFx0XHRcdFx0dGl0bGU6IEpTT04uc3RyaW5naWZ5KHJlc3VsdCksXG5cdFx0XHRcdFx0XHRkdXJhdGlvbjogMzAwMFxuXHRcdFx0XHRcdH0pXG5cdFx0XHRcdH0pXG5cdFx0XHR9LFxuXHRcdFx0XG5cdFx0XHRyZXF1ZXN0Tm90aWZpY2F0aW9uQXV0aG9yaXphdGlvbigpIHtcblx0XHRcdFx0anB1c2hNb2R1bGUucmVxdWVzdE5vdGlmaWNhdGlvbkF1dGhvcml6YXRpb24oKHJlc3VsdCk9Pntcblx0XHRcdFx0XHR1bmkuc2hvd1RvYXN0KHtcblx0XHRcdFx0XHRcdGljb246J25vbmUnLFxuXHRcdFx0XHRcdFx0dGl0bGU6IEpTT04uc3RyaW5naWZ5KHJlc3VsdCksXG5cdFx0XHRcdFx0XHRkdXJhdGlvbjogMzAwMFxuXHRcdFx0XHRcdH0pXG5cdFx0XHRcdH0pXG5cdFx0XHR9LFxuXHRcdFx0XG5cdFx0XHRzZXRMb2dnZXJFbmFibGUoKSB7XG5cdFx0XHRcdGpwdXNoTW9kdWxlLnNldExvZ2dlckVuYWJsZSh0cnVlKVxuXHRcdFx0fSxcblx0XHRcdFxuXHRcdFx0c2V0TG9nZ2VyVW5FbmFibGUoKSB7XG5cdFx0XHRcdGpwdXNoTW9kdWxlLnNldExvZ2dlckVuYWJsZShmYWxzZSlcblx0XHRcdH0sXG5cdFx0XHRcblx0XHRcdGFkZFRhZ3MoKSB7XG5cdFx0XHRcdGpwdXNoTW9kdWxlLmFkZFRhZ3Moe1xuXHRcdFx0XHRcdCd0YWdzJzpbJ2ZhdCcsJ29sZCddLFxuXHRcdFx0XHRcdCdzZXF1ZW5jZSc6IHNlcSsrXG5cdFx0XHRcdH0scmVzdWx0PT57XG5cdFx0XHRcdFx0dW5pLnNob3dUb2FzdCh7XG5cdFx0XHRcdFx0XHRpY29uOidub25lJyxcblx0XHRcdFx0XHRcdHRpdGxlOiBKU09OLnN0cmluZ2lmeShyZXN1bHQpLFxuXHRcdFx0XHRcdFx0ZHVyYXRpb246IDMwMDBcblx0XHRcdFx0XHR9KVxuXHRcdFx0XHR9KVxuXHRcdFx0fSxcblx0XHRcdFxuXHRcdFx0dXBkYXRlVGFncygpIHtcblx0XHRcdFx0anB1c2hNb2R1bGUudXBkYXRlVGFncyh7XG5cdFx0XHRcdFx0J3RhZ3MnOlsnZmF0JywndGhpbicsJ3lvdW5nJ10sXG5cdFx0XHRcdFx0J3NlcXVlbmNlJzogc2VxKytcblx0XHRcdFx0fSxyZXN1bHQ9Pntcblx0XHRcdFx0XHR1bmkuc2hvd1RvYXN0KHtcblx0XHRcdFx0XHRcdGljb246J25vbmUnLFxuXHRcdFx0XHRcdFx0dGl0bGU6IEpTT04uc3RyaW5naWZ5KHJlc3VsdCksXG5cdFx0XHRcdFx0XHRkdXJhdGlvbjogMzAwMFxuXHRcdFx0XHRcdH0pXG5cdFx0XHRcdH0pXG5cdFx0XHR9LFxuXHRcdFx0XG5cdFx0XHRkZWxldGVUYWcoKSB7XG5cdFx0XHRcdGpwdXNoTW9kdWxlLmRlbGV0ZVRhZyh7XG5cdFx0XHRcdFx0J3RhZ3MnOlsnZmF0J10sXG5cdFx0XHRcdFx0J3NlcXVlbmNlJzogc2VxKytcblx0XHRcdFx0fSxyZXN1bHQ9Pntcblx0XHRcdFx0XHR1bmkuc2hvd1RvYXN0KHtcblx0XHRcdFx0XHRcdGljb246J25vbmUnLFxuXHRcdFx0XHRcdFx0dGl0bGU6IEpTT04uc3RyaW5naWZ5KHJlc3VsdCksXG5cdFx0XHRcdFx0XHRkdXJhdGlvbjogMzAwMFxuXHRcdFx0XHRcdH0pXG5cdFx0XHRcdH0pXG5cdFx0XHR9LFxuXHRcdFx0XG5cdFx0XHRkZWxldGVUYWdzKCkge1xuXHRcdFx0XHRqcHVzaE1vZHVsZS5kZWxldGVUYWdzKHtcblx0XHRcdFx0XHQnc2VxdWVuY2UnOiBzZXErK1xuXHRcdFx0XHR9LHJlc3VsdD0+e1xuXHRcdFx0XHRcdHVuaS5zaG93VG9hc3Qoe1xuXHRcdFx0XHRcdFx0aWNvbjonbm9uZScsXG5cdFx0XHRcdFx0XHR0aXRsZTogSlNPTi5zdHJpbmdpZnkocmVzdWx0KSxcblx0XHRcdFx0XHRcdGR1cmF0aW9uOiAzMDAwXG5cdFx0XHRcdFx0fSlcblx0XHRcdFx0fSlcblx0XHRcdH0sXG5cdFx0XHRcblx0XHRcdHF1ZXJ5VGFnKCkge1xuXHRcdFx0XHRqcHVzaE1vZHVsZS5xdWVyeVRhZyh7XG5cdFx0XHRcdFx0J3RhZyc6J3RoaW4nLFxuXHRcdFx0XHRcdCdzZXF1ZW5jZSc6IHNlcSsrXG5cdFx0XHRcdH0scmVzdWx0PT57XG5cdFx0XHRcdFx0dW5pLnNob3dUb2FzdCh7XG5cdFx0XHRcdFx0XHRpY29uOidub25lJyxcblx0XHRcdFx0XHRcdHRpdGxlOiBKU09OLnN0cmluZ2lmeShyZXN1bHQpLFxuXHRcdFx0XHRcdFx0ZHVyYXRpb246IDMwMDBcblx0XHRcdFx0XHR9KVxuXHRcdFx0XHR9KVxuXHRcdFx0fSxcblx0XHRcdFxuXHRcdFx0cXVlcnlUYWdzKCkge1xuXHRcdFx0XHRqcHVzaE1vZHVsZS5xdWVyeVRhZ3Moe1xuXHRcdFx0XHRcdCdzZXF1ZW5jZSc6IHNlcSsrXG5cdFx0XHRcdH0scmVzdWx0PT57XG5cdFx0XHRcdFx0dW5pLnNob3dUb2FzdCh7XG5cdFx0XHRcdFx0XHRpY29uOidub25lJyxcblx0XHRcdFx0XHRcdHRpdGxlOiBKU09OLnN0cmluZ2lmeShyZXN1bHQpLFxuXHRcdFx0XHRcdFx0ZHVyYXRpb246IDMwMDBcblx0XHRcdFx0XHR9KVxuXHRcdFx0XHR9KVxuXHRcdFx0fSxcblx0XHRcdFxuXHRcdFx0c2V0QWxpYXMoKSB7XG5cdFx0XHRcdGpwdXNoTW9kdWxlLnNldEFsaWFzKHtcblx0XHRcdFx0XHQnYWxpYXMnOidqZ2NvbGRlcicsXG5cdFx0XHRcdFx0J3NlcXVlbmNlJzogc2VxKytcblx0XHRcdFx0fSxyZXN1bHQ9Pntcblx0XHRcdFx0XHR1bmkuc2hvd1RvYXN0KHtcblx0XHRcdFx0XHRcdGljb246J25vbmUnLFxuXHRcdFx0XHRcdFx0dGl0bGU6IEpTT04uc3RyaW5naWZ5KHJlc3VsdCksXG5cdFx0XHRcdFx0XHRkdXJhdGlvbjogMzAwMFxuXHRcdFx0XHRcdH0pXG5cdFx0XHRcdH0pXG5cdFx0XHR9LFxuXHRcdFx0XG5cdFx0XHRkZWxldGVBbGlhcygpIHtcblx0XHRcdFx0anB1c2hNb2R1bGUuZGVsZXRlQWxpYXMoe1xuXHRcdFx0XHRcdCdzZXF1ZW5jZSc6IHNlcSsrXG5cdFx0XHRcdH0scmVzdWx0PT57XG5cdFx0XHRcdFx0dW5pLnNob3dUb2FzdCh7XG5cdFx0XHRcdFx0XHRpY29uOidub25lJyxcblx0XHRcdFx0XHRcdHRpdGxlOiBKU09OLnN0cmluZ2lmeShyZXN1bHQpLFxuXHRcdFx0XHRcdFx0ZHVyYXRpb246IDMwMDBcblx0XHRcdFx0XHR9KVxuXHRcdFx0XHR9KVxuXHRcdFx0fSxcblx0XHRcdFxuXHRcdFx0cXVlcnlBbGlhcygpIHtcblx0XHRcdFx0anB1c2hNb2R1bGUucXVlcnlBbGlhcyh7XG5cdFx0XHRcdFx0J3NlcXVlbmNlJzogc2VxKytcblx0XHRcdFx0fSxyZXN1bHQ9Pntcblx0XHRcdFx0XHR1bmkuc2hvd1RvYXN0KHtcblx0XHRcdFx0XHRcdGljb246J25vbmUnLFxuXHRcdFx0XHRcdFx0dGl0bGU6IEpTT04uc3RyaW5naWZ5KHJlc3VsdCksXG5cdFx0XHRcdFx0XHRkdXJhdGlvbjogMzAwMFxuXHRcdFx0XHRcdH0pXG5cdFx0XHRcdH0pXG5cdFx0XHR9LFxuXHRcdFx0XG5cdFx0XHRzaG93VG9hc3QodGl0bGUsY29udGVudCl7XG5cdFx0XHRcdFxuXHRcdFx0fVxuXG4gICAgICAgIH1cbiAgICB9XG4iXSwic291cmNlUm9vdCI6IiJ9\n//# sourceURL=webpack-internal:///6\n");

/***/ }),
/* 7 */
/*!**********************************************************************************************************!*\
  !*** ./node_modules/@dcloudio/vue-cli-plugin-uni/packages/vue-loader/lib/runtime/componentNormalizer.js ***!
  \**********************************************************************************************************/
/*! exports provided: default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "default", function() { return normalizeComponent; });
/* globals __VUE_SSR_CONTEXT__ */

// IMPORTANT: Do NOT use ES2015 features in this file (except for modules).
// This module is a runtime utility for cleaner component module output and will
// be included in the final webpack user bundle.

function normalizeComponent (
  scriptExports,
  render,
  staticRenderFns,
  functionalTemplate,
  injectStyles,
  scopeId,
  moduleIdentifier, /* server only */
  shadowMode, /* vue-cli only */
  components, // fixed by xxxxxx auto components
  renderjs // fixed by xxxxxx renderjs
) {
  // Vue.extend constructor export interop
  var options = typeof scriptExports === 'function'
    ? scriptExports.options
    : scriptExports

  // fixed by xxxxxx auto components
  if (components) {
    if (!options.components) {
      options.components = {}
    }
    var hasOwn = Object.prototype.hasOwnProperty
    for (var name in components) {
      if (hasOwn.call(components, name) && !hasOwn.call(options.components, name)) {
        options.components[name] = components[name]
      }
    }
  }
  // fixed by xxxxxx renderjs
  if (renderjs) {
    (renderjs.beforeCreate || (renderjs.beforeCreate = [])).unshift(function() {
      this[renderjs.__module] = this
    });
    (options.mixins || (options.mixins = [])).push(renderjs)
  }

  // render functions
  if (render) {
    options.render = render
    options.staticRenderFns = staticRenderFns
    options._compiled = true
  }

  // functional template
  if (functionalTemplate) {
    options.functional = true
  }

  // scopedId
  if (scopeId) {
    options._scopeId = 'data-v-' + scopeId
  }

  var hook
  if (moduleIdentifier) { // server build
    hook = function (context) {
      // 2.3 injection
      context =
        context || // cached call
        (this.$vnode && this.$vnode.ssrContext) || // stateful
        (this.parent && this.parent.$vnode && this.parent.$vnode.ssrContext) // functional
      // 2.2 with runInNewContext: true
      if (!context && typeof __VUE_SSR_CONTEXT__ !== 'undefined') {
        context = __VUE_SSR_CONTEXT__
      }
      // inject component styles
      if (injectStyles) {
        injectStyles.call(this, context)
      }
      // register component module identifier for async chunk inferrence
      if (context && context._registeredComponents) {
        context._registeredComponents.add(moduleIdentifier)
      }
    }
    // used by ssr in case component is cached and beforeCreate
    // never gets called
    options._ssrRegister = hook
  } else if (injectStyles) {
    hook = shadowMode
      ? function () { injectStyles.call(this, this.$root.$options.shadowRoot) }
      : injectStyles
  }

  if (hook) {
    if (options.functional) {
      // for template-only hot-reload because in that case the render fn doesn't
      // go through the normalizer
      options._injectStyles = hook
      // register for functioal component in vue file
      var originalRender = options.render
      options.render = function renderWithStyleInjection (h, context) {
        hook.call(context)
        return originalRender(h, context)
      }
    } else {
      // inject component registration as beforeCreate hook
      var existing = options.beforeCreate
      options.beforeCreate = existing
        ? [].concat(existing, hook)
        : [hook]
    }
  }

  return {
    exports: scriptExports,
    options: options
  }
}


/***/ }),
/* 8 */
/*!**********************!*\
  !*** external "Vue" ***!
  \**********************/
/*! no static exports found */
/***/ (function(module, exports) {

module.exports = Vue;

/***/ }),
/* 9 */
/*!***********************************************************************************!*\
  !*** /Users/huangshuni/Desktop/jpush-hbuilder-plugin/JPush_Hbuilder_Demo/App.vue ***!
  \***********************************************************************************/
/*! no static exports found */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _App_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./App.vue?vue&type=script&lang=js& */ 10);\n/* harmony reexport (unknown) */ for(var __WEBPACK_IMPORT_KEY__ in _App_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__) if(__WEBPACK_IMPORT_KEY__ !== 'default') (function(key) { __webpack_require__.d(__webpack_exports__, key, function() { return _App_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__[key]; }) }(__WEBPACK_IMPORT_KEY__));\n/* harmony import */ var _Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ../../../../../Applications/HBuilderX.app/Contents/HBuilderX/plugins/uniapp-cli/node_modules/@dcloudio/vue-cli-plugin-uni/packages/vue-loader/lib/runtime/componentNormalizer.js */ 7);\nvar render, staticRenderFns, recyclableRender, components\nvar renderjs\n\n\n\n\n/* normalize component */\n\nvar component = Object(_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_vue_loader_lib_runtime_componentNormalizer_js__WEBPACK_IMPORTED_MODULE_1__[\"default\"])(\n  _App_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__[\"default\"],\n  render,\n  staticRenderFns,\n  false,\n  null,\n  null,\n  null,\n  false,\n  components,\n  renderjs\n)\n\ncomponent.options.__file = \"App.vue\"\n/* harmony default export */ __webpack_exports__[\"default\"] = (component.exports);//# sourceURL=[module]\n//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbbnVsbF0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiJBQUFBO0FBQUE7QUFBQTtBQUFBO0FBQUE7QUFDQTtBQUN1RDtBQUNMOzs7QUFHbEQ7QUFDME07QUFDMU0sZ0JBQWdCLGlOQUFVO0FBQzFCLEVBQUUseUVBQU07QUFDUjtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTs7QUFFQTtBQUNlLGdGIiwiZmlsZSI6IjkuanMiLCJzb3VyY2VzQ29udGVudCI6WyJ2YXIgcmVuZGVyLCBzdGF0aWNSZW5kZXJGbnMsIHJlY3ljbGFibGVSZW5kZXIsIGNvbXBvbmVudHNcbnZhciByZW5kZXJqc1xuaW1wb3J0IHNjcmlwdCBmcm9tIFwiLi9BcHAudnVlP3Z1ZSZ0eXBlPXNjcmlwdCZsYW5nPWpzJlwiXG5leHBvcnQgKiBmcm9tIFwiLi9BcHAudnVlP3Z1ZSZ0eXBlPXNjcmlwdCZsYW5nPWpzJlwiXG5cblxuLyogbm9ybWFsaXplIGNvbXBvbmVudCAqL1xuaW1wb3J0IG5vcm1hbGl6ZXIgZnJvbSBcIiEuLi8uLi8uLi8uLi8uLi9BcHBsaWNhdGlvbnMvSEJ1aWxkZXJYLmFwcC9Db250ZW50cy9IQnVpbGRlclgvcGx1Z2lucy91bmlhcHAtY2xpL25vZGVfbW9kdWxlcy9AZGNsb3VkaW8vdnVlLWNsaS1wbHVnaW4tdW5pL3BhY2thZ2VzL3Z1ZS1sb2FkZXIvbGliL3J1bnRpbWUvY29tcG9uZW50Tm9ybWFsaXplci5qc1wiXG52YXIgY29tcG9uZW50ID0gbm9ybWFsaXplcihcbiAgc2NyaXB0LFxuICByZW5kZXIsXG4gIHN0YXRpY1JlbmRlckZucyxcbiAgZmFsc2UsXG4gIG51bGwsXG4gIG51bGwsXG4gIG51bGwsXG4gIGZhbHNlLFxuICBjb21wb25lbnRzLFxuICByZW5kZXJqc1xuKVxuXG5jb21wb25lbnQub3B0aW9ucy5fX2ZpbGUgPSBcIkFwcC52dWVcIlxuZXhwb3J0IGRlZmF1bHQgY29tcG9uZW50LmV4cG9ydHMiXSwic291cmNlUm9vdCI6IiJ9\n//# sourceURL=webpack-internal:///9\n");

/***/ }),
/* 10 */
/*!************************************************************************************************************!*\
  !*** /Users/huangshuni/Desktop/jpush-hbuilder-plugin/JPush_Hbuilder_Demo/App.vue?vue&type=script&lang=js& ***!
  \************************************************************************************************************/
/*! no static exports found */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_babel_loader_lib_index_js_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_webpack_preprocess_loader_index_js_ref_6_1_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_webpack_uni_app_loader_using_components_js_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_vue_loader_lib_index_js_vue_loader_options_App_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! -!../../../../../Applications/HBuilderX.app/Contents/HBuilderX/plugins/uniapp-cli/node_modules/babel-loader/lib!../../../../../Applications/HBuilderX.app/Contents/HBuilderX/plugins/uniapp-cli/node_modules/@dcloudio/vue-cli-plugin-uni/packages/webpack-preprocess-loader??ref--6-1!../../../../../Applications/HBuilderX.app/Contents/HBuilderX/plugins/uniapp-cli/node_modules/@dcloudio/vue-cli-plugin-uni/packages/webpack-uni-app-loader/using-components.js!../../../../../Applications/HBuilderX.app/Contents/HBuilderX/plugins/uniapp-cli/node_modules/@dcloudio/vue-cli-plugin-uni/packages/vue-loader/lib??vue-loader-options!./App.vue?vue&type=script&lang=js& */ 11);\n/* harmony import */ var _Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_babel_loader_lib_index_js_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_webpack_preprocess_loader_index_js_ref_6_1_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_webpack_uni_app_loader_using_components_js_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_vue_loader_lib_index_js_vue_loader_options_App_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_babel_loader_lib_index_js_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_webpack_preprocess_loader_index_js_ref_6_1_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_webpack_uni_app_loader_using_components_js_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_vue_loader_lib_index_js_vue_loader_options_App_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__);\n/* harmony reexport (unknown) */ for(var __WEBPACK_IMPORT_KEY__ in _Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_babel_loader_lib_index_js_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_webpack_preprocess_loader_index_js_ref_6_1_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_webpack_uni_app_loader_using_components_js_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_vue_loader_lib_index_js_vue_loader_options_App_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__) if(__WEBPACK_IMPORT_KEY__ !== 'default') (function(key) { __webpack_require__.d(__webpack_exports__, key, function() { return _Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_babel_loader_lib_index_js_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_webpack_preprocess_loader_index_js_ref_6_1_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_webpack_uni_app_loader_using_components_js_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_vue_loader_lib_index_js_vue_loader_options_App_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0__[key]; }) }(__WEBPACK_IMPORT_KEY__));\n /* harmony default export */ __webpack_exports__[\"default\"] = (_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_babel_loader_lib_index_js_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_webpack_preprocess_loader_index_js_ref_6_1_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_webpack_uni_app_loader_using_components_js_Applications_HBuilderX_app_Contents_HBuilderX_plugins_uniapp_cli_node_modules_dcloudio_vue_cli_plugin_uni_packages_vue_loader_lib_index_js_vue_loader_options_App_vue_vue_type_script_lang_js___WEBPACK_IMPORTED_MODULE_0___default.a); //# sourceURL=[module]\n//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbbnVsbF0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiJBQUFBO0FBQUE7QUFBQTtBQUFBO0FBQTJyQixDQUFnQix5c0JBQUcsRUFBQyIsImZpbGUiOiIxMC5qcyIsInNvdXJjZXNDb250ZW50IjpbImltcG9ydCBtb2QgZnJvbSBcIi0hLi4vLi4vLi4vLi4vLi4vQXBwbGljYXRpb25zL0hCdWlsZGVyWC5hcHAvQ29udGVudHMvSEJ1aWxkZXJYL3BsdWdpbnMvdW5pYXBwLWNsaS9ub2RlX21vZHVsZXMvYmFiZWwtbG9hZGVyL2xpYi9pbmRleC5qcyEuLi8uLi8uLi8uLi8uLi9BcHBsaWNhdGlvbnMvSEJ1aWxkZXJYLmFwcC9Db250ZW50cy9IQnVpbGRlclgvcGx1Z2lucy91bmlhcHAtY2xpL25vZGVfbW9kdWxlcy9AZGNsb3VkaW8vdnVlLWNsaS1wbHVnaW4tdW5pL3BhY2thZ2VzL3dlYnBhY2stcHJlcHJvY2Vzcy1sb2FkZXIvaW5kZXguanM/P3JlZi0tNi0xIS4uLy4uLy4uLy4uLy4uL0FwcGxpY2F0aW9ucy9IQnVpbGRlclguYXBwL0NvbnRlbnRzL0hCdWlsZGVyWC9wbHVnaW5zL3VuaWFwcC1jbGkvbm9kZV9tb2R1bGVzL0BkY2xvdWRpby92dWUtY2xpLXBsdWdpbi11bmkvcGFja2FnZXMvd2VicGFjay11bmktYXBwLWxvYWRlci91c2luZy1jb21wb25lbnRzLmpzIS4uLy4uLy4uLy4uLy4uL0FwcGxpY2F0aW9ucy9IQnVpbGRlclguYXBwL0NvbnRlbnRzL0hCdWlsZGVyWC9wbHVnaW5zL3VuaWFwcC1jbGkvbm9kZV9tb2R1bGVzL0BkY2xvdWRpby92dWUtY2xpLXBsdWdpbi11bmkvcGFja2FnZXMvdnVlLWxvYWRlci9saWIvaW5kZXguanM/P3Z1ZS1sb2FkZXItb3B0aW9ucyEuL0FwcC52dWU/dnVlJnR5cGU9c2NyaXB0Jmxhbmc9anMmXCI7IGV4cG9ydCBkZWZhdWx0IG1vZDsgZXhwb3J0ICogZnJvbSBcIi0hLi4vLi4vLi4vLi4vLi4vQXBwbGljYXRpb25zL0hCdWlsZGVyWC5hcHAvQ29udGVudHMvSEJ1aWxkZXJYL3BsdWdpbnMvdW5pYXBwLWNsaS9ub2RlX21vZHVsZXMvYmFiZWwtbG9hZGVyL2xpYi9pbmRleC5qcyEuLi8uLi8uLi8uLi8uLi9BcHBsaWNhdGlvbnMvSEJ1aWxkZXJYLmFwcC9Db250ZW50cy9IQnVpbGRlclgvcGx1Z2lucy91bmlhcHAtY2xpL25vZGVfbW9kdWxlcy9AZGNsb3VkaW8vdnVlLWNsaS1wbHVnaW4tdW5pL3BhY2thZ2VzL3dlYnBhY2stcHJlcHJvY2Vzcy1sb2FkZXIvaW5kZXguanM/P3JlZi0tNi0xIS4uLy4uLy4uLy4uLy4uL0FwcGxpY2F0aW9ucy9IQnVpbGRlclguYXBwL0NvbnRlbnRzL0hCdWlsZGVyWC9wbHVnaW5zL3VuaWFwcC1jbGkvbm9kZV9tb2R1bGVzL0BkY2xvdWRpby92dWUtY2xpLXBsdWdpbi11bmkvcGFja2FnZXMvd2VicGFjay11bmktYXBwLWxvYWRlci91c2luZy1jb21wb25lbnRzLmpzIS4uLy4uLy4uLy4uLy4uL0FwcGxpY2F0aW9ucy9IQnVpbGRlclguYXBwL0NvbnRlbnRzL0hCdWlsZGVyWC9wbHVnaW5zL3VuaWFwcC1jbGkvbm9kZV9tb2R1bGVzL0BkY2xvdWRpby92dWUtY2xpLXBsdWdpbi11bmkvcGFja2FnZXMvdnVlLWxvYWRlci9saWIvaW5kZXguanM/P3Z1ZS1sb2FkZXItb3B0aW9ucyEuL0FwcC52dWU/dnVlJnR5cGU9c2NyaXB0Jmxhbmc9anMmXCIiXSwic291cmNlUm9vdCI6IiJ9\n//# sourceURL=webpack-internal:///10\n");

/***/ }),
/* 11 */
/*!*****************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************!*\
  !*** ./node_modules/babel-loader/lib!./node_modules/@dcloudio/vue-cli-plugin-uni/packages/webpack-preprocess-loader??ref--6-1!./node_modules/@dcloudio/vue-cli-plugin-uni/packages/webpack-uni-app-loader/using-components.js!./node_modules/@dcloudio/vue-cli-plugin-uni/packages/vue-loader/lib??vue-loader-options!/Users/huangshuni/Desktop/jpush-hbuilder-plugin/JPush_Hbuilder_Demo/App.vue?vue&type=script&lang=js& ***!
  \*****************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";
eval("/* WEBPACK VAR INJECTION */(function(__f__) {Object.defineProperty(exports, \"__esModule\", { value: true });exports.default = void 0;\nvar jpushModule = uni.requireNativePlugin(\"JG-JPush\");var _default =\n{\n  onLaunch: function onLaunch() {\n    __f__(\"log\", 'App Launch', \" at App.vue:5\");\n\n    jpushModule.addPushNotificationReceiveListener(function (result) {\n      uni.showToast({\n        icon: 'none',\n        title: JSON.stringify(result) });\n\n    });\n\n    jpushModule.addPushNotificationOpenListener(function (result) {\n      uni.showToast({\n        icon: 'none',\n        title: JSON.stringify(result) });\n\n    });\n\n    jpushModule.addCustomNotificationReceiveListener(function (result) {\n      uni.showToast({\n        icon: 'none',\n        title: JSON.stringify(result) });\n\n    });\n\n  },\n  onShow: function onShow() {\n    __f__(\"log\", 'App Show', \" at App.vue:30\");\n  },\n  onHide: function onHide() {\n    __f__(\"log\", 'App Hide', \" at App.vue:33\");\n  } };exports.default = _default;\n/* WEBPACK VAR INJECTION */}.call(this, __webpack_require__(/*! ./node_modules/@dcloudio/vue-cli-plugin-uni/lib/format-log.js */ 12)[\"default\"]))//# sourceURL=[module]\n//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbInVuaS1hcHA6Ly8vQXBwLnZ1ZSJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiO0FBQ0Esc0Q7QUFDQTtBQUNBO0FBQ0E7O0FBRUE7QUFDQTtBQUNBLG9CQURBO0FBRUEscUNBRkE7O0FBSUEsS0FMQTs7QUFPQTtBQUNBO0FBQ0Esb0JBREE7QUFFQSxxQ0FGQTs7QUFJQSxLQUxBOztBQU9BO0FBQ0E7QUFDQSxvQkFEQTtBQUVBLHFDQUZBOztBQUlBLEtBTEE7O0FBT0EsR0F6QkE7QUEwQkE7QUFDQTtBQUNBLEdBNUJBO0FBNkJBO0FBQ0E7QUFDQSxHQS9CQSxFIiwiZmlsZSI6IjExLmpzIiwic291cmNlc0NvbnRlbnQiOlsiPHNjcmlwdD5cblx0dmFyIGpwdXNoTW9kdWxlID0gdW5pLnJlcXVpcmVOYXRpdmVQbHVnaW4oXCJKRy1KUHVzaFwiKVxyXG5cdGV4cG9ydCBkZWZhdWx0IHtcclxuXHRcdG9uTGF1bmNoOiBmdW5jdGlvbigpIHtcclxuXHRcdFx0Y29uc29sZS5sb2coJ0FwcCBMYXVuY2gnKVxuXHRcdFx0XG5cdFx0XHRqcHVzaE1vZHVsZS5hZGRQdXNoTm90aWZpY2F0aW9uUmVjZWl2ZUxpc3RlbmVyKHJlc3VsdD0+e1xuXHRcdFx0XHR1bmkuc2hvd1RvYXN0KHtcblx0XHRcdFx0XHRpY29uOiAnbm9uZScsXG5cdFx0XHRcdFx0dGl0bGU6IEpTT04uc3RyaW5naWZ5KHJlc3VsdClcblx0XHRcdFx0fSlcblx0XHRcdH0pXG5cdFx0XHRcblx0XHRcdGpwdXNoTW9kdWxlLmFkZFB1c2hOb3RpZmljYXRpb25PcGVuTGlzdGVuZXIocmVzdWx0PT57XG5cdFx0XHRcdHVuaS5zaG93VG9hc3Qoe1xuXHRcdFx0XHRcdGljb246ICdub25lJyxcblx0XHRcdFx0XHR0aXRsZTogSlNPTi5zdHJpbmdpZnkocmVzdWx0KVxuXHRcdFx0XHR9KVxuXHRcdFx0fSlcblx0XHRcdFxuXHRcdFx0anB1c2hNb2R1bGUuYWRkQ3VzdG9tTm90aWZpY2F0aW9uUmVjZWl2ZUxpc3RlbmVyKHJlc3VsdD0+e1xuXHRcdFx0XHR1bmkuc2hvd1RvYXN0KHtcblx0XHRcdFx0XHRpY29uOiAnbm9uZScsXG5cdFx0XHRcdFx0dGl0bGU6IEpTT04uc3RyaW5naWZ5KHJlc3VsdClcblx0XHRcdFx0fSlcblx0XHRcdH0pXG5cdFx0XHRcclxuXHRcdH0sXHJcblx0XHRvblNob3c6IGZ1bmN0aW9uKCkge1xyXG5cdFx0XHRjb25zb2xlLmxvZygnQXBwIFNob3cnKVxyXG5cdFx0fSxcclxuXHRcdG9uSGlkZTogZnVuY3Rpb24oKSB7XHJcblx0XHRcdGNvbnNvbGUubG9nKCdBcHAgSGlkZScpXHJcblx0XHR9XHJcblx0fVxyXG48L3NjcmlwdD5cclxuXHJcbjxzdHlsZT5cclxuXHQvKuavj+S4qumhtemdouWFrOWFsWNzcyAqL1xyXG48L3N0eWxlPlxuIl0sInNvdXJjZVJvb3QiOiIifQ==\n//# sourceURL=webpack-internal:///11\n");

/***/ }),
/* 12 */
/*!*********************************************************************!*\
  !*** ./node_modules/@dcloudio/vue-cli-plugin-uni/lib/format-log.js ***!
  \*********************************************************************/
/*! exports provided: log, default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "log", function() { return log; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "default", function() { return formatLog; });
function typof (v) {
  var s = Object.prototype.toString.call(v)
  return s.substring(8, s.length - 1)
}

function isDebugMode () {
  /* eslint-disable no-undef */
  return typeof __channelId__ === 'string' && __channelId__
}

function jsonStringifyReplacer (k, p) {
  switch (typof(p)) {
    case 'Function':
      return 'function() { [native code] }'
    default :
      return p
  }
}

function log (type) {
  for (var _len = arguments.length, args = new Array(_len > 1 ? _len - 1 : 0), _key = 1; _key < _len; _key++) {
    args[_key - 1] = arguments[_key]
  }
  console[type].apply(console, args)
}

function formatLog () {
  for (var _len = arguments.length, args = new Array(_len), _key = 0; _key < _len; _key++) {
    args[_key] = arguments[_key]
  }
  var type = args.shift()
  if (isDebugMode()) {
    args.push(args.pop().replace('at ', 'uni-app:///'))
    return console[type].apply(console, args)
  }

  var msgs = args.map(function (v) {
    var type = Object.prototype.toString.call(v).toLowerCase()

    if (type === '[object object]' || type === '[object array]') {
      try {
        v = '---BEGIN:JSON---' + JSON.stringify(v, jsonStringifyReplacer) + '---END:JSON---'
      } catch (e) {
        v = type
      }
    } else {
      if (v === null) {
        v = '---NULL---'
      } else if (v === undefined) {
        v = '---UNDEFINED---'
      } else {
        var vType = typof(v).toUpperCase()

        if (vType === 'NUMBER' || vType === 'BOOLEAN') {
          v = '---BEGIN:' + vType + '---' + v + '---END:' + vType + '---'
        } else {
          v = String(v)
        }
      }
    }

    return v
  })
  var msg = ''

  if (msgs.length > 1) {
    var lastMsg = msgs.pop()
    msg = msgs.join('---COMMA---')

    if (lastMsg.indexOf(' at ') === 0) {
      msg += lastMsg
    } else {
      msg += '---COMMA---' + lastMsg
    }
  } else {
    msg = msgs[0]
  }

  console[type](msg)
}


/***/ })
],[[0,"app-config"]]]);