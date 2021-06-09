<template>
  <div>
    <el-row type="flex" justify="center">
      <span class="title">{{this.roleInfo.roleNameCn}}端</span>
    </el-row>
    <el-row type="flex" justify="center">
      <el-carousel :interval="3000" arrow="always" height="75vh" style="width: 80vw">
        <el-carousel-item
                v-for="item in src"
                :key="item"
                v-loading="loading"
        >
          <el-image
                  :src="item"
                  style="height: 75vh"
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
                  @click="jump('/roles')"
                  class="link"
                  :underline="false"
                  icon="el-icon-share"
          >角色分配
          </el-link>
        </el-col>
        <el-col :span="6">
          <el-link
                  @click="jump('/users')"
                  class="link"
                  :underline="false"
                  icon="el-icon-s-custom"
          >用户管理
          </el-link>
        </el-col>
        <el-col :span="6">
          <el-link
                  @click="jump('/docs')"
                  class="link"
                  :underline="false"
                  icon="el-icon-s-promotion"
          >API文档
          </el-link>
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
                    @click="jump('/self')"
                    class="link"
                    :underline="false"
                    icon="el-icon-s-custom"
            >信息修改
            </el-link>
          </el-col>
          <el-col :span="6">
            <el-link
                    @click="jump('/buyCommodity')"
                    class="link"
                    :underline="false"
                    icon="el-icon-s-home"
            >商品市场
            </el-link>
          </el-col>
          <el-col :span="6">
            <el-link
                    @click="jump('/orders')"
                    class="link"
                    :underline="false"
                    icon="el-icon-s-order"
            >订单查询
            </el-link>
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
                  @click="jump('/self')"
                  class="link"
                  :underline="false"
                  icon="el-icon-s-custom"
          >信息修改
          </el-link>
        </el-col>
        <el-col :span="6">
          <el-link
                  @click="jump('/myCommodity')"
                  class="link"
                  :underline="false"
                  icon="el-icon-s-promotion"
          >发布商品
          </el-link>
        </el-col>
        <el-col :span="6">
          <el-link
                  @click="jump('/orders')"
                  class="link"
                  :underline="false"
                  icon="el-icon-s-order"
          >订单查询
          </el-link>
        </el-col>
      </el-row>
    </el-card>
  </div>
</template>

<script>
  import bigPic from '../assets/img/welcome/bigPic.jpeg'
  import bigPic1 from '../assets/img/welcome/bigPic1.jpeg'
  import bigPic2 from '../assets/img/welcome/bigPic2.jpeg'
  import bigPic3 from '../assets/img/welcome/bigPic3.jpeg'
  import bigPic4 from '../assets/img/welcome/bigPic4.jpeg'
  import {checkError, getCookie} from '../plugins/utils'

  export default {
    name: 'Welcome',
    data() {
      return {
        // 轮播图
        src: [
          bigPic,
          bigPic1,
          bigPic2,
          bigPic3,
          bigPic4
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
      // 查询用户角色信息
      async findRoleInfo() {
        const {data: res} = await this.$http.get(
                `role/selectById?roleId=${this.roleId}`,
        )
        if (res.code !== 200) {
          this.addDialogVisible = false
          return this.$message.error('查询角色失败' + checkError(res))
        } else {
          this.addDialogVisible = false
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
    margin-bottom: 12px;
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
