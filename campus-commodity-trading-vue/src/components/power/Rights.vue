<template>
  <div>
    <!--面包屑导航区-->
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/home' }" @click.native="changeMenu('/')">首页</el-breadcrumb-item>
      <el-breadcrumb-item>系统配置</el-breadcrumb-item>
      <el-breadcrumb-item>权限分配</el-breadcrumb-item>
    </el-breadcrumb>
    <!--卡片视图-->
    <el-card>
      <!--添加角色按钮区-->
      <el-row :gutter="10">
        <el-col :span="2">
          <el-button type="primary" style="float: right" @click="showAddDialog()">添加权限</el-button>
        </el-col>
        <el-col :span="2">
          <el-tooltip class="item" effect="light" placement="right" style="margin-top: 10px">
            <div slot="content">
              零级:公共权限<br/>
              一级:用户权限<br/>
              二级:管理权限<br/>
              三级:内部权限
            </div>
            <el-button style="padding: 0; border-color: white; float: left" circle>
              <i class="el-icon-info" style="font-size: 20px"/>
            </el-button>
          </el-tooltip>
        </el-col>
      </el-row>
      <el-table
              :data="showRightsList"
              :header-cell-style="{background:'#eef1f6',color:'#606266'}"
              border
              stripe
              v-loading="loading"
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
        <!--索引列-->
        <el-table-column label="序号" width="58px" align="center">
          <template slot-scope="scope">
            <span>{{scope.$index+(currentPage - 1) * pageSize + 1}}</span>
          </template>
        </el-table-column>
        <el-table-column label="名称" prop="perName" align="center" width="300px"/>
        <el-table-column label="内部代码" prop="perCode" align="center"/>
        <el-table-column label="接口路径" prop="perUrl" align="center"/>
        <el-table-column label="权限等级" prop="customa" align="center" width="130px">
          <template slot-scope="scope">
            <el-tag v-if="scope.row.customa === '0'" type="info">零级</el-tag>
            <el-tag type="success" v-else-if="scope.row.customa === '1'">一级</el-tag>
            <el-tag type="warning" v-else-if="scope.row.customa === '2'">二级</el-tag>
            <el-tag type="danger" v-else>三级</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="240px" align="center">
          <template slot-scope="scope">
            <el-button
                    type="primary"
                    icon="el-icon-edit"
                    size="mini"
                    @click="showEditDialog(scope.row.perId)"
            >编辑
            </el-button>
            <el-button
                    type="danger"
                    icon="el-icon-delete"
                    size="mini"
                    @click="removePermission(scope.row.perId)"
            >删除
            </el-button>
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
    <!--添加权限的对话框-->
    <el-dialog
            title="添加权限"
            :visible.sync="addDialogVisible"
            width="50%"
            @close="addDialogClosed"
            v-loading="dialogLoading"
    >
      <!--内容主题区域-->
      <el-form
              :model="addForm"
              :rules="addFormRules"
              ref="addFormRef"
              label-width="100px"
      >
        <el-form-item label="名称" prop="perName">
          <el-input v-model="addForm.perName"/>
        </el-form-item>
        <el-form-item label="内部代码" prop="perCode">
          <el-input v-model="addForm.perCode"/>
        </el-form-item>
        <el-form-item label="接口路径" prop="perUrl">
          <el-input v-model="addForm.perUrl"/>
        </el-form-item>
        <el-form-item label="权限等级" prop="customa">
          <el-select v-model="addForm.customa" placeholder="请选择">
            <el-option
                    v-for="item in permissionOptions"
                    :key="item.value"
                    :label="item.label"
                    :value="item.value">
              <span style="float: left">{{ item.label }}</span>
              <span style="float: right; color: #8492a6; font-size: 13px">{{ item.value }}</span>
            </el-option>
          </el-select>
        </el-form-item>
      </el-form>
      <!--底部按钮区-->
      <span slot="footer" class="dialog-footer">
        <el-button @click="addDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="addPermission">添 加</el-button>
      </span>
    </el-dialog>
    <!--修改权限的对话框-->
    <el-dialog
      title="修改权限"
      :visible.sync="editDialogVisible"
      width="50%"
      @close="editDialogClosed"
      v-loading="dialogLoading"
    >
      <!--内容主题区域-->
      <el-form
              :model="editForm"
              :rules="editFormRules"
              ref="editFormRef"
              label-width="100px"
      >
        <el-form-item label="名称" prop="perName">
          <el-input v-model="editForm.perName"/>
        </el-form-item>
        <el-form-item label="内部代码" prop="perCode">
          <el-input v-model="editForm.perCode"/>
        </el-form-item>
        <el-form-item label="接口路径" prop="perUrl">
          <el-input v-model="editForm.perUrl"/>
        </el-form-item>
        <el-form-item label="权限等级" prop="customa">
          <el-select v-model="editForm.customa" placeholder="请选择">
            <el-option
                    v-for="item in permissionOptions"
                    :key="item.value"
                    :label="item.label"
                    :value="item.value">
              <span style="float: left">{{ item.label }}</span>
              <span style="float: right; color: #8492a6; font-size: 13px">{{ item.value }}</span>
            </el-option>
          </el-select>
        </el-form-item>
      </el-form>
      <!--底部按钮区-->
      <span slot="footer" class="dialog-footer">
        <el-button @click="editDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="editPermission">修 改</el-button>
      </span>
    </el-dialog>
    <!--回到顶部-->
    <el-backtop target=".el-main" :bottom="50">△</el-backtop>
  </div>
