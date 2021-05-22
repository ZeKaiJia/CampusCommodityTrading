import Vue from 'vue'
import Router from 'vue-router'
import Login from '../components/Login'
import Home from '../components/Home'
import Welcome from '../components/Welcome'
import Users from '../components/user/Users'
import Self from '../components/user/Self'
import MyCommodity from "../components/commodity/MyCommodity";
import BuyCommodity from "../components/commodity/BuyCommodity";
import Rights from '../components/power/Rights'
import Roles from '../components/power/Roles'
import Students from '../components/student/Students'
import Subjects from '../components/subject/Subjects'
import Scores from '../components/score/Scores'
import StuTranscripts from '../components/score/StuTranscripts'
import SubTranscripts from '../components/score/SubTranscripts'
import Statuses from '../components/status/Statuses'
import NotFound404 from '../components/NotFound404'
import Docs from '../components/doc/Docs'
import { getCookie } from '../plugins/utils'
import Orders from "../components/order/Orders";
import Views from '../views/index'
Vue.use(Router)

// eslint-disable-next-line no-undef
const router = new Router({
  routes: [
    { path: '/', redirect: '/login' },
    { path: '/login', component: Login },
    { path: '/404', component: NotFound404 },
    {
      path: '/home',
      component: Home,
      redirect: '/welcome',
      children: [
        { path: '/views', component: Views },
        { path: '/welcome', component: Welcome },
        { path: '/users', component: Users },
        { path: '/self', component: Self },
        { path: '/myCommodity', component: MyCommodity },
        { path: '/buyCommodity', component: BuyCommodity },
        { path: '/rights', component: Rights },
        { path: '/roles', component: Roles },
        { path: '/students', component: Students },
        { path: '/subjects', component: Subjects },
        { path: '/scores', component: Scores },
        { path: '/stuTranscripts', component: StuTranscripts },
        { path: '/subTranscripts', component: SubTranscripts },
        { path: '/statuses', component: Statuses },
        { path: '/docs', component: Docs },
        { path: '/orders', component: Orders }
      ]
    }
  ],
  mode: 'history'
})
// 挂载路由导航守卫
router.beforeEach((to, from, next) => {
  // 从cookie中获取保存的数据
  const cookie = getCookie('user')
  if (to.path === '/login') {
    return next()
  } else {
    // 没有token强制跳转
    if (!cookie) {
      return next('/login')
    } else {
      next()
    }
  }
})

export default router
