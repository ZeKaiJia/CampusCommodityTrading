<template>
  <el-container class="home-container">
    <!--头部区域-->
    <el-header style="padding-left: 0">
      <div class="top-head">
        <div>
          <i class="el-icon-s-goods"/>
          <span style="cursor: default;">运管平台</span>
        </div>
        <div style="margin-right: 24px">
          <span style="cursor: default;">{{this.showUser}}</span>
          <div>
            <el-avatar :src="avatarUrl"/>
          </div>
          <el-button type="info" @click="logout">退出</el-button>
        </div>
      </div>
    </el-header>
    <!--页面主体区域-->
    <el-container>
      <!--侧边栏区域-->
      <el-aside :width="isCollapse ? '58px' : '180px'">
        <div class="toggle-button" @click="toggleCollapse" style="display: flex; justify-content: center">
          <i :class="'iconfont icon-icon-test39'" style="margin-left: 22px"/>
        </div>
        <!--侧边栏菜单区域-->
        <el-menu
          background-color="#d1d6dc"
          text-color="#000"
          active-text-color="#000"
          :router="true"
          :collapse="isCollapse"
          :unique-opened="false"
          :collapse-transition="false"
          :default-active="activePath"
          :default-openeds="opened"
        >
          <!--一级菜单-->
          <el-submenu
            :index="item.id + ''"
            v-for="item in menuList"
            :key="item.id"
          >
            <!--一级菜单模板区-->
            <template slot="title">
              <!--图标-->
              <i :class="iconsObj[item.id]" />
              <!--文本-->
              <span>{{ item.authName }}</span>
            </template>
            <!--二级菜单-->
            <el-menu-item
              :index="'/' + subItem.path"
              v-for="subItem in item.children"
              :key="subItem.id"
              @click="saveNavState('/' + subItem.path)"
            >
              <template slot="title">
                <!--图标-->
                <i class="el-icon-menu" />
                <!--文本-->
                <span>{{ subItem.authName }}</span>
              </template>
            </el-menu-item>
          </el-submenu>
        </el-menu>
      </el-aside>
      <el-container>
        <!--侧边栏右侧区域-->
        <el-main style="max-height: 100%;">
          <!--路由占位符-->
          <router-view/>
        </el-main>
      </el-container>
    </el-container>
  </el-container>
</template>

<script>
  import {checkError, clearCookie, getCookie} from '../plugins/utils'

  export default {
    data() {
      return {
        avatarUrl: 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png',
        showUser: '',
        menuList: [
          {
            id: 1,
            authName: '用户管理',
            children: [
              {id: 11, authName: '个人信息', path: 'self'},
              {id: 12, authName: '用户列表', path: 'users'}
              ]
          },
          {
            id: 2,
            authName: '角色管理',
            children: [{id: 21, authName: '角色列表', path: 'roles'}]
          },
          {
            id: 3,
            authName: '商品管理',
            children: [
              {id: 31, authName: '我的商品', path: 'myCommodity'},
              {id: 32, authName: '购买商品', path: 'buyCommodity'}
            ]
          },
          {
            id: 4,
            authName: '订单查询',
            children: [
              {id: 41, authName: '我的订单', path: 'orders'}
            ]
          },
          {
            id: 5,
            authName: '接口文档',
            children: [
              {id: 51, authName: 'API文档', path: 'docs'}
            ]
          }
        ],
      iconsObj: {
        1: 'iconfont icon-icon-test35',
        2: 'iconfont icon-icon-test38',
        3: 'iconfont icon-icon-test38',
        4: 'iconfont icon-icon-test9',
        5: 'iconfont icon-icon-test31',
        6: 'iconfont icon-icon-test29',
        7: 'iconfont icon-icon-test13'
      },
      // 默认不折叠
      isCollapse: false,
      // 被激活的地址
      activePath: '',
      // 被打开的菜单
      opened: []
    }
  },
  created() {
    this.getAvatar()
    this.getMenuList()
    this.showUser = getCookie('user')
    this.information.$on('activePath', path => {
      this.activePath = path
    })
  },
  name: 'Home',
  methods: {
    // 查找头像
    async getAvatar() {
      const name = getCookie('ID')
      const { data: res } = await this.$http.get(`user/selectByName?userName=${name}`)
      if (res.code !== 200) {
        return this.$message.error('获取头像信息失败!' + checkError(res))
      } else {
        if (res.data.userAvatar !== '' && res.data.userAvatar !== null) {
          this.avatarUrl = res.data.userAvatar
        }
      }
    },
    async logout() {
      window.sessionStorage.clear()
      clearCookie('type')
      clearCookie('user')
      clearCookie('ID')
      await this.$router.push('/login')
    },
    // 获取所有的菜单
    // TODO
    async getMenuList() {
      getCookie('type')
    },
    toggleCollapse() {
      this.isCollapse = !this.isCollapse
    },
    saveNavState(activePath) {
      this.activePath = activePath
    }
  }
}
</script>

<style lang="less" scoped>
@import '../assets/css/menu.css';
.home-container {
  height: 100%;
}
.el-header .top-head{
  background-color: #ffffff;
  display: flex;
  justify-content: space-between;
  padding-left: 0;
  align-items: center;
  color: black;
  width: 100vw;
  height: 95%;
  box-shadow: 0 2px 4px 0 var(--cb-color-shadow,rgba(0,0,0,0.16));

  img {
    width: 60px;
    height: 60px;
  }

  > div {
    display: flex;
    align-items: center;

    span {
      margin-left: 15px;
      font-size: 24px;
    }
  }
}
.el-aside {
  background-color: #d1d6dc;
  margin-top: -2px;
  .el-menu {
    border-right: 0;
  }
}
.el-main {
  background-color: ghostwhite;
}
.iconfont {
  margin-right: 22px;
}
.toggle-button {
  background-color: #f5f5f5;
  font-size: 10px;
  line-height: 24px;
  color: black;
  text-align: center;
  letter-spacing: 0.2em;
  cursor: pointer;
}
.el-avatar {
  margin-top: 4px;
  margin-right: 18px;
}
.el-footer {
  background-color: #29384c;
  color: #d7d7d7;
  text-align: center;
  line-height: 30px;
}
  .el-icon-s-goods {
    margin-left: 12px;
    color: #405570;
    font-size: 48px;
    height: 100%;
  }
</style>