</template>

<script>
  import {checkError, sliceData, timestampToTime} from '../../plugins/utils'

  export default {
    name: 'Rights',
    data() {
      return {
        // 开启加载
        loading: true,
        dialogLoading: true,
        // 路由url
        routeUrl: '/rights',
        // 权限等级选项
        permissionOptions: [{
          value: '3',
          label: '内部权限'
        }, {
          value: '2',
          label: '管理权限'
        }, {
          value: '1',
          label: '用户权限'
        }, {
          value: '0',
          label: '公共权限'
        }],
        // 控制修改权限对话框的显示
        editDialogVisible: false,
        // 控制添加权限对话框的显示
        addDialogVisible: false,
        // 页面数据显示条数
        pageSize: 7,
        // 当前页数
        currentPage: 1,
        // 读取到的权限数据
        rightsList: [],
        // 分页显示的权限数据
        showRightsList: [],
        total: 0,
        // 添加权限的表单数据
        addForm: {
          perName: '',
          perCode: '',
          perUrl: '',
          customa: ''
        },
        // 修改权限的表单数据
        editForm: {
          perName: '',
          perCode: '',
          perUrl: '',
          customa: ''
        },
        // 添加表单的验证规则对象
        addFormRules: {
          perName: [
            {required: true, message: '请输入名称', trigger: 'blur'}
          ],
          perCode: [
            {required: true, message: '请输入内部代码', trigger: 'blur'}
          ],
          perUrl: [
            {required: true, message: '请输入接口路径', trigger: 'blur'}
          ],
          customa: [
            {required: true, message: '请选择权限等级', trigger: 'change'}
          ]
        },
        // 修改表单的验证规则对象
        editFormRules: {
          perName: [
            {required: true, message: '请输入名称', trigger: 'blur'}
          ],
          perCode: [
            {required: true, message: '请输入内部代码', trigger: 'blur'}
          ],
          perUrl: [
            {required: true, message: '请输入接口路径', trigger: 'blur'}
          ],
          customa: [
            {required: true, message: '请选择权限等级', trigger: 'change'}
          ]
        }
    }
  },
  created() {
    this.information.$emit('activePath', this.routeUrl)
    this.getRightList()
  },
  methods: {
    // 获取权限列表
    async getRightList () {
      this.loading = true
      const {data: res} = await this.$http.get('permission/select')
      if (res.code !== 200) {
        this.loading = false
        return this.$message.error('获取权限列表失败!' + checkError(res))
      }
      this.rightsList = res.data
      this.rightsList.forEach(function (item) {
        item.utcCreate = timestampToTime(item.utcCreate)
        item.utcModify = timestampToTime(item.utcModify)
      })
      this.showRightsList = sliceData(this.rightsList, this.currentPage, this.pageSize)
      if (this.showRightsList.length === 0) {
        this.currentPage = this.currentPage - 1
        this.showRightsList = sliceData(this.rightsList, this.currentPage, this.pageSize)
      }
      this.total = res.data.length
      this.loading = false
    },
    // 监听修改权限对话框的点击事件
    async showEditDialog(perId) {
      const {data: res} = await this.$http.get(
              `permission/selectById?perId=${perId}`
      )
      if (res.code !== 200) {
        return this.$message.error('查询权限信息失败' + checkError(res))
      }
      this.editForm = res.data
      this.editDialogVisible = true
      this.dialogLoading = false
    },
    showAddDialog() {
      this.addDialogVisible = true
      this.dialogLoading = false
    },
    addPermission() {
      this.$refs.addFormRef.validate(async (valid) => {
        if (!valid) return this.$message.error('请填写正确的权限信息后再提交')
        this.dialogLoading = true
        const {data: res} = await this.$http.post(
                'permission/insert',
                this.addForm
        )
        this.dialogLoading = false
        if (res.code !== 200) {
          this.addDialogVisible = false
          return this.$message.error('添加权限失败' + checkError(res))
        } else {
          this.addDialogVisible = false
          this.$message.success('添加权限成功')
        }
        await this.getRightList()
      })
    },
    editPermission() {
      this.$refs.editFormRef.validate(async (valid) => {
        if (!valid) return this.$message.error('请填写正确的权限信息后再提交')
        this.dialogLoading = true
        const {data: res} = await this.$http.post(
                'permission/update',
                this.editForm
        )
        this.dialogLoading = false
        if (res.code !== 200) {
          this.editDialogVisible = false
          return this.$message.error('修改权限失败' + checkError(res))
        } else {
          this.editDialogVisible = false
          this.$message.success('修改权限成功')
        }
        await this.getRightList()
      })
    },
    // 当前页面显示数据条数改变事件
    // eslint-disable-next-line no-dupe-keys,vue/no-dupe-keys
    handleSizeChange(val) {
      this.pageSize = val
      // 根据当前页数和每页显示数控大小截取数据
      this.showRightsList = sliceData(this.rightsList, this.currentPage, this.pageSize)
    },
    // 页码改变事件
    // eslint-disable-next-line no-dupe-keys,vue/no-dupe-keys
    handleCurrentChange(val) {
      this.currentPage = val
      // 根据当前页数和每页显示数控大小截取数据
      this.showRightsList = sliceData(this.rightsList, this.currentPage, this.pageSize)
    },
    // 监听添加权限对话框的关闭事件
    addDialogClosed() {
      this.$refs.addFormRef.resetFields()
    },
    // 监听修改权限对话框的关闭事件
    editDialogClosed() {
      this.$refs.editFormRef.resetFields()
    },
    // 面包屑导航切换
    changeMenu(activePath) {
      this.information.$emit('activePath', activePath)
    },
    // 点击按钮删除用户信息
    async removePermission(perId) {
      // 弹框询问
      const confirmResult = await this.$confirm(
              '此操作将永久删除该权限, 是否继续?',
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
      const { data: res } = await this.$http.post(`permission/delete?perId=${perId}`)
      if (res.code !== 200) {
        return this.$message.error('删除权限失败' + checkError(res))
      }
      this.$message.success('删除权限成功')
      await this.getRightList()
    }
  }
}
</script>

<style lang="less" scoped>
  .el-col .el-tag {
    margin-left: 16px;
    margin-top: 6px;
    margin-bottom: 6px;
  }
</style>
