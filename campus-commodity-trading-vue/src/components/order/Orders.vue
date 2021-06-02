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
            <el-row :gutter="20">
                <el-col :span="13" style="text-align: right">
                    <div class="centerFont">订单记录</div>
                </el-col>
                <el-col :span="11" style="text-align: right">
                    <el-button v-if="!searchFlag" type="text" icon="el-icon-arrow-down" circle
                               style="margin-top: 4px; font-size: 32px; padding: 0"
                               @click="searchFlag = !searchFlag"></el-button>
                    <el-button v-if="searchFlag" type="text" icon="el-icon-arrow-up" circle
                               style="margin-top: 4px; font-size: 32px; padding: 0"
                               @click="searchFlag = !searchFlag"></el-button>
                </el-col>
            </el-row>
            <transition name="fadeY">
                <el-row v-if="searchFlag">
                    <el-card>
                        <!--搜索与添加区域-->
                        <el-form v-model="queryInfo" label-width="10px">
                            <el-row :gutter="10">
                                <el-col :span="6">
                                    <el-form-item prop="orderComId">
                                        <el-input
                                                v-model="queryInfo.orderComId"
                                                placeholder="请输入商品号"
                                                clearable>
                                        </el-input>
                                    </el-form-item>
                                </el-col>
                                <!--<el-col :span="6">
                                    <el-form-item prop="orderNewId">
                                        <el-input
                                                v-model="queryInfo.orderNewId"
                                                placeholder="请输入新商品号"
                                                clearable>
                                        </el-input>
                                    </el-form-item>
                                </el-col>-->
                                <el-col :span="6">
                                    <el-form-item prop="orderTransportCode">
                                        <el-input
                                                v-model="queryInfo.orderTransportCode"
                                                placeholder="请输入运单号"
                                                clearable>
                                        </el-input>
                                    </el-form-item>
                                </el-col>
                                <el-col :span="4">
                                    <el-form-item prop="orderStatus">
                                        <el-select v-model="queryInfo.orderStatus" placeholder="请选择订单状态">
                                            <el-option
                                                    v-for="item in statusOptions"
                                                    :key="item.value"
                                                    :label="item.label"
                                                    :value="item.value">
                                            </el-option>
                                        </el-select>
                                    </el-form-item>
                                </el-col>
                                <el-col :span="4">
                                    <el-form-item prop="orderPayStatus">
                                        <el-select v-model="queryInfo.orderPayStatus" placeholder="请选择付款状态">
                                            <el-option
                                                    v-for="item in payOptions"
                                                    :key="item.value"
                                                    :label="item.label"
                                                    :value="item.value">
                                            </el-option>
                                        </el-select>
                                    </el-form-item>
                                </el-col>
                                <el-col :span="3">
                                    <el-button type="primary" @click="selectOrder()" style="float: right;">搜索订单
                                    </el-button>
                                </el-col>
                                <el-col :span="1">
                                    <el-button type="text" icon="el-icon-refresh" circle
                                               style="font-size: 32px; padding-top: 4px; margin-left: 12px"
                                               @click="resetQueryInfo"></el-button>
                                </el-col>
                            </el-row>
                        </el-form>
                    </el-card>
                </el-row>
            </transition>
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
                        <el-timeline class="middleFont">
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
                                <div v-if="scope.row.orderTransportCode !== null" class="middleFont">
                                    运单 - {{scope.row.orderTransportCode}}
                                </div>
                                <div v-if="scope.row.orderSalerAddress !== null" class="middleFont">
                                    地址 - {{scope.row.orderSalerAddress}}
                                </div>
                            </el-timeline-item>
                            <el-timeline-item
                                    size="large"
                                    :color="scope.row.orderStatus === 3 ? '#0bbd87' : null"
                                    :key="scope.row.orderReceiveTime"
                                    :timestamp="scope.row.orderReceiveTime">
                                收货
                                <div v-if="scope.row.orderBuyerAddress !== null" class="middleFont">
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
                <el-table-column label="商品号" prop="orderComId" align="center"/>
                <el-table-column label="卖家名" prop="orderSalerName" align="center"
                                 v-if="userRole.roleNameEn !== 'saler'"/>
                <el-table-column label="买家名" prop="orderBuyerName" align="center"
                                 v-if="userRole.roleNameEn !== 'buyer'"/>
                <el-table-column label="订单状态" align="center">
                    <template slot-scope="scope">
                        <span>{{scope.row.orderStatus === 1 ? '已下单' : scope.row.orderStatus === 2 ? '已发货' : '已收货'}}</span>
                    </template>
                </el-table-column>
                <el-table-column label="付款状态" align="center">
                    <template slot-scope="scope">
                        <span>{{scope.row.orderPayStatus === 1 ? '已付款' : '未付款'}}</span>
                    </template>
                </el-table-column>
                <el-table-column label="到期时间/租赁时间" align="center">
                    <template slot-scope="scope">
                        <span>{{scope.row.orderStatus === 3 ? scope.row.orderTime : (scope.row.orderTime * 1.0 / 86400000 + '天')}}</span>
                    </template>
                </el-table-column>
                <el-table-column label="操作" align="center" width="200px">
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
                                    @click="showReceive(scope.row.id)"
                                    v-if="userRole.roleNameEn === 'admin' || userRole.roleNameEn === 'buyer'"
                                    round
                            />
                        </el-tooltip>
                        <el-tooltip
                                class="dark"
                                effect="dark"
                                content="付款"
                                placement="top"
                                :enterable="false"
                                :hide-after="2000"
                        >
                            <!--付款按钮-->
                            <el-button
                                    type="primary"
                                    icon="el-icon-sell"
                                    size="mini"
                                    @click="pay()"
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
        <!--收货的对话框-->
        <el-dialog
                title="收货"
                :visible.sync="receiveDialogVisible"
                width="70%"
                style="margin-top: -50px"
        >
            <el-steps :active="activeStep" finish-status="success" simple style="margin-top: 20px">
                <el-step title="确认商品信息"></el-step>
                <el-step title="填写个人信息"></el-step>
                <el-step title="扫码先付后租"></el-step>
                <el-step title="收货发布评价"></el-step>
            </el-steps>
            <el-card style="margin-top: 12px; text-align: center; height: 470px">
                <el-row>
                    <div style="font-size: 16px;">
                        发布您的评价，您的好评是给予卖家最大的支持
                        <el-rate
                                style="margin-top: 12px"
                                v-model="rate"
                                :icon-classes="iconClasses"
                                void-icon-class="el-icon-star-off"
                                :colors="['#99A9BF', '#F7BA2A', '#FF9900']"
                                show-score>
                        </el-rate>
                    </div>
                </el-row>
                <el-row style="margin-top: 24px; border-bottom: 24px">
                    <quill-editor ref="text" v-model="content" class="myQuillEditor"
                                  style="height: 300px"/>
                </el-row>
            </el-card>
            <!--底部按钮区-->
            <span slot="footer" class="dialog-footer">
                <el-button type="primary" @click="receive" v-if="activeStep === 3">发 布</el-button>
            </span>
        </el-dialog>
        <!--回到顶部-->
        <transition name="bounce">
            <el-backtop :bottom="50" :right="50" :visibility-height="10">🚀</el-backtop>
        </transition>
    </div>
