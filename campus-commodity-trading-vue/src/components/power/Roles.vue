<template>
  <div>
    <!--面包屑导航区-->
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/home' }" @click.native="changeMenu('/')">首页</el-breadcrumb-item>
      <el-breadcrumb-item>系统配置</el-breadcrumb-item>
      <el-breadcrumb-item>角色分配</el-breadcrumb-item>
    </el-breadcrumb>
    <!--卡片视图-->
    <el-card>
      <!--添加角色按钮区-->
      <el-row>
        <el-col :span="3">
          <el-button type="primary" @click="showAddDialog()">添加角色</el-button>
        </el-col>
      </el-row>
      <el-table
              :data="typeList"
              :header-cell-style="{background:'#eef1f6',color:'#606266'}"
              border
              stripe
      >
        <!--拓展列-->
        <el-table-column type="expand" label="详细" width="64px" align="center">
          <template slot-scope="scope">
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
        <el-table-column label="ID" prop="roleId" align="center" width="80px"/>
        <el-table-column label="中文名" prop="roleNameCn" align="center" width="160px"/>
        <el-table-column label="英文名" prop="roleNameEn" align="center"/>
        <el-table-column label="描述" prop="roleDescription" align="center"/>
        <el-table-column label="操作" width="340px" align="center">
          <template slot-scope="scope">
            <el-button
                    type="primary"
                    icon="el-icon-edit"
                    size="mini"
                    @click="showEditDialog(scope.row.roleId)"
            >编辑
            </el-button>
            <el-button
                    type="danger"
                    icon="el-icon-delete"
                    size="mini"
                    @click="removeRole(scope.row.roleId)"
            >删除
            </el-button>
            <el-button
                    type="warning"
                    icon="el-icon-setting"
                    size="mini"
                    @click="showManageDialog(scope.row.roleId)"
            >分配权限
            </el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-card>
    <!--添加角色的对话框-->
    <el-dialog
            title="添加角色"
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
        <el-form-item label="ID" prop="roleId">
          <el-input v-model="addForm.roleId"/>
        </el-form-item>
        <el-form-item label="中文名" prop="roleNameCn">
          <el-input v-model="addForm.roleNameCn"/>
        </el-form-item>
        <el-form-item label="英文名" prop="roleNameEn">
          <el-input v-model="addForm.roleNameEn"/>
        </el-form-item>
        <el-form-item label="描述" prop="roleDescription">
          <el-input v-model="addForm.roleDescription"/>
        </el-form-item>
      </el-form>
      <!--底部按钮区-->
      <span slot="footer" class="dialog-footer">
        <el-button @click="addDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="addRole">添 加</el-button>
      </span>
    </el-dialog>
    <!--修改用户的对话框-->
    <el-dialog
            title="修改角色"
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
      >
        <el-form-item label="ID" prop="roleId">
          <el-input v-model="editForm.roleId" disabled/>
        </el-form-item>
        <el-form-item label="中文名" prop="roleNameCn">
          <el-input v-model="editForm.roleNameCn" disabled/>
        </el-form-item>
        <el-form-item label="英文名" prop="roleNameEn">
          <el-input v-model="editForm.roleNameEn" disabled/>
        </el-form-item>
        <el-form-item label="描述" prop="roleDescription">
          <el-input v-model="editForm.roleDescription"/>
        </el-form-item>
      </el-form>
      <!--底部按钮区-->
      <span slot="footer" class="dialog-footer">
        <el-button @click="editDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="editRole">修 改</el-button>
      </span>
    </el-dialog>
    <!--分配权限的对话框-->
    <el-dialog
            title="分配权限"
            :visible.sync="manageDialogVisible"
            width="85%"
            @close="reset"
    >
      <div style="text-align: center" class="ddiv">
        <!--穿梭框候选区-->
        <el-transfer
                v-loading="loading"
                filterable
                style="text-align: left; display: inline-block"
                v-model="manageValue"
                :data="manageData"
                :titles="['未拥有', '已拥有']"
                :button-texts="['删权限', '加权限']"
                :format="{
            noChecked: '${total}',
            hasChecked: '${checked}/${total}'
          }"
                ref="myTransfer"
        />
      </div>
      <!--底部按钮区-->
      <span slot="footer" class="dialog-footer">
        <el-button @click="manageDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="manage">修 改</el-button>
      </span>
    </el-dialog>
    <!--&lt;!&ndash;提示对话框&ndash;&gt;
    <el-dialog
      title="提醒！"
      :visible.sync="infoDialogVisible"
      width="35%"
    >
      <li style="color: darkred">请不要删除所有管理员角色</li>
      <li>修改完权限后的用户重新登录即可生效</li>
      <li>anno为匿名权限，任何人都可以访问，无需添加</li>
      <span slot="footer" class="dialog-footer">
        <el-button type="primary" @click="infoDialogVisible = false">确 定</el-button>
      </span>
    </el-dialog>-->
    <!--回到顶部-->
    <transition name="bounce">
      <el-backtop :bottom="50" :right="50" :visibility-height="10">🚀</el-backtop>
    </transition>
  </div>
