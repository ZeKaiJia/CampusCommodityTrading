import Vue from 'vue';
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';
import Message from "element-ui/packages/message/src/main";
import MessageBox from "element-ui/packages/message-box/src/main";

Vue.use(ElementUI);

Vue.prototype.$message = Message
Vue.prototype.$confirm = MessageBox.confirm
