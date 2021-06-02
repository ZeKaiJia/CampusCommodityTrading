<template>
  <div>
    <!--面包屑导航区-->
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/home' }" @click.native="changeMenu('/')">首页</el-breadcrumb-item>
      <el-breadcrumb-item>用户管理</el-breadcrumb-item>
      <el-breadcrumb-item>用户列表</el-breadcrumb-item>
    </el-breadcrumb>
    <!--卡片视图区-->
    <el-card>
      <!--搜索与添加区域-->
      <el-row :gutter="20">
        <el-col :span="8">
          <el-input
            placeholder="请输入用户名"
            v-model="queryInfo.userName"
            @clear="getUserList"
            clearable
          >
          <el-button
            slot="append"
            icon="el-icon-search"
            @click="selectUser"
          />
          </el-input>
        </el-col>
        <el-col :span="2">
          <el-button type="primary" @click="showAddDialog()"
          >添加用户
          </el-button
          >
        </el-col>
        <el-col :span="8">
          <el-alert
            title="测试时请不要删除或禁用所有管理员账户"
            style="min-width: 360px; max-width: 360px"
            type="warning"
            show-icon>
          </el-alert>
        </el-col>
        <el-col :span="6">
          <el-upload
                  style="float: right; margin-right: 12px"
                  :on-change="handleChange"
                  action=""
                  :limit="1"
                  :show-file-list="false"
                  :http-request="uploadUser"
                  accept=".xls,.xlsx">
            <el-button type="primary">批量导入</el-button>
          </el-upload>
        </el-col>
      </el-row>
      <!--用户列表区域-->
      <el-table
              :data="showUsrList"
              :header-cell-style="{background:'#eef1f6',color:'#606266'}"
              border
              v-loading="loading"
      >
        <!--拓展列-->
        <el-table-column type="expand" label="详细" width="64px" align="center">
          <template slot-scope="scope">
            <el-row v-if="scope.row.userLastLogin !== null && scope.row.userLastLogin !== ''">
              <el-col :span="3" align="right">
                <el-tag type="info" effect="plain">
                  最近登录
                </el-tag>
              </el-col>
              <el-col :span="10">
                <el-tag type="info" effect="plain">
                  {{scope.row.userLastLogin}}
                </el-tag>
              </el-col>
            </el-row>
            <el-row v-if="scope.row.utcCreate !== null && scope.row.utcCreate !== ''">
              <el-col :span="3" align="right">
                <el-tag type="info" effect="plain">
                  创建时间
                </el-tag>
              </el-col>
              <el-col :span="10">
                <el-tag type="info" effect="plain">
                  {{scope.row.utcCreate}}
                </el-tag>
              </el-col>
            </el-row>
            <el-row v-if="scope.row.utcModify !== null && scope.row.utcModify !== ''">
              <el-col :span="3" align="right">
                <el-tag type="info" effect="plain">
                  修改时间
                </el-tag>
              </el-col>
              <el-col :span="10">
                <el-tag type="info" effect="plain">
                  {{scope.row.utcModify}}
                </el-tag>
              </el-col>
            </el-row>
            <el-row v-if="scope.row.modifyBy !== null && scope.row.modifyBy !== ''">
              <el-col :span="3" align="right">
                <el-tag type="info" effect="plain">
                  修改人
                </el-tag>
              </el-col>
              <el-col :span="10">
                <el-tag type="info" effect="plain">
                  {{scope.row.modifyBy}}
                </el-tag>
              </el-col>
            </el-row>
            <el-row v-if="scope.row.remark !== null && scope.row.remark !== ''">
              <el-col :span="3" align="right">
                <el-tag type="info" effect="plain">
                  备注
                </el-tag>
              </el-col>
              <el-col :span="10">
                <el-tag type="info" effect="plain">
                  {{scope.row.remark}}
                </el-tag>
              </el-col>
            </el-row>
          </template>
        </el-table-column>
        <!--索引列-->
        <el-table-column label="序号" width="58px" align="center">
          <template slot-scope="scope">
            <span>{{scope.$index+(currentPage - 1) * pageSize + 1}}</span>
          </template>
        </el-table-column>
        <el-table-column label="用户名" prop="userName" align="center"/>
        <el-table-column label="密码" align="center" width="160px">
          <template slot-scope="scope">
            <span>{{showPassword ?
              (scope.row.userName === checkPassUser ? scope.row.userPassword + ' '  : '******** ')
              : '******** '}}</span>
            <el-button
              icon="el-icon-view"
              type="text"
              @click="checkPassword(scope.row)"
            />
          </template>
        </el-table-column>
        <el-table-column label="姓名" prop="userNick" align="center" width="160px"/>
        <el-table-column label="性别" prop="userGender" align="center" width="80px"/>
        <el-table-column label="联系电话" align="center" width="130px">
          <template slot-scope="scope">
            <span>{{scope.row.userPhone === null ? '暂无信息' : scope.row.userPhone}}</span>
          </template>
        </el-table-column>
        <el-table-column label="电子邮箱" prop="userEmail" align="center">
          <template slot-scope="scope">
            <span>{{scope.row.userEmail === null ? '暂无信息' : scope.row.userEmail}}</span>
          </template>
        </el-table-column>
        <el-table-column label="操作" align="center" width="180px">
          <template slot-scope="scope">
            <el-tooltip
              class="dark"
              effect="dark"
              content="修改信息"
              placement="top"
              :enterable="false"
              :hide-after="2000"
            >
              <!--修改按钮-->
              <el-button
                type="primary"
                icon="el-icon-edit"
                size="mini"
                @click="showEditDialog(scope.row.userName)"
                round
              />
            </el-tooltip>
            <el-tooltip
              class="dark"
              effect="dark"
              content="删除用户"
              placement="top"
              :enterable="false"
              :hide-after="2000"
            >
              <!--删除按钮-->
              <el-button
                type="danger"
                icon="el-icon-delete"
                size="mini"
                @click="removeUserByName(scope.row.userName)"
                round
              />
            </el-tooltip>
          </template>
        </el-table-column>
      </el-table>
      <!--显示分页信息-->
      <el-pagination
        @size-change="handleSizeChange"
        @current-change="handleCurrentChange"
        :current-page.sync="currentPage"
        :page-sizes="[1, 5, 7, 10, 30, 50, 100]"
        :page-size="pageSize"
        layout="total, sizes, prev, pager, next, jumper"
        :total="total">
      </el-pagination>
    </el-card>
    <!--添加用户的对话框-->
    <el-dialog
            title="添加用户"
            :visible.sync="addDialogVisible"
            width="50%"
            @close="addDialogClosed"
            style="margin-top: -50px"
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
        <el-form-item label="性别" prop="userGender">
          <el-radio-group v-model="addForm.userGender" size="small">
            <el-radio-button label="男"></el-radio-button>
            <el-radio-button label="女"></el-radio-button>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="角色" prop="roleNameCn">
          <template>
            <el-select v-model="addForm.roleNameCn" placeholder="请选择">
              <el-option
                      v-for="item in roleOptions"
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
        <el-form-item label="密保问题" prop="userQuest">
          <el-select v-model="addForm.userQuest" placeholder="请选择">
            <el-option
                    v-for="item in findOptions"
                    :key="item.value"
                    :label="item.value"
                    :value="item.value">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="密保答案" prop="userAnswer">
          <el-input v-model="addForm.userAnswer" />
        </el-form-item>
      </el-form>
      <!--底部按钮区-->
      <span slot="footer" class="dialog-footer">
        <el-button @click="addDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="addUser">添 加</el-button>
      </span>
    </el-dialog>
    <!--修改用户的对话框-->
    <el-dialog
      title="修改用户"
      :visible.sync="editDialogVisible"
      width="50%"
      @close="editDialogClosed"
    >
      <!--内容主题区域-->
      <el-form
        :model="editForm"
        :rules="editFormRules"
        ref="editFormRef"
        label-width="100px"
        v-loading="dialogLoading"
      >
        <el-form-item label="用户名" prop="userName">
          <el-input v-model="editForm.userName" disabled/>
        </el-form-item>
        <el-form-item label="密码" prop="userPassword">
          <el-input v-model="editForm.userPassword" />
        </el-form-item>
        <el-form-item label="姓名" prop="userNick">
          <el-input v-model="editForm.userNick" />
        </el-form-item>
        <el-form-item label="性别" prop="userGender">
          <el-radio-group v-model="editForm.userGender" size="small">
            <el-radio-button label="男"></el-radio-button>
            <el-radio-button label="女"></el-radio-button>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="角色" prop="roleNameCn">
          <template>
            <el-select v-model="editForm.roleNameCn" placeholder="请选择">
              <el-option
                      v-for="item in roleOptions"
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
          <el-input v-model.number="editForm.userPhone" type="number"/>
        </el-form-item>
        <el-form-item label="电子邮箱" prop="userEmail">
          <el-input v-model="editForm.userEmail" />
        </el-form-item>
      </el-form>
      <!--底部按钮区-->
      <span slot="footer" class="dialog-footer">
        <el-button @click="editDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="editUser">修 改</el-button>
      </span>
    </el-dialog>
    <!--回到顶部-->
    <transition name="bounce">
      <el-backtop :bottom="50" :right="50" :visibility-height="10">🚀</el-backtop>
    </transition>
  </div>