</template>

<script>
  import {checkError, timestampToTime} from '../../plugins/utils'

  export default {
    name: 'Roles',
    data() {
      // eslint-disable-next-line no-unused-vars
      const generateData = _ => {
        const data = [];
        const keys = ['添加用户', '删除用户', '修改用户', '查询用户', '添加角色', '删除角色',
          '修改角色', '查询角色']
        for (let i = 0; i < 8; i++) {
          data.push({
            key: i,
            label: keys[i]
          });
        }
        return data;
      };
      return {
        // 分配权限中所有的权限
        manageData: [],
        // 分配权限中已拥有的权限下标
        manageValue: [],
        dialogLoading: true,
        // 控制添加用户对话框的显示
        addDialogVisible: false,
        // 路由url
        routeUrl: '/roles',
        // 分配权限的加载动画
        loading: false,
        // 记录正在操作的角色
        manageRole: '',
        // 分配权限中已拥有的权限
        managePermission: [],
        // 控制分配权限对话框的显示
        manageDialogVisible: false,
        // 控制提示对话框的显示
        /*infoDialogVisible: false,*/
        // 角色列表
        typeList: [],
        // 角色总数
        total: 0,
        // 控制修改用户对话框的显示
        editDialogVisible: false,
        // 添加用户的表单数据
        addForm: {
          roleId: '',
          roleNameCn: '',
          roleNameEn: '',
          roleDescription: ''
        },
        // 修改用户的表单数据
        editForm: {
          roleId: '',
          roleNameCn: '',
          roleNameEn: '',
          roleDescription: ''
        },
        // 添加表单的验证规则对象
        addFormRules: {
          roleId: {required: true, message: '请输入ID', trigger: 'blur'},
          roleNameCn: [
            {required: true, message: '请输入中文名', trigger: 'blur'},
            {min: 2, max: 10, message: '长度在2到10个字符', trigger: 'blur'}
          ],
          roleNameEn: [
            {required: true, message: '请输入英文名', trigger: 'blur'},
            {min: 2, max: 10, message: '长度在2到10个字符', trigger: 'blur'}
          ],
          roleDescription: [
            {required: true, message: '请输入描述', trigger: 'blur'},
            {min: 2, max: 20, message: '长度在2到20个字符', trigger: 'blur'}
          ]
        },
        // 修改表单的验证规则对象
        editFormRules: {
          roleNameCn: [
            {required: true, message: '请输入中文名', trigger: 'blur'},
            {min: 2, max: 10, message: '长度在2到10个字符', trigger: 'blur'}
          ],
          roleNameEn: [
            {required: true, message: '请输入英文名', trigger: 'blur'},
            {min: 2, max: 10, message: '长度在2到10个字符', trigger: 'blur'}
          ],
          roleDescription: [
            {required: true, message: '请输入描述', trigger: 'blur'},
            {min: 2, max: 20, message: '长度在2到20个字符', trigger: 'blur'}
          ]
        }
      }
    },
    created() {
      this.information.$emit('activePath', this.routeUrl)
      this.getTypeList()
      /*setTimeout(() => {
        if (this.checkInfo() < 2) {
          this.infoDialogVisible = true
        }
      }, 1000)*/
    },
    methods: {
      // 检查提示信息出现次数
      /*checkInfo(){
        let times = getCookie('times')
        if (times === null || times === undefined || times === '') {
          setCookie('times', 1)
        } else {
          setCookie('times', Number(times) + 1)
        }
        return times
      },*/
      // 点击按钮删除用户信息
      async removeRole(roleId) {
        // 弹框询问
        const confirmResult = await this.$confirm(
                '此操作将永久删除该角色, 是否继续?',
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
        const { data: res } = await this.$http.post(`role/delete?roleId=${roleId}`)
        if (res.code !== 200) {
          return this.$message.error('删除角色失败' + checkError(res))
        }
        this.$message.success('删除角色成功')
        await this.getTypeList()
      },
      // 监听添加用户对话框的关闭事件
      addDialogClosed() {
        this.$refs.addFormRef.resetFields()
      },
      editDialogClosed() {
        this.$refs.editFormRef.resetFields()
      },
      // 获取角色列表
      async getTypeList() {
        const {data: res} = await this.$http.get('role/select')
        if (res.code !== 200) {
          return this.$message.error('获取角色列表失败!' + checkError(res))
        }
        this.typeList = res.data
        this.typeList.forEach(function (item) {
          item.utcCreate = timestampToTime(item.utcCreate)
          item.utcModify = timestampToTime(item.utcModify)
        })
        this.total = res.data.length
      },
      // 监听修改角色对话框的点击事件
      async showEditDialog(roleId) {
        const {data: res} = await this.$http.get(
                `role/selectById?roleId=${roleId}`
        )
        if (res.code !== 200) {
          return this.$message.error('查询角色信息失败' + checkError(res))
        }
        this.editForm = res.data
        this.editDialogVisible = true
      },
      showAddDialog() {
        this.addDialogVisible = true
        this.dialogLoading = false
      },
      // 点击按钮添加角色信息
      addRole() {
        this.$refs.addFormRef.validate(async (valid) => {
          if (!valid) return this.$message({message: '请填写正确的角色信息后提交！', type: 'error', customClass: 'zZindex'})
          const {data: res} = await this.$http.post(
                  'role/insert',
                  this.addForm
          )
          if (res.code !== 200) {
            this.addDialogVisible = false
            return this.$message.error('添加角色失败' + checkError(res))
          } else {
            this.addDialogVisible = false
            this.$message.success('修改角色成功')
          }
          await this.getTypeList()
        })
      },
      // 点击按钮修改角色信息
      editRole() {
        this.$refs.editFormRef.validate(async (valid) => {
          if (!valid) return this.$message({message: '请填写正确的角色信息后提交！', type: 'error', customClass: 'zZindex'})
          const {data: res} = await this.$http.post(
                  'role/update',
                  this.editForm
          )
          if (res.code !== 200) {
            this.editDialogVisible = false
            return this.$message.error('修改角色失败' + checkError(res))
          } else {
            this.editDialogVisible = false
            this.$message.success('修改角色成功')
          }
          await this.getTypeList()
        })
      },
      // 监听分配权限对话框的点击事件
      showManageDialog(roleId) {
        this.manageDialogVisible = true
        this.manageRole = roleId
        this.generateManage(roleId)
      },
      // 穿梭框数据初始化
      async generateManage(roleId) {
        this.manageValue = []
        this.manageData = []
        const {data: enablePermissions} = await this.$http.get(`permission/findPermissionByRoleId?roleId=${roleId}`)
        const {data: allPermissions} = await this.$http.get('permission/select')
        if (allPermissions.code !== 200) {
          return this.$message.error('获取权限列表失败!' + checkError(allPermissions))
        }
        this.managePermission = enablePermissions.data
        for (let i = 0; i < allPermissions.data.length; i++) {
          this.manageData.push({
            key: i,
            label: allPermissions.data[i].perName + ' ' + allPermissions.data[i].perCode,
            per: allPermissions.data[i].perCode
          })
        }
        if (enablePermissions.code === 200) {
          // eslint-disable-next-line no-unused-vars
          this.managePermission.forEach((permission, index) => {
            for (let i = 0; i < this.manageData.length; i++) {
              if (this.manageData[i].per === permission.perCode) {
                this.manageValue.push(i)
              }
            }
          })
        }
      },
      // 处理权限的变化
      async manage() {
        this.loading = true
        let permissionCodes = []
        for (let i = 0; i < this.manageValue.length; i++) {
          permissionCodes.push(this.manageData[this.manageValue[i]].per)
        }
        const {data: res} = await this.$http.post(
                `permission/managePermission?roleId=${this.manageRole}&permissionCodes=${permissionCodes}`
        )
        this.loading = false
        if (res.code !== 200) {
          this.manageDialogVisible = false
          return this.$message.error('分配权限失败!')
        }
        this.manageDialogVisible = false
        return this.$message.success('分配权限成功!')
      },
      // 重置穿梭框搜索数据
      reset() {
        if (this.$refs.myTransfer) {
          this.$refs.myTransfer.$children['0']._data.query = ''
          // 清空右边搜索
          this.$refs.myTransfer.$children['3']._data.query = ''
        }
      },
      // 面包屑导航切换
      changeMenu(activePath) {
        this.information.$emit('activePath', activePath)
      }
    }
}
</script>

<style lang="less" scoped>
  .el-transfer /deep/ .el-transfer-panel {
    width: 500px !important;
    height: 500px;
  }
  .ddiv /deep/ .el-transfer-panel__filter {
    width: 90%;
  }
  .ddiv /deep/ .el-transfer-panel__list.is-filterable {
    height: 75%;
  }
  .ddiv /deep/ .el-transfer-panel__body {
    height: 100%;
  }
  .el-tag {
    margin-left: 16px;
    margin-top: 6px;
    margin-bottom: 6px;
  }
</style>
