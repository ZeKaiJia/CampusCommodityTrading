<template>
  <div>
    <!--面包屑导航区-->
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/home' }" @click.native="changeMenu('/')">首页</el-breadcrumb-item>
      <el-breadcrumb-item>订单查询</el-breadcrumb-item>
      <el-breadcrumb-item>我的订单</el-breadcrumb-item>
    </el-breadcrumb>
    <!--卡片视图区-->
    <el-card>
      <!--搜索与添加区域-->
      <el-row :gutter="20">
        <el-col :span="8">
          <el-input
            placeholder="请输入商品号"
            v-model="queryInfo.orderComId"
            @clear="getOrderList"
            clearable
          >
          <el-button
            slot="append"
            icon="el-icon-search"
          />
          </el-input>
        </el-col>
      </el-row>
      <!--用户列表区域-->
      <el-table
        :data="showOrderList"
        :header-cell-style="{background:'#eef1f6',color:'#606266'}"
        border
        v-loading="loading"
      >
        <!--拓展列-->
        <el-table-column type="expand" label="详细" width="64px" align="center">
          <template slot-scope="scope">
            <el-timeline>
              <el-timeline-item
                      size="large"
                      color="#0bbd87"
                      :key="scope.row.orderCreateTime"
                      :timestamp="scope.row.orderCreateTime">
                下单
              </el-timeline-item>
              <el-timeline-item
                      size="large"
                      :color="scope.row.orderStatus !== 1 ? '#0bbd87' : null"
                      :key="scope.row.orderTransportTime"
                      :timestamp="scope.row.orderTransportTime">
                发货
                <div v-if="scope.row.orderTransportCode !== null">
                  运单 - {{scope.row.orderTransportCode}}
                </div>
                <div v-if="scope.row.orderSalerAddress !== null">
                  地址 - {{scope.row.orderSalerAddress}}
                </div>
              </el-timeline-item>
              <el-timeline-item
                      size="large"
                      :color="scope.row.orderStatus === 3 ? '#0bbd87' : null"
                      :key="scope.row.orderReceiveTime"
                      :timestamp="scope.row.orderReceiveTime">
                收货
                <div v-if="scope.row.orderBuyerAddress !== null">
                  地址 - {{scope.row.orderBuyerAddress}}
                </div>
              </el-timeline-item>
            </el-timeline>
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
        <el-table-column label="原商品号" prop="orderComId" align="center"/>
        <el-table-column label="新商品号" prop="orderNewId" align="center"/>
        <el-table-column label="卖家名" prop="orderSalerName" align="center" v-if="userRole.roleNameEn !== 'saler'"/>
        <el-table-column label="买家名" prop="orderBuyerName" align="center" v-if="userRole.roleNameEn !== 'buyer'"/>
        <el-table-column label="状态" align="center">
          <template slot-scope="scope">
            <span>{{scope.row.orderStatus === 1 ? '已下单' : scope.row.orderStatus === 2 ? '已发货' : '已收货'}}</span>
          </template>
        </el-table-column>
        <el-table-column label="操作" align="center" width="180px">
          <template slot-scope="scope">
            <el-tooltip
              class="dark"
              effect="dark"
              content="发货"
              placement="top"
              :enterable="false"
              :hide-after="2000"
            >
              <!--发货按钮-->
              <el-button
                      type="primary"
                      icon="el-icon-truck"
                      size="mini"
                      @click="showTransport(scope.row.id)"
                      v-if="userRole.roleNameEn === 'admin' || userRole.roleNameEn === 'saler'"
                      round
              />
            </el-tooltip>
            <el-tooltip
                    class="dark"
                    effect="dark"
                    content="收货"
                    placement="top"
                    :enterable="false"
                    :hide-after="2000"
            >
              <!--收货按钮-->
              <el-button
                      type="primary"
                      icon="el-icon-map-location"
                      size="mini"
                      @click="receive(scope.row.id)"
                      v-if="userRole.roleNameEn === 'admin' || userRole.roleNameEn === 'buyer'"
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
    <!--发货的对话框-->
    <el-dialog
            title="发货"
            :visible.sync="updateDialogVisible"
            width="50%"
            @close="updateDialogClosed"
            style="margin-top: 100px"
    >
      <!--内容主题区域-->
      <el-form
              :model="updateForm"
              :rules="updateFormRules"
              ref="updateFormRef"
              label-width="100px"
              v-loading="dialogLoading"
      >
        <el-form-item label="运单号" prop="orderTransportCode">
          <el-input v-model="updateForm.orderTransportCode"/>
        </el-form-item>
        <el-form-item label="发货地址" prop="orderSalerAddress">
          <el-select v-model="updateForm.orderSalerAddress"
                     style="width: 100%"
                     placeholder="选择您的发货地址"
                     default-first-option>
            <el-option
                    v-for="item in addresses"
                    :key="item.id"
                    :label="item.address"
                    :value="item.address">
            </el-option>
          </el-select>
        </el-form-item>
      </el-form>
      <!--底部按钮区-->
      <span slot="footer" class="dialog-footer">
        <el-button @click="updateDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="transport">发 货</el-button>
      </span>
    </el-dialog>
    <!--回到顶部-->
    <el-backtop target=".el-main" :bottom="50">△</el-backtop>
  </div>
