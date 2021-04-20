<template>
  <div>
    <el-row type="flex" justify="center">
      <span class="title">{{this.roleInfo.roleNameCn}}端</span>
    </el-row>
    <el-row type="flex" justify="center">
      <el-carousel :interval="4000" arrow="always" height="580px" style="width: 1150px">
        <el-carousel-item
          v-for="item in src"
          :key="item"
          v-loading="loading"
        >
          <el-image
            :src="item"
            style="height: 580px"
            fit="cover"
            @load="loadSuccess"
            @error="loadError"
          >
            <div slot="error" class="image-slot"
                 style="display: flex; justify-content: center; align-items: center;
                 height: 100%; width: 1150px; flex-flow: column">
              <span class="el-icon-picture-outline" style="width: 48px; height: 48px; font-size: 48px"/>
              <span style="margin-top: 12px">加载失败</span>
            </div>
          </el-image>
        </el-carousel-item>
      </el-carousel>
    </el-row>
    <!--管理员导航栏-->
    <el-card
            v-if="roleInfo.roleNameEn === 'admin'"
            class="card"
    >
      <el-row :gutter="20">
        <el-col :span="6">
          <div class="foot">快速入口:</div>
        </el-col>
        <el-col :span="6">
          <el-link
            href="http://www.ky.zstu.edu.cn/index/xyxw.htm"
            target="_blank"
            class="link"
            :underline="false"
            icon="el-icon-s-claim"
          >最新校务通知</el-link>
        </el-col>
        <el-col :span="6">
          <el-link
            @click="jump('/users')"
            class="link"
            :underline="false"
            icon="el-icon-s-custom"
          >用户列表查询</el-link>
        </el-col>
        <el-col :span="6">
          <el-link
            @click="jump('/docs')"
            class="link"
            :underline="false"
            icon="el-icon-s-order"
          >API文档查询</el-link>
        </el-col>
      </el-row>
    </el-card>
    <!--买家导航栏-->
    <el-card
            v-if="roleInfo.roleNameEn === 'buyer'"
            class="card"
    >
      <el-row :gutter="20">
        <el-col :span="6">
          <div class="foot">快速入口:</div>
        </el-col>
          <el-col :span="6">
            <el-link
              href="http://www.ky.zstu.edu.cn/index/xyxw.htm"
              target="_blank"
              class="link"
              :underline="false"
              icon="el-icon-s-claim"
            >最新校务通知</el-link>
          </el-col>
          <el-col :span="6">
            <el-link
              @click="jump('/students')"
              class="link"
              :underline="false"
              icon="el-icon-s-custom"
            >学生信息查询</el-link>
          </el-col>
          <el-col :span="6">
            <el-link
              @click="jump('/subjects')"
              class="link"
              :underline="false"
              icon="el-icon-s-order"
            >教师课程查询</el-link>
          </el-col>
      </el-row>
    </el-card>
    <!--卖家导航栏-->
    <el-card
            v-if="roleInfo.roleNameEn === 'saler'"
            class="card"
    >
      <el-row :gutter="20">
        <el-col :span="6">
          <div class="foot">快速入口:</div>
        </el-col>
        <el-col :span="6">
          <el-link
            href="http://www.ky.zstu.edu.cn/index/xyxw.htm"
            target="_blank"
            class="link"
            :underline="false"
            icon="el-icon-s-claim"
          >最新校务通知</el-link>
        </el-col>
        <el-col :span="6">
          <el-link
            @click="jump('/stuTranscripts')"
            class="link"
            :underline="false"
            icon="el-icon-s-custom"
          >学生成绩查询</el-link>
        </el-col>
        <el-col :span="6">
          <el-link
            @click="jump('/subjects')"
            class="link"
            :underline="false"
            icon="el-icon-s-order"
          >学生课程浏览</el-link>
        </el-col>
      </el-row>
    </el-card>
  </div>
</template>

<script>
  import school1 from '../assets/img/welcome/school1.jpg'
  import school2 from '../assets/img/welcome/school2.jpg'
  import school3 from '../assets/img/welcome/school3.jpg'
  import welcome1 from '../assets/img/welcome/welcome1.jpg'
  import welcome2 from '../assets/img/welcome/welcome2.jpeg'
  import {checkError, getCookie} from '../plugins/utils'

  export default {
    name: 'Welcome',
    data() {
      return {
        // 轮播图
        src: [
          welcome1,
          welcome2,
          school1,
          school2,
          school3
        ],
        // 开启加载
        loading: true,
        // 角色ID
        roleId: '',
        roleInfo: ''
      }
    },
    created() {
      this.roleId = getCookie('type')
      this.findRoleInfo()
    },
    methods: {
      // 点击按钮添加新用户
      async findRoleInfo() {
        const {data: res} = await this.$http.get(
                `role/selectById?roleId=${this.roleId}`,
        )
        if (res.code !== 200) {
          this.addDialogVisible = false
          return this.$message.error('查询角色失败' + checkError(res))
        } else {
          this.addDialogVisible = false
          this.$message.success('查询角色成功')
        }
        this.roleInfo = res.data
      },
      jump(activePath) {
        this.information.$emit('activePath', activePath)
        this.$router.push(activePath)
      },
      // 图片加载成功
      loadSuccess() {
        this.loading = false
      },
      // 图片加载失败
      loadError() {
      this.loading = false
    }
  }
}
</script>

<style lang="less" scoped>
  .title {
    font-size: 28px;
    font-weight: bold;
    margin-bottom: 6px;
    margin-top: -10px;
    cursor: default;
  }
  .foot {
    font-weight: bold;
    margin-top: -4px;
    text-align: center;
    cursor: default;
  }
  .link {
    margin-top: -14px;
    margin-left: 40px;
  }
  .card {
    margin-left: 34px;
    margin-right: 34px;
    margin-top: 10px;
    height: 50px;
  }
</style>