</template>

<script>
    import {checkError, easyTimestamp, getCookie, sliceData, timestampToTime} from '../../plugins/utils'

    export default {
        name: 'Orders',
        data() {
            return {
                content: '',
                statusOptions: [{
                    value: 1,
                    label: '已下单'
                }, {
                    value: 2,
                    label: '已发货'
                }, {
                    value: 3,
                    label: '已收货'
                }],
                payOptions: [{
                    value: 1,
                    label: '已付款'
                }, {
                    value: 2,
                    label: '未付款'
                }],
                searchFlag: false,
                // 获取订单列表的参数对象
                queryInfo: {
                    id: '',
                    orderComId: '',
                    // orderNewId: '',
                    orderSalerName: '',
                    orderBuyerName: '',
                    orderTransportCode: '',
                    orderStatus: '',
                    orderPayStatus: ''
                },
                rate: null,
                iconClasses: ['el-icon-heavy-rain', 'el-icon-cloudy-and-sunny', 'el-icon-sunny'],
                activeStep: 3,
                addresses: [],
                receiveDialogVisible: false,
                updateDialogVisible: false,
                updateForm: {
                    id: '',
                    orderSalerAddress: '',
                    orderStatus: '',
                    orderTransportCode: '',
                    orderTime: ''
                },
                userRole: [],
                // 开启加载
                loading: true,
                dialogLoading: false,
                // 路由url
                routeUrl: '/orders',
                // 页面数据显示条数
                pageSize: 7,
                // 当前页数
                currentPage: 1,
                // 读取到的订单数据
                orderList: [],
                // 显示在 table 中的数据
                showOrderList: [],
                total: 0,
                // 控制修改订单对话框的显示
                editDialogVisible: false,
                // 收货时修改的两个商品
                receiveOld: [],
                receiveNew: [],
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
            this.getOrderList()
        },
        methods: {
            pay() {
                this.$message.error('系统暂未开通支付宝接口!')
            },
            async selectOrder() {
                await this.getCurrentUserRole()
                if (this.userRole.roleNameEn === 'buyer') {
                    this.queryInfo.orderBuyerName = getCookie('ID')
                } else if (this.userRole.roleNameEn === 'saler') {
                    this.queryInfo.orderSalerName = getCookie('ID')
                }
                this.loading = true
                const {data: res} = await this.$http.post(
                    'order/selectByAnyParam', this.queryInfo
                )
                this.loading = false
                if (res.code !== 200) {
                    this.showOrderList = []
                    return this.$message.error('查询订单信息失败' + checkError(res))
                }
                this.orderList = res.data
                for (let i = 0; i < this.orderList.length; i++) {
                    if (this.orderList[i].orderStatus === 3) {
                        this.orderList[i].orderTime = easyTimestamp(this.orderList[i].orderTime)
                    }
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
            resetQueryInfo() {
                Object.keys(this.queryInfo).forEach(key => this.queryInfo[key] = '')
                this.getOrderList()
            },
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
            },
            // 发货
            async transport() {
                this.$refs.updateFormRef.validate(async (valid) => {
                    if (!valid) return this.$message({message: '请填写正确的发货信息后提交！', type: 'error', customClass: 'zZindex'})
                    this.dialogLoading = true
                    this.updateForm.orderStatus = 2
                    const {data: res} = await this.$http.post('order/update', this.updateForm)
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
            // 显示收货对话框
            async showReceive(id) {
                // 获取订单信息
                const {data: res} = await this.$http.get(
                    `order/selectById?id=${id}`
                )
                if (res.code !== 200) {
                    return this.$message.error('查询订单信息失败' + checkError(res))
                }

                if (res.data.orderStatus === 3) {
                    return this.$message.error('该订单已经收货')
                } else if (res.data.orderStatus === 1) {
                    return this.$message.error('该订单还未发货')
                }
                this.updateForm = res.data

                // 获取新老商品信息
                const {data: oldCom} = await this.$http.get(
                    `commodity/selectById?comId=${res.data.orderComId}`
                )
                // const {data: newCom} = await this.$http.get(
                //     `commodity/selectById?comId=${res.data.orderNewId}`
                // )
                if (oldCom.code !== 200) {
                    this.receiveDialogVisible = true
                    this.receiveOld = null
                    return this.$message({message: '该商品已下架，您仍可进行评价', type: 'warning', customClass: 'zZindex'})
                }
                this.receiveOld = oldCom.data
                // this.receiveNew = newCom.data
                this.receiveDialogVisible = true
            },
            async receive() {
                // 新商品修改valid为true
                // this.receiveNew.valid = true
                // const {data: valid} = await this.$http.post(
                //     'commodity/update', this.receiveNew
                // )
                // if (valid.code !== 200) {
                //     this.receiveDialogVisible = false
                //     return this.$message.error('新商品发布失败' + checkError(valid))
                // }
                // 旧商品发布评价
                if (this.rate === null) {
                    this.$message.error('请填写评价!')
                } else {
                    if (this.receiveOld !== null) {
                        const {data: old} = await this.$http.post(
                            `commodity/updateRate?comId=${this.receiveOld.comId}&rate=${this.rate}`
                        )
                        this.rate = null
                        if (old.code !== 200) {
                            this.receiveDialogVisible = false
                            this.$message.error('发布评价失败' + checkError(old))
                        } else {
                            this.$message.success('发布评价成功')
                        }
                    }
                    this.updateForm.orderStatus = 3
                    const {data: res} = await this.$http.post('order/update', this.updateForm)
                    this.dialogLoading = false
                    if (res.code !== 200) {
                        this.receiveDialogVisible = false
                        this.$message.error('收货失败' + checkError(res))
                    } else {
                        this.receiveDialogVisible = false
                        await this.getOrderList()
                        this.$message.success('收货成功')
                    }
                }
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
                await this.getCurrentUserRole()
                Object.keys(this.queryInfo).forEach(key => this.queryInfo[key] = '')
                if (this.userRole.roleNameEn === 'buyer') {
                    this.queryInfo.orderBuyerName = getCookie('ID')
                } else if (this.userRole.roleNameEn === 'saler') {
                    this.queryInfo.orderSalerName = getCookie('ID')
                }
                this.loading = true
                const {data: res} = await this.$http.post('order/selectByAnyParam', this.queryInfo)
                if (res.code !== 200) {
                    this.loading = false
                    return this.$message.error('获取订单列表失败!' + checkError(res))
                }
                this.orderList = res.data
                for (let i = 0; i < this.orderList.length; i++) {
                    if (this.orderList[i].orderStatus === 3) {
                        this.orderList[i].orderTime = easyTimestamp(this.orderList[i].orderTime)
                    }
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
            handleSizeChange(val) {
                this.pageSize = val
                // 根据当前页数和每页显示数控大小截取数据
                this.showUsrList = sliceData(this.orderList, this.currentPage, this.pageSize)
            },
            // 页码改变事件
            // eslint-disable-next-line no-dupe-keys,vue/no-dupe-keys
            handleCurrentChange(val) {
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

    .fadeY-enter-active, .fadeY-leave-active {
        transition: all 1s;
    }

    .fadeY-enter, .fadeY-leave-to {
        opacity: 0;
        transform: translateY(-50px);
    }

    .centerFont {
        font-weight: bold;
        font-size: 28px;
        transform: translateY(50%);
    }

    .middleFont {
        font-size: 18px;
        margin-top: 6px;
        margin-bottom: 6px;
    }
</style>
