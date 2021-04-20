<template>
  <div class="login-container">
    <div class="back"></div>
    <div class="login-box">
      <!--头像区域-->
      <div class="avater-box">
        <i class="el-icon-s-goods"/>
      </div>
      <!--标题-->
      <div class="login-title">
        <span>校园二手商品交易平台</span>
      </div>
      <!--登录表单区-->
      <el-form
        label-width="0px"
        :model="loginForm"
        :rules="loginFormRules"
        ref="loginFormRef"
      >
        <!--用户名-->
        <el-form-item class="form-item" prop="userName">
          <el-input
            class="form-input"
            placeholder="账号"
            v-model="loginForm.userName"
            prefix-icon="el-icon-user"
          />
        </el-form-item>
        <!--密码-->
        <el-form-item class="form-item" prop="userPassword">
          <el-input
            show-password
            class="form-input"
            placeholder="密码"
            v-model="loginForm.userPassword"
            prefix-icon="el-icon-lock"
            type="password"
          />
        </el-form-item>
        <el-form-item class="form-item form-item2" prop="verifycode">
          <el-input
            v-model="loginForm.verifycode"
            placeholder="验证码"
            class="identifyinput form-input"
            prefix-icon="el-icon-key"
          />
        </el-form-item>
        <el-form-item>
          <div class="identifybox" style="display: flex; justify-content: center">
            <div @click="refreshCode">
              <s-identify :identifyCode="identifyCode"/>
            </div>
            <el-button @click="refreshCode" type='text' class="textbtn">看不清，换一张</el-button>
          </div>
        </el-form-item>
        <el-form-item class="form-button">
          <el-button type="primary" @click="submitLoginForm" style="margin-right: 18px; width: 210px">登录</el-button>
          <el-button type="info" @click="resetLoginForm" style="margin-left: 18px">重置</el-button>
        </el-form-item>
        <el-form-item style="justify-content: center; display: flex; margin-top: -16px">
          <el-button type="text" :underline="false" @click="showAddDialog">还没有账号，点此注册</el-button>
        </el-form-item>
      </el-form>
    </div>
    <!--添加用户的对话框-->
    <el-dialog
            title="注册新用户"
            :visible.sync="addDialogVisible"
            width="50%"
            @close="addDialogClosed"
    >
      <!--内容主题区域-->
      <el-form
              :model="addForm"
              :rules="addFormRules"
              ref="addFormRef"
              label-width="100px"
              v-loading="dialogLoading"
      >
        <el-form-item label="用户名" prop="userName">
          <el-input v-model="addForm.userName" />
        </el-form-item>
        <el-form-item label="密码" prop="userPassword">
          <el-input v-model="addForm.userPassword" />
        </el-form-item>
        <el-form-item label="姓名" prop="userNick">
          <el-input v-model="addForm.userNick" />
        </el-form-item>
        <el-form-item label="我是" prop="roleNameCn">
          <template>
            <el-select v-model="addForm.roleNameCn" placeholder="请选择">
              <el-option
                      v-for="item in options"
                      :key="item.value"
                      :label="item.label"
                      :value="item.value">
                <span style="float: left">{{ item.label }}</span>
                <span style="float: right; color: #8492a6; font-size: 13px">{{ item.value }}</span>
              </el-option>
            </el-select>
          </template>
        </el-form-item>
        <el-form-item label="联系电话" prop="userPhone">
          <el-input v-model.number="addForm.userPhone" type="number"/>
        </el-form-item>
        <el-form-item label="电子邮箱" prop="userEmail">
          <el-input v-model="addForm.userEmail" />
        </el-form-item>
      </el-form>
      <!--底部按钮区-->
      <span slot="footer" class="dialog-footer">
        <el-button @click="addDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="addUser">添 加</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import SIdentify from './util/Identify'