</template>

<script>
  import {checkError, getCookie, sliceData, timestampToTime} from '../../plugins/utils'

  export default {
  name: 'Users',
  data() {
    // 验证邮箱
    const checkEmail = (rule, value, callback) => {
      const regEmail = /^([a-zA-z0-9_-])+@([a-zA-Z0-9_-])+(\.[a-zA-Z0-9_-])+/
      if (regEmail.test(value) || value === null) {
        return callback()
      } else {
        callback(new Error('请输入合法的邮箱'))
      }
    }
    // 验证密码
    const checkPass = (rule, value, callback) => {
      if (value !== '********') {
        return callback()
      } else {
        callback(new Error('请输入正确的密码'))
      }
    }
    // 验证手机号
    const checkMobile = (rule, value, callback) => {
      const regMobile = /^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/
      if (regMobile.test(value) || value === null) {
        return callback()
      } else {
        callback(new Error('请输入合法的手机号'))
      }
    }
    return {
      findOptions: [{
        value: '您的大学叫什么？'
      }, {
        value: '您的电子邮箱是？'
      }, {
        value: '您的生日是几月几日？'
      }, {
        value: '您最好的朋友叫什么？'
      }, {
        value: '您的职业是什么？'
      }],
      // 开启加载
      loading: true,
      dialogLoading: true,
      // 路由url
      routeUrl: '/users',
      roleOptions: [],
      // 获取密码用户
      checkPassUser: '',
      // 显示密码
      showPassword: false,
      // 页面数据显示条数
      pageSize: 7,
      // 当前页数
      currentPage: 1,
      // 获取用户列表的参数对象
      queryInfo: {
        userName: ''
      },
      // 读取到的用户数据
      userList: [],
      // 显示在 table 中的数据
      showUsrList: [],
      total: 0,
      // 控制添加用户对话框的显示
      addDialogVisible: false,
      // 控制修改用户对话框的显示
      editDialogVisible: false,
      fileList: [],
      // 添加用户的表单数据
      addForm: {
        userName: '',
        userPassword: '',
        userNick: '',
        userGender: '',
        userPhone: null,
        userEmail: null,
        roleNameCn: ''
      },
      // 修改用户的表单数据
      editForm: {
        userName: '',
        userPassword: '',
        userNick: '',
        userGender: '',
        userPhone: '',
        userEmail: '',
        roleNameCn: ''
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
        userGender: [
          { required: true, message: '请选择您的性别', trigger: 'blur' }
        ],
        userPhone: [
          { validator: checkMobile, trigger: 'blur' }
        ],
        userEmail: [
          { validator: checkEmail, trigger: 'blur' }
        ],
        roleNameCn: [
          { required: true, message: '请选择用户角色类型', trigger: 'blur' }
        ],
        userQuest: [
          { required: true, message: '请选择密保问题', trigger: 'blur' }
        ],
        userAnswer: [
          { required: true, message: '请输入密保答案', trigger: 'blur' },
          { min: 2, max: 20, message: '长度在2到20个字符', trigger: 'blur' }
        ]
      },
      editFormRules: {
        userPassword: [
          { validator: checkPass, trigger: 'blur' },
          { required: true, message: '请输入用户密码', trigger: 'blur' },
          { min: 2, max: 10, message: '长度在2到10个字符', trigger: 'blur' }
        ],
        userNick: [
          { required: true, message: '请输入您的姓名', trigger: 'blur' },
          { min: 2, max: 10, message: '长度在2到10个字符', trigger: 'blur' }
        ],
        userGender: [
          { required: true, message: '请选择您的性别', trigger: 'blur' }
        ],
        userPhone: [
          { validator: checkMobile, trigger: 'blur' }
        ],
        userEmail: [
          { validator: checkEmail, trigger: 'blur' }
        ],
        roleNameCn: [
          { required: true, message: '请选择用户角色类型', trigger: 'blur' }
        ]
      }
    }
  },
  created() {
    this.information.$emit('activePath', this.routeUrl)
    this.getRoleList()
    this.getUserList()
  },
  methods: {
    // eslint-disable-next-line no-unused-vars
    async uploadUser(file, fileList) {
      this.loading = true
      const param = new FormData()
      param.append('excelFile', file.file)
      const {data: res} = await this.$http.post('upload/importExcel', param)
      if (res.code !== 200) {
        return this.$message.error('导入失败')
      } else {
        await this.getUserList()
        return this.$message.success('导入成功')
      }
      /*const {data: res} = await this.$http.post(
              '/upload/saveImg',
              param
      )
      if (res.code !== 200 || res.status === 500) {
        this.loading = false
        return this.$message.error('文件大小不能超过1M且只能上传一张')
      }*/
    },
    handleChange(file, fileList) {
      this.fileList = fileList.slice(-1)
    },
    // 获取角色列表
    async getRoleList() {
      const {data: res} = await this.$http.get('role/select')
      if (res.code !== 200) {
        return this.$message.error('获取角色列表失败!' + checkError(res))
      }
      for (let i = 0; i < res.data.length; i++) {
        await this.roleOptions.push({'label': res.data[i].roleNameEn, 'value': res.data[i].roleNameCn})
      }
    },
    // 获取用户列表
    async getUserList() {
      this.loading = true
      const {data: res} = await this.$http.get('user/select')
      if (res.code !== 200) {
        this.loading = false
        return this.$message.error('获取用户列表失败!' + checkError(res))
      }
      this.userList = res.data
      this.userList.forEach(function (item) {
        item.userLastLogin = timestampToTime(item.userLastLogin)
        item.utcCreate = timestampToTime(item.utcCreate)
        item.utcModify = timestampToTime(item.utcModify)
      })
      // 根据当前页数和每页显示数控大小截取数据
      this.showUsrList = sliceData(this.userList, this.currentPage, this.pageSize)
      if (this.showUsrList.length === 0) {
        this.currentPage = this.currentPage - 1
        this.showUsrList = sliceData(this.userList, this.currentPage, this.pageSize)
      }
      this.total = res.data.length
      this.loading = false
    },
    // 查找用户
    async selectUser() {
      this.loading = true
      const { data: res } = await this.$http.get('user/selectByName', {
        params: this.queryInfo
      })
      if (res.code !== 200) {
        this.loading = false
        return this.$message.error('获取用户列表失败!' + checkError(res))
      }
      this.userList = []
      this.userList.push(res.data)
      // 定向搜索只可能查询到一条记录
      this.showUsrList = this.userList
      this.total = res.data.length
      this.loading = false
    },
    // 查看用户密码
    checkPassword(data) {
      this.checkPassUser = getCookie("ID")
      if (this.checkPassUser === data.userName || this.checkPassUser === '') {
        this.showPassword = !this.showPassword
      } else {
        return this.$message.error('不能查看其它用户的密码!')
      }
    },
    // 监听添加用户对话框的关闭事件
    addDialogClosed() {
      this.$refs.addFormRef.resetFields()
    },
    editDialogClosed() {
      this.$refs.editFormRef.resetFields()
    },
    // 点击按钮添加新用户
    addUser() {
      this.$refs.addFormRef.validate(async (valid) => {
        if (!valid) return this.$message({message: '请填写正确的用户信息后提交！', type: 'error', customClass: 'zZindex'})
        this.dialogLoading = true
        const { data: res } = await this.$http.post(
          `user/insert?roleNameCn=${this.addForm.roleNameCn}&status=1`,
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
        await this.getUserList()
      })
    },
    // 点击按钮修改用户信息
    async editUser() {
      this.$refs.editFormRef.validate(async (valid) => {
        if (!valid) return this.$message({message: '请填写正确的用户信息后提交！', type: 'error', customClass: 'zZindex'})
        this.dialogLoading = true
        const { data: res } = await this.$http.post(
          `user/update?roleNameCn=${this.editForm.roleNameCn}&status=0`,
          this.editForm
        )
        this.dialogLoading = false
        if (res.code !== 200) {
          this.editDialogVisible = false
          return this.$message.error('修改用户失败' + checkError(res))
        } else {
          this.editDialogVisible = false
          this.$message.success('修改用户成功')
        }
        await this.getUserList()
      })
    },
    // 点击按钮删除用户信息
    async removeUserByName(userName) {
      // 弹框询问
      const confirmResult = await this.$confirm(
        '此操作将永久删除该用户, 是否继续?',
        '⚠️警告',
        {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }
      ).catch((err) => err)
      // 取消操作返回cancel字符串
      // 确认操作返回confirm字符串
      if (confirmResult !== 'confirm') {
        return this.$message.info('已撤回删除操作')
      }
      const { data: res } = await this.$http.post(`user/delete?userName=${userName}`)
      if (res.code !== 200) {
        return this.$message.error('删除用户失败' + checkError(res))
      }
      this.$message.success('删除用户成功')
      await this.getUserList()
    },
    // 监听修改用户对话框的点击事件
    async showEditDialog(userName) {
      const { data: res } = await this.$http.get(
        `user/selectByName?userName=${userName}`
      )
      if (res.code !== 200) {
        return this.$message.error('查询用户信息失败' + checkError(res))
      }
      // 获取角色信息
      const { data: type } = await this.$http.get(`role/selectUserRole?userName=${res.data.userName}`)
      if (type.code === 404) {
        res.data.roleNameCn = ''
      } else {
        res.data.roleNameCn = type.data.roleNameCn
      }
      this.editForm = res.data
      if (getCookie('ID') !== userName) {
        this.editForm.userPassword = '********'
      }
      this.editDialogVisible = true
      this.dialogLoading = false
    },
    showAddDialog () {
      this.addDialogVisible = true
      this.dialogLoading = false
    },
    // 当前页面显示数据条数改变事件
    // eslint-disable-next-line no-dupe-keys,vue/no-dupe-keys
    handleSizeChange (val) {
      this.pageSize = val
      // 根据当前页数和每页显示数控大小截取数据
      this.showUsrList = sliceData(this.userList, this.currentPage, this.pageSize)
    },
    // 页码改变事件
    // eslint-disable-next-line no-dupe-keys,vue/no-dupe-keys
    handleCurrentChange (val) {
      this.currentPage = val
      // 根据当前页数和每页显示数控大小截取数据
      this.showUsrList = sliceData(this.userList, this.currentPage, this.pageSize)
    },
    // 面包屑导航切换
    changeMenu(activePath) {
      this.information.$emit('activePath', activePath)
    }
  }
}
</script>

<style lang="less" scoped>
    @import '../../assets/css/table.css';
  .el-form-item__error {
    color: #f56c6c;
    font-size: 12px;
    line-height: 1;
    padding-top: 4px;
    position: absolute;
    top: 116%;
    left: 0;
  }
  .el-tag {
    margin-left: 16px;
    margin-top: 6px;
    margin-bottom: 6px;
  }
</style>