</template>

<script>
  import {checkError, getCookie, sliceData, timestampToTime} from '../../plugins/utils'

  export default {
    name: 'Orders',
    data() {
      return {
        addresses: [],
        updateDialogVisible: false,
        updateForm: {
          id: '',
          orderSalerAddress: '',
          orderStatus: '',
          orderTransportCode: ''
        },
        userRole: [],
        // 开启加载
        loading: true,
        dialogLoading: true,
        // 路由url
        routeUrl: '/orders',
        // 角色类型选择 TODO
        options: [],
        // 页面数据显示条数
        pageSize: 7,
        // 当前页数
        currentPage: 1,
        // 获取订单列表的参数对象
        queryInfo: {
          orderComId: ''
        },
        // 读取到的订单数据
        orderList: [],
        // 显示在 table 中的数据
        showOrderList: [],
        total: 0,
        // 控制修改订单对话框的显示
        editDialogVisible: false,
        // 修改用户的表单数据
        editForm: {
          orderStatus: null
        },
        updateFormRules: {
          orderTransportCode: [
            {required: true, message: '请输入快递运单号', trigger: 'blur'},
          ],
          orderSalerAddress: [
            {required: true, message: '请选择您的发货地址', trigger: 'change'}
          ]
        }
      }
  },
  created() {
    this.information.$emit('activePath', this.routeUrl)
    this.getCurrentUserRole()
    this.getOrderList()
  },
  methods: {
    // 监听发货对话框的关闭事件
    updateDialogClosed() {
      this.$refs.updateFormRef.resetFields()
    },
    // 显示发货对话框
    async showTransport(id) {
      const {data: res} = await this.$http.get(
              `order/selectById?id=${id}`
      )
      if (res.code !== 200) {
        return this.$message.error('查询订单信息失败' + checkError(res))
      }

      if (res.data.orderStatus === 3) {
        return this.$message.error('该订单已经收货')
      } else if (res.data.orderStatus === 2) {
        return this.$message.error('该订单已经发货')
      }

      const {data: add} = await this.$http.get(`address/selectByName?userName=${getCookie('ID')}`)
      if (add.code !== 200) {
        return this.$message.error('该用户没有配置地址!' + checkError(res))
      } else {
        this.addresses = add.data
      }


      this.updateForm = res.data
      this.updateDialogVisible = true
      this.dialogLoading = false
    },
    // 发货
    async transport() {
      this.$refs.updateFormRef.validate(async (valid) => {
        if (!valid) return this.$message.error('请填写正确的发货信息后再提交')
        this.dialogLoading = true
        this.updateForm.orderStatus = 2
        const { data: res } = await this.$http.post('order/update', this.updateForm)
        this.dialogLoading = false
        if (res.code !== 200) {
          this.updateDialogVisible = false
          this.$message.error('发货失败' + checkError(res))
        } else {
          this.updateDialogVisible = false
          await this.getOrderList()
          this.$message.success('发货成功')
        }
      })
    },
    async getCurrentUserRole() {
      const {data: res} = await this.$http.get(
              `role/selectById?roleId=${getCookie('type')}`
      )
      if (res.code !== 200) {
        return this.$message.error('查询角色信息失败' + checkError(res))
      }
      this.userRole = res.data
    },
    // 获取订单列表
    async getOrderList() {
      this.loading = true
      const { data: res } = await this.$http.get('order/select')
      if (res.code !== 200) {
        this.loading = false
        return this.$message.error('获取订单列表失败!' + checkError(res))
      }
      this.orderList = res.data
      for (let i = 0; i < this.orderList.length; i++) {
        this.orderList[i].orderCreateTime = timestampToTime(this.orderList[i].orderCreateTime)
        this.orderList[i].orderTransportTime = timestampToTime(this.orderList[i].orderTransportTime)
        this.orderList[i].orderReceiveTime = timestampToTime(this.orderList[i].orderReceiveTime)
      }
      // 根据当前页数和每页显示数控大小截取数据
      this.showOrderList = sliceData(this.orderList, this.currentPage, this.pageSize)
      if (this.showOrderList.length === 0) {
        this.currentPage = this.currentPage - 1
        this.showUsrList = sliceData(this.orderList, this.currentPage, this.pageSize)
      }
      this.total = res.data.length
      this.loading = false
    },
    // 面包屑导航切换
    changeMenu(activePath) {
      this.information.$emit('activePath', activePath)
    },
    // 当前页面显示数据条数改变事件
    // eslint-disable-next-line no-dupe-keys,vue/no-dupe-keys
    handleSizeChange (val) {
      this.pageSize = val
      // 根据当前页数和每页显示数控大小截取数据
      this.showUsrList = sliceData(this.orderList, this.currentPage, this.pageSize)
    },
    // 页码改变事件
    // eslint-disable-next-line no-dupe-keys,vue/no-dupe-keys
    handleCurrentChange (val) {
      this.currentPage = val
      // 根据当前页数和每页显示数控大小截取数据
      this.showUsrList = sliceData(this.orderList, this.currentPage, this.pageSize)
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
