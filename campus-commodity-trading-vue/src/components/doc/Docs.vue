<template>
  <div style="width: 100%; height: 100%;">
    <!--面包屑导航区-->
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/home' }" @click.native="changeMenu('/')">首页</el-breadcrumb-item>
      <el-breadcrumb-item>接口文档</el-breadcrumb-item>
      <el-breadcrumb-item>API文档</el-breadcrumb-item>
    </el-breadcrumb>
    <iframe :src="iframeUrl" width="100%" height="95%" id="frame"/>
  </div>
</template>

<script>
export default {
  name: 'Docs',
  data() {
    return {
      // 路由url
      routeUrl: '/docs',
      iframeUrl: ''
    }
  },
  created() {
    this.information.$emit('activePath', this.routeUrl)
    this.changeStyle()
    this.changeUrl()
  },
  methods: {
    changeUrl() {
      let host = window.location.host
      let reg = /^localhost+/
      if(reg.test(host)) {
        this.iframeUrl = '//localhost:14001/doc.html'
      } else {
        this.iframeUrl =  "//fwwb.ims.cool:14001/doc.html"
      }
    },
    // 面包屑导航切换
    changeMenu(activePath) {
      this.information.$emit('activePath', activePath)
    },
    changeStyle() {
    }
  }
}
</script>

<style lang="less" scoped>

</style>