import {checkError, setCookie} from '../plugins/utils'
export default {
  name: 'login',
  data() {
    // 验证码自定义验证规则
    const validateVerifycode = (rule, value, callback) => {
      if (value === '') {
        callback(new Error('请输入验证码'))
      } else if (value !== this.identifyCode) {
        callback(new Error('验证码不正确!'))
      } else {
        callback()
      }
    }
    // 验证邮箱
    const checkEmail = (rule, value, callback) => {
      const regEmail = /^([a-zA-z0-9_-])+@([a-zA-Z0-9_-])+(\.[a-zA-Z0-9_-])+/
      if (regEmail.test(value)) {
        return callback()
      } else {
        callback(new Error('请输入合法的邮箱'))
      }
    }
    // 验证手机号
    const checkMobile = (rule, value, callback) => {
      const regMobile = /^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/
      if (regMobile.test(value)) {
        return callback()
      } else {
        callback(new Error('请输入合法的手机号'))
      }
    }
    return {
      options: [],
      dialogLoading: true,
      // 控制添加用户对话框的显示
      addDialogVisible: false,
      loginForm: {
        userName: '',
        userPassword: '',
        verifycode: ''
      },
      addForm: {
        userName: '',
        userPassword: '',
        userNick: '',
        userPhone: '',
        userEmail: '',
        roleNameCn: ''
      },
      identifyCodes: '1234567890',
      identifyCode: '',
      loginFormRules: {
        usrName: [
          { required: true, message: '请输入用户名', trigger: 'blur' },
          { min: 3, max: 10, message: '长度在3到10个字符', trigger: 'blur' }
        ],
        usrPassword: [
          { required: true, message: '请输入用户密码', trigger: 'blur' },
          { min: 3, max: 10, message: '长度在3到10个字符', trigger: 'blur' }
        ],
        verifycode: [
          { required: true, trigger: 'blur', validator: validateVerifycode }
        ]
      },
      // 添加表单的验证规则对象
      addFormRules: {
        userName: [
          { required: true, message: '请输入用户名', trigger: 'blur' },
          { min: 2, max: 10, message: '长度在2到10个字符', trigger: 'blur' }
        ],
        userPassword: [
          { required: true, message: '请输入用户密码', trigger: 'blur' },
          { min: 2, max: 10, message: '长度在2到10个字符', trigger: 'blur' }
        ],
        userNick: [
          { required: true, message: '请输入您的姓名', trigger: 'blur' },
          { min: 2, max: 10, message: '长度在2到10个字符', trigger: 'blur' }
        ],
        userPhone: [
          { required: true, message: '请输入用户联系电话', trigger: 'blur' },
          { validator: checkMobile, trigger: 'blur' }
        ],
        userEmail: [
          { required: true, message: '请输入用户电子邮箱', trigger: 'blur' },
          { validator: checkEmail, trigger: 'blur' }
        ],
        roleNameCn: [
          { required: true, message: '请选择用户角色类型', trigger: 'blur' }
        ]
      }
    }
  },
  components: {
    SIdentify
  },
  created() {
    this.getRoleList();
  },
  mounted() {
    // 验证码初始化
    this.identifyCode = ''
    this.makeCode(this.identifyCodes, 4)
  },
  methods: {
    showAddDialog () {
      this.addDialogVisible = true
      this.dialogLoading = false
    },
    // 获取角色列表
    async getRoleList() {
      const { data: res } = await this.$http.get('role/select')
      if (res.code !== 200) {
        return this.$message.error('获取角色列表失败!' + checkError(res))
      }
      for (let i = 0; i < res.data.length; i++) {
        if (res.data[i].roleNameEn === 'admin') {
          continue
        }
        await this.options.push({'label': res.data[i].roleNameEn, 'value': res.data[i].roleNameCn})
      }
    },
    resetLoginForm() {
      this.$refs.loginFormRef.resetFields()
    },
    submitLoginForm() {
      // BUG
      this.$refs.loginFormRef.validate(async (valid) => {
        if (!valid) {
          this.refreshCode()
          return this.$message.error('出错啦，再试一次')
        }
        // eslint-disable-next-line
        const { data: result } = await this.$http.post(
          'user/login',
          this.loginForm
        )
        if (result.code !== 200) {
          this.refreshCode()
          return this.$message.error(checkError(result) + '！请重试')
        } else {
          const { data: type } = await this.$http.get(`role/selectUserRole?userName=${result.data.userName}`)
          setCookie('type', type.data.roleId, 24 * 60 * 60)
          setCookie('user', result.data.userNick, 24 * 60 * 60)
          this.$message.success('欢迎您，' + result.data.userNick)
          await this.$router.push({ path: '/home' }, () => {}, () => {})
        }
      })
    },
    // 生成随机数
    randomNum(min, max) {
      return Math.floor(Math.random() * (max - min) + min)
    },
    // 切换验证码
    refreshCode() {
      this.identifyCode = ''
      this.makeCode(this.identifyCodes, 4)
    },
    // 生成四位随机验证码
    makeCode(o, l) {
      for (let i = 0; i < l; i++) {
        this.identifyCode += this.identifyCodes[
          this.randomNum(0, this.identifyCodes.length)
        ]
      }
    },
    // 监听添加用户对话框的关闭事件
    addDialogClosed() {
      this.$refs.addFormRef.resetFields()
    },
    // 点击按钮添加新用户
    addUser() {
      this.$refs.addFormRef.validate(async (valid) => {
        if (!valid) return this.$message.error('请填写正确的用户信息后再提交')
        this.dialogLoading = true
        const { data: res } = await this.$http.post(
                `user/insert?roleNameCn=${this.addForm.roleNameCn}`,
                this.addForm
        )
        this.dialogLoading = false
        if (res.code !== 200) {
          this.addDialogVisible = false
          return this.$message.error('添加用户失败' + checkError(res))
        } else {
          this.addDialogVisible = false
          this.$message.success('添加用户成功')
        }
      })
    },
  }
}
</script>

