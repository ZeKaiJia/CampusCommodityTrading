import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import './plugins/element.js'
import './assets/css/global.css'
import './assets/icon/iconfont.css'
import axios from 'axios'
import dataV from '@jiaminghi/data-view';

// 导入富文本编辑器
import VueQuillEditor from 'vue-quill-editor'
import 'quill/dist/quill.core.css'
import 'quill/dist/quill.snow.css'
import 'quill/dist/quill.bubble.css'

// 按需引入vue-awesome图标
import Icon from 'vue-awesome/components/Icon';
import 'vue-awesome/icons/chart-bar.js';
import 'vue-awesome/icons/chart-area.js';
import 'vue-awesome/icons/chart-pie.js';
import 'vue-awesome/icons/chart-line.js';
import 'vue-awesome/icons/align-left.js';

// 全局注册图标
Vue.component('icon', Icon);

// 适配flex
import '@/common/flexible.js';

// 引入全局css
import './assets/scss/style.scss';

//引入echart
import * as echarts from 'echarts'
Vue.prototype.$echarts = echarts

// 需求样式
import 'quill/dist/quill.core.css'
import 'quill/dist/quill.snow.css'
import 'quill/dist/quill.bubble.css'

// TODO 配置请求的根路径
axios.defaults.baseURL = '//localhost:14001'
// axios.defaults.baseURL = '//fwwb.ims.cool:14001'
axios.defaults.withCredentials = true

Vue.config.productionTip = false
Vue.prototype.$http = axios
Vue.prototype.information = new Vue()

// 注册富文本编辑器
Vue.use(VueQuillEditor)

// 注册大数据显示样式
Vue.use(dataV);

new Vue({
    router,
    store,
    render: (h) => h(App)
}).$mount('#app')

axios.interceptors.request.use(
    function (config) {
        return config
    },
    function (error) {
        // Do something with request error
        return Promise.reject(error)
    }
)
axios.interceptors.response.use(
    function (response) {
        // Do something with response data
        response.headers['Access-Control-Allow-Origin'] = '//127.0.0.1'
        response.headers['Access-Control-Allow-Credentials'] = 'true'
        return response
    },
    function (error) {
        // Do something with response error
        return Promise.reject(error)
    }
)