<style lang="less" scoped>
  .login-container {
    height: 100%;
    width: 100%;
    position: relative;
    background-color: #f6f6f6;
  }
  .back {
    background-image: url("../assets/img/login/login-back.jpeg");
    background-repeat: no-repeat;
    background-position: left bottom;
    height: 100%;
    width: 100%;
    position: absolute;
    transform: translate(5%, -8%);
  }
  .login-box {
    width: 500px;
    height: 460px;
    background-color: rgb(255, 255, 255);
    border-radius: 15px;
    position: absolute;
    left: 0;
    bottom: 0;
    transform: translate(160%, -28%);
    box-shadow: 0 4px 15px;

    .avater-box {
      height: 130px;
      width: 130px;
      border: 1px solid #eee;
      border-radius: 50%;
      padding: 6px;
      box-shadow: 0 0 10px #ddd;
      position: absolute;
      left: 50%;
      transform: translate(-50%, -80%);
      background-color: #fff;
      text-align: center;

      i {
        line-height: 120px;
        color: #405570;
        font-size: 110px;
        width: 100%;
        height: 100%;
        border-radius: 50%;
        background-color: #eee;
      }
    }

    .login-title {
      color: black;
      margin-top: 36px;
      font-size: 30px;
      font-weight: 200;
      text-align: center;
      span {
        border-bottom: 1.5px solid rgb(252, 114, 89);
      }
    }

    .form-item {
      margin-top: 24px;
      text-align: center;
      .form-input {
        border: 0;
        background: none;
        outline: 0;
        transition: 0.2s;
        width: 320px;
      }
    }
    .form-button {
      margin-top: -12px;
      text-align: center;
    }
  }
    .el-form /deep/ .el-form-item__error {
      color: #f56c6c;
      font-size: 12px;
      line-height: 1;
      padding-top: 4px;
      position: absolute;
      top: 110%;
      left: 0px !important;
    }
  .form-item2 /deep/ .el-form-item__error {
    color: #f56c6c;
    font-size: 12px;
    line-height: 1;
    padding-top: 4px;
    position: absolute;
    top: 110%;
    left: 90px !important;
  }
  .identifybox {
    display: flex;
    justify-content: space-between;
    margin-top:7px;
  }
  .textbtn {
    margin-left: 24px;
    margin-top: -12px;
  }
</style>
