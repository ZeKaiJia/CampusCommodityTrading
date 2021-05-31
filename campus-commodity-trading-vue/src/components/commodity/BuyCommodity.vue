<template>
    <div>
        <!--面包屑导航区-->
        <el-breadcrumb separator-class="el-icon-arrow-right">
            <el-breadcrumb-item :to="{ path: '/home' }" @click.native="changeMenu('/')">首页</el-breadcrumb-item>
            <el-breadcrumb-item>商品管理</el-breadcrumb-item>
            <el-breadcrumb-item>购买商品</el-breadcrumb-item>
        </el-breadcrumb>
        <!--查询卡片区-->
        <el-card style="margin-top: 14px" v-loading="mainLoading">
            <el-row :gutter="20">
                <el-col :span="4">
                    <el-switch
                            style="display: block"
                            v-model="cardOrTable"
                            active-color="#13ce66"
                            inactive-color="#409EFF"
                            active-text="卡片"
                            inactive-text="表格">
                    </el-switch>
                </el-col>
                <el-col :span="9" style="text-align: right">
                    <div class="centerFont">二手商品库</div>
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
            <transition name="fadeY" mode="out-in">
                <el-row v-if="searchFlag">
                    <el-card>
                        <!--搜索与添加区域-->
                        <el-form v-model="queryInfo" label-width="10px">
                            <el-row :gutter="10">
                                <el-col :span="6">
                                    <el-form-item prop="comId">
                                        <el-input
                                                v-model="queryInfo.comId"
                                                placeholder="请输入商品号"
                                                clearable>
                                        </el-input>
                                    </el-form-item>
                                </el-col>
                                <el-col :span="6">
                                    <el-form-item prop="comName">
                                        <el-input
                                                v-model="queryInfo.comName"
                                                placeholder="请输入商品名"
                                                clearable>
                                        </el-input>
                                    </el-form-item>
                                </el-col>
                                <el-col :span="2"
                                        style="height: 38px; display: flex; justify-content: center; align-items: center; margin-left: 12px">
                                    <span>存货范围</span>
                                </el-col>
                                <el-col :span="2"
                                        style="height: 38px; display: flex; justify-content: center; align-items: center">
                                    {{queryInfo.quantity[0]}}~{{queryInfo.quantity[1]}}
                                </el-col>
                                <el-col :span="7">
                                    <el-slider v-model="queryInfo.quantity" range :max="100">
                                    </el-slider>
                                </el-col>
                            </el-row>
                            <el-row :gutter="10">
                                <el-col :span="2"
                                        style="height: 38px; display: flex; justify-content: center; align-items: center; margin-left: 12px">
                                    <span>单价范围</span>
                                </el-col>
                                <el-col :span="2"
                                        style="height: 38px; display: flex; justify-content: center; align-items: center">
                                    {{queryInfo.price[0]}}~{{queryInfo.price[1]}}
                                </el-col>
                                <el-col :span="9">
                                    <el-slider v-model="queryInfo.price" range :max="1000" :min="1">
                                    </el-slider>
                                </el-col>
                                <el-col :span="6">
                                    <el-form-item prop="comDescription">
                                        <el-input
                                                v-model="queryInfo.comDescription"
                                                placeholder="请输入描述"
                                                clearable
                                                style="margin-left: 24px"
                                        >
                                        </el-input>
                                    </el-form-item>
                                </el-col>
                                <el-col :span="3">
                                    <el-button type="primary" @click="selectCommodity()" style="float: right;">搜索商品
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
            <transition name="slide-fade" mode="out-in">
                <el-row :gutter="40" v-if="cardOrTable">
                    <el-col :span="6" v-for="(commodity) in AllCommodity" :key="commodity.comId">
                        <el-card :body-style="{ padding: '24px' }" style="text-align: center; margin: 24px 0;">
                            <el-button type="danger" icon="el-icon-warning-outline" circle
                                       style="float: left; margin: 12px"
                                       @click="checkCommodityUserInfo(commodity.comId)"></el-button>
                            <el-button type="primary" icon="el-icon-shopping-cart-2" circle
                                       style="float: right; margin: 12px"
                                       @click="showBuyCommodityDialog(commodity.comId)"></el-button>
                            <el-image
                                    v-if="commodity.comPicture !== '' && commodity.comPicture !== null"
                                    v-loading="loading"
                                    style="max-width: 100px; max-height: 100px; min-width: 100px; min-height: 100px"
                                    :src="commodity.comPicture"
                                    fit="cover"
                                    @load="loadSuccess"
                                    @error="loadError"
                            >
                                <div slot="error" class="image-slot"
                                     style="display: flex; justify-content: center; align-items: center; height: 100%; flex-flow: column">
                                <span class="el-icon-picture-outline"
                                      style="width: 48px; height: 48px; font-size: 48px"/>
                                    <span style="margin-top: 12px">加载失败</span>
                                </div>
                            </el-image>
                            <i v-if="commodity.comPicture === '' || commodity.comPicture === null"
                               class="el-icon-present"></i>
                            <el-rate
                                    v-model="commodity.comRate"
                                    :icon-classes="iconClasses"
                                    void-icon-class="el-icon-star-off"
                                    :colors="['#99A9BF', '#F7BA2A', '#FF9900']"
                                    disabled show-score>
                            </el-rate>
                            <el-row class="middleFont">编号 - {{commodity.comId}}</el-row>
                            <el-row class="middleFont">名称 - {{commodity.comName}}</el-row>
                            <el-row class="middleFont">数量 - {{commodity.comQuantity}}单位</el-row>
                            <el-row class="middleFont">存货 - {{commodity.comQuantityNow}}单位</el-row>
                            <el-row class="middleFont">单价 - {{commodity.comEachPrice}}元</el-row>
                            <el-row class="middleFont">描述 - {{commodity.comDescription}}</el-row>
                        </el-card>
                    </el-col>
                </el-row>
                <!--商品列表区域-->
                <el-table
                        :data="showCommodity"
                        :header-cell-style="{background:'#eef1f6',color:'#606266'}"
                        border
                        v-loading="loading"
                        v-if="!cardOrTable"
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
                    <el-table-column label="商品号" prop="comId" align="center" width="120px"/>
                    <el-table-column label="名称" prop="comName" align="center" width="240px"/>
                    <el-table-column label="数量" prop="comQuantity" align="center" width="80px"/>
                    <el-table-column label="存货" prop="comQuantityNow" align="center" width="80px"/>
                    <el-table-column label="租价/天" prop="comEachPrice" align="center" width="120px"/>
                    <el-table-column label="描述" prop="comDescription" align="center"/>
                    <el-table-column label="评分" align="center" width="60px">
                        <template slot-scope="scope">
                            <span>{{scope.row.comRate === 0 ? '无' : scope.row.comRate}}</span>
                        </template>
                    </el-table-column>
                    <el-table-column label="操作" align="center" width="180px">
                        <template slot-scope="scope">
                            <el-tooltip
                                    class="dark"
                                    effect="dark"
                                    content="下单"
                                    placement="top"
                                    :enterable="false"
                                    :hide-after="2000"
                            >
                                <!--修改按钮-->
                                <el-button
                                        type="primary"
                                        icon="el-icon-shopping-cart-2"
                                        size="mini"
                                        @click="showBuyCommodityDialog(scope.row.comId)"
                                        round
                                />
                            </el-tooltip>
                            <el-tooltip
                                    class="dark"
                                    effect="dark"
                                    content="查询"
                                    placement="top"
                                    :enterable="false"
                                    :hide-after="2000"
                            >
                                <!--删除按钮-->
                                <el-button
                                        type="danger"
                                        icon="el-icon-warning-outline"
                                        size="mini"
                                        @click="checkCommodityUserInfo(scope.row.comId)"
                                        round
                                />
                            </el-tooltip>
                        </template>
                    </el-table-column>
                </el-table>
            </transition>
            <transition name="slide-fade" mode="out-in">
                <!--显示分页信息-->
                <el-pagination
                        v-if="!cardOrTable"
                        @size-change="handleSizeChange"
                        @current-change="handleCurrentChange"
                        :current-page.sync="currentPage"
                        :page-sizes="[1, 5, 7, 10, 30, 50, 100]"
                        :page-size="pageSize"
                        layout="total, sizes, prev, pager, next, jumper"
                        :total="total">
                </el-pagination>
            </transition>
        </el-card>
        <!--联系卖家的对话框-->
        <el-dialog
                title="联系卖家"
                :visible.sync="callSalerDialogVisible"
                width="40%"
                center>
            <el-row :gutter="20">
                <el-col :span="10">
                    <i class="el-icon-user centerIcon"></i>
                </el-col>
                <el-col :span="14" class="centerCol">
                    <span>{{this.callInfo.userNick}}</span>
                </el-col>
            </el-row>
            <el-row :gutter="20">
                <el-col :span="10">
                    <i class="el-icon-phone-outline centerIcon"></i>
                </el-col>
                <el-col :span="9" class="centerCol">
                    <span>{{this.callInfo.userPhone}}</span>
                </el-col>
                <el-col :span="4" class="centerCol">
                    <a :data-clipboard-text="this.callInfo.userPhone" class="copy-phone">
                        <el-button type="info" icon="el-icon-phone" circle style="float: right"></el-button>
                    </a>
                </el-col>
            </el-row>
            <el-row :gutter="20">
                <el-col :span="10">
                    <i class="el-icon-c-scale-to-original centerIcon"></i>
                </el-col>
                <el-col :span="9" class="centerCol">
                    <span>{{this.callInfo.userEmail}}</span>
                </el-col>
                <el-col :span="4" class="centerCol">
                    <a :data-clipboard-text="this.callInfo.userEmail" class="copy-email">
                        <el-button type="info" icon="el-icon-message" circle style="float: right"></el-button>
                    </a>
                </el-col>
            </el-row>
            <span slot="footer" class="dialog-footer">
                <el-button type="primary" @click="callSalerDialogVisible = false">返 回</el-button>
            </span>
        </el-dialog>
        <el-dialog
                title="购买商品"
                :visible.sync="buyCommodityDialogVisible"
                width="70%"
                @close="buyCommodityDialogClosed"
        >
            <el-steps :active="activeStep" finish-status="success" simple style="margin-top: 20px">
                <el-step title="确认商品信息"></el-step>
                <el-step title="填写个人信息"></el-step>
                <el-step title="扫码先付后租"></el-step>
                <el-step title="收货发布评价"></el-step>
            </el-steps>
            <el-card style="margin-top: 12px; text-align: center; height: 270px">
                <transition name="fade">
                    <div v-if="activeStep === 0"
                         style="position: absolute; left: 50%; transform: translate(-50%); margin-top: 8px">
                        <i v-if="buyCommodityPost.comInfo.comPicture === '' || buyCommodityPost.comInfo.comPicture === null"
                           class="el-icon-present"></i>
                        <el-image
                                v-if="buyCommodityPost.comInfo.comPicture !== '' && buyCommodityPost.comInfo.comPicture !== null"
                                v-loading="loading"
                                style="width: 6.5vw; height: 6.5vw; min-width: 94px; min-height: 94px"
                                :src="buyCommodityPost.comInfo.comPicture"
                                fit="cover"
                                @load="loadSuccess"
                                @error="loadError"
                        >
                            <div slot="error" class="image-slot"
                                 style="display: flex; justify-content: center; align-items: center; height: 100%; flex-flow: column">
                                <span class="el-icon-picture-outline"
                                      style="width: 48px; height: 48px; font-size: 48px"/>
                                <span style="margin-top: 12px">加载失败</span>
                            </div>
                        </el-image>
                        <el-row class="middleFont">编号 - {{buyCommodityPost.comInfo.comId}}</el-row>
                        <el-row class="middleFont">名称 - {{buyCommodityPost.comInfo.comName}}</el-row>
                        <el-row class="middleFont">数量 - {{buyCommodityPost.comInfo.comQuantity}}单位</el-row>
                        <el-row class="middleFont">存货 - {{buyCommodityPost.comInfo.comQuantityNow}}单位</el-row>
                        <el-row class="middleFont">单价 - {{buyCommodityPost.comInfo.comEachPrice}}元</el-row>
                        <el-row class="middleFont">描述 - {{buyCommodityPost.comInfo.comDescription}}</el-row>
                    </div>
                </transition>
                <transition name="fade">
                    <div v-if="activeStep === 1" style="position: absolute; margin-top: 24px; width: 90%">
                        <el-row :gutter="20">
                            <el-form
                                    :model="buyForm"
                                    :rules="buyFormRules"
                                    ref="buyFormRef"
                                    label-width="120px"
                            >
                                <!--<el-col :span="12">
                                    <el-form-item label="商品号" prop="comId">
                                        <el-input v-model="buyForm.comId"/>
                                    </el-form-item>
                                    <el-form-item label="名称" prop="comName">
                                        <el-input v-model="buyForm.comName"/>
                                    </el-form-item>
                                    <el-form-item label="数量" prop="comQuantity">
                                        <el-slider v-model="buyForm.comQuantity" show-input :min="1" :max="100"
                                                   style="margin-left: 10px"></el-slider>
                                    </el-form-item>
                                </el-col>
                                <el-col :span="12">
                                    <el-form-item label="单价" prop="comEachPrice">
                                        <el-input-number v-model="buyForm.comEachPrice" :precision="1" :step="0.1"
                                                         :min="0.1" :max="10000"></el-input-number>
                                        元
                                    </el-form-item>
                                    <el-form-item label="描述" prop="comDescription">
                                        <el-input v-model="buyForm.comDescription"/>
                                    </el-form-item>-->
                                    <el-form-item label="收货地址" prop="address">
                                        <el-select v-model="buyForm.address"
                                                   style="width: 100%"
                                                   placeholder="选择您的收货地址"
                                                   default-first-option>
                                            <el-option
                                                    v-for="item in addresses"
                                                    :key="item.id"
                                                    :label="item.address"
                                                    :value="item.address">
                                            </el-option>
                                        </el-select>
                                    </el-form-item>
                                <el-form-item label="租赁数量(单位)" prop="comQuantity">
                                    <el-slider v-model="buyForm.comQuantity" show-input :min="1" :max="buyCommodityPost.comInfo.comQuantityNow"
                                               style="margin-left: 10px"></el-slider>
                                </el-form-item>
                                <el-form-item label="租赁时长（天)" prop="orderTime">
                                    <el-slider v-model="orderForm.orderTime" show-input :min="1" :max="365"
                                               style="margin-left: 10px"></el-slider>
                                </el-form-item>
                                <!--</el-col>-->
                            </el-form>
                        </el-row>
                    </div>
                </transition>
                <transition name="fade" style="position: absolute; left: 50%; transform: translate(-50%)" mode="out-in">
                    <div v-if="activeStep === 2" id="qrcodeImg"></div>
                    <el-progress v-if="(progressLoading !== 100 || !blockFlag)&& activeStep === 3" type="circle"
                                 :percentage="progressLoading"
                                 :stroke-width="12" :color="colors" style="transform: translateY(50%)"></el-progress>
                </transition>
            </el-card>
            <!--底部按钮区-->
            <span slot="footer" class="dialog-footer">
                <el-button @click="buyCommodityPreStep" v-if="activeStep > 0 && activeStep < 3">上 一 步</el-button>
                <el-button type="primary" @click="buyCommodityNextStep" v-if="activeStep < 2">下 一 步</el-button>
                <el-button type="primary" @click="buyCommodityNextStep" v-if="activeStep === 2">先 租 后 付</el-button>
            </span>
        </el-dialog>
        <!--回到顶部-->
        <el-backtop target=".el-main" :bottom="50">△</el-backtop>
    </div>
</template>

<script>
    import {checkError, getCookie, sliceData, timestampToTime} from "../../plugins/utils";
    import Clipboard from 'clipboard';
    import QRCode from 'qrcodejs2'

    export default {
        name: "BuyCommodity",
        data() {
            const checkComId = (rule, value, callback) => {
                const currentComId = this.buyCommodityPost.comInfo.comId
                if (value !== currentComId || value === null) {
                    return callback()
                } else {
                    callback(new Error('不能与原商品号重复'))
                }
            }
            const checkQuantity = (rule, value, callback) => {
                const currentQuantity = this.buyCommodityPost.comInfo.comQuantityNow
                if (value <= currentQuantity || value === null) {
                    return callback()
                } else {
                    callback(new Error('数量不得超过原有的商品'))
                }
            }
            return {
                blockFlag: false,
                cardOrTable: true,
                addresses: [],
                rate: null,
                iconClasses: ['el-icon-heavy-rain', 'el-icon-cloudy-and-sunny', 'el-icon-sunny'],
                loading: false,
                queryInfo: {
                    comId: '',
                    comName: '',
                    quantity: [1, 100],
                    price: [1, 1000],
                    comDescription: ''
                },
                searchFlag: false,
                clipboard1: '',
                clipboard2: '',
                activeStep: 0,
                callSalerDialogVisible: false,
                dialogLoading: true,
                buyCommodityDialogVisible: false,
                mainLoading: true,
                showCommodity: [],
                AllCommodity: [],
                callInfo: [],
                buyCommodityPost: {
                    userName: getCookie('ID'),
                    // 当前选中的商品信息
                    comInfo: []
                },
                // 购买之后填写的商品信息
                buyForm: {
                    comId: '',
                    comName: '',
                    comQuantity: 1,
                    comQuantityNow: 1,
                    comEachPrice: 1,
                    comDescription: '',
                    valid: 0,
                    address: ''
                },
                // 创建新订单信息
                orderForm: {
                    orderComId: '',
                    // orderNewId: '',
                    orderSalerName: '',
                    orderBuyerName: '',
                    orderStatus: 1,
                    orderTime: 1,
                    orderPayStatus: 2,
                },
                // 修改表单的验证规则对象
                buyFormRules: {
                    comId: [
                        {required: true, message: '请输入商品号', trigger: 'blur'},
                        {min: 2, max: 10, message: '长度在2到10个字符', trigger: 'blur'},
                        {validator: checkComId, trigger: 'blur'}
                    ],
                    comName: [
                        {required: true, message: '请输入商品名称', trigger: 'blur'},
                        {min: 2, max: 10, message: '长度在2到10个字符', trigger: 'blur'}
                    ],
                    comQuantity: [
                        {validator: checkQuantity, trigger: 'change'}
                    ],
                    comEachPrice: [
                        {required: true, message: '请确定商品单价', trigger: 'change'}
                    ],
                    comDescription: [
                        {required: true, message: '请输入商品描述', trigger: 'blur'}
                    ],
                    address: [
                        {required: true, message: '请选择您的收货地址', trigger: 'change'}
                    ]
                },
                // 路由url
                routeUrl: '/buyCommodity',
                progressLoading: 0,
                inter: '',
                colors: [
                    {color: '#f56c6c', percentage: 30},
                    {color: '#e6a23c', percentage: 55},
                    {color: '#5cb87a', percentage: 75},
                    {color: '#1989fa', percentage: 90},
                    {color: '#6f7ad3', percentage: 100}
                ],
                // 页面数据显示条数
                pageSize: 7,
                // 当前页数
                currentPage: 1,
                total: 0,
            }
        },
        mounted() {
            this.clipboard1 = new Clipboard('.copy-phone')
            this.clipboard2 = new Clipboard('.copy-email')
            this.clipboard1.on('success', e1 => {
                this.$message({message: '联系电话：' + e1.text + ' 已复制到剪贴板！', type: 'success', customClass: 'zZindex'})
            });
            this.clipboard2.on('success', e2 => {
                this.$message({message: '电子邮箱：' + e2.text + ' 已复制到剪贴板！', type: 'success', customClass: 'zZindex'})
            })
        },
        created() {
            this.information.$emit('activePath', this.routeUrl)
            this.getCommodity()
        },
        destroyed() {
            this.clipboard1.destroy()
            this.clipboard2.destroy()
        },
        methods: {
            // 当前页面显示数据条数改变事件
            // eslint-disable-next-line no-dupe-keys,vue/no-dupe-keys
            handleSizeChange(val) {
                this.pageSize = val
                // 根据当前页数和每页显示数控大小截取数据
                this.showCommodity = sliceData(this.AllCommodity, this.currentPage, this.pageSize)
            },
            // 页码改变事件
            // eslint-disable-next-line no-dupe-keys,vue/no-dupe-keys
            handleCurrentChange(val) {
                this.currentPage = val
                // 根据当前页数和每页显示数控大小截取数据
                this.showCommodity = sliceData(this.AllCommodity, this.currentPage, this.pageSize)
            },
            resetQueryInfo() {
                Object.keys(this.queryInfo).forEach(key => this.queryInfo[key] = "")
                this.queryInfo.quantity = [0, 100]
                this.queryInfo.price = [0, 1000]
                this.getCommodity()
            },
            // 图片加载成功
            loadSuccess() {
                this.loading = false
            },
            // 图片加载失败
            loadError() {
                this.loading = false
            },
            async buy() {
                // this.buyForm.comQuantityNow = this.buyForm.comQuantity
                // for (let i = 0; i < this.AllCommodity.length; i++) {
                //     if (this.buyForm.comId === this.AllCommodity[i].comId) {
                //         this.buyCommodityDialogVisible = false
                //         return this.$message.error('商品号重复，下单失败')
                //     }
                // }
                // const {data: commodityInsert} = await this.$http.post(
                //     `commodity/insert?userName=${this.buyCommodityPost.userName}`,
                //     this.buyForm
                // )
                // if (commodityInsert.code !== 200) {
                //     this.buyCommodityDialogVisible = false
                //     return this.$message.error('下单失败 ID重复或数据错误')
                // }
                // const {data: commodityUpdate} = await this.$http.post(
                //     `commodity/update?userName=${this.buyCommodityPost.userName}`,
                //     this.buyForm
                // )
                // if (commodityUpdate.code !== 200) {
                //     this.buyCommodityDialogVisible = false
                //     return this.$message.error('下单失败' + checkError(commodityUpdate))
                // }
                this.blockFlag = false
                this.orderForm.orderComId = this.buyCommodityPost.comInfo.comId
                // this.orderForm.orderNewId = this.buyForm.comId
                this.orderForm.orderBuyerAddress = this.buyForm.address
                this.orderForm.orderBuyerName = getCookie('ID')
                this.orderForm.orderTime *=  86400000
                this.orderForm.orderPayStatus = 2
                const {data: result} = await this.$http.get(`commodity/selectCommodityUser?comId=${this.orderForm.orderComId}`)
                if (result.code !== 200) {
                    return this.$message.error('查询用户信息错误' + checkError(result))
                } else {
                    this.callInfo = result.data
                }
                this.orderForm.orderSalerName = this.callInfo.userName
                const {data: res} = await this.$http.post(
                    `order/insert`,
                    this.orderForm
                )
                if (res.code === 408) {
                    this.buyCommodityDialogVisible = false
                    return this.$message.error(res.message)
                } else if (res.code !== 200) {
                    this.buyCommodityDialogVisible = false
                    return this.$message.error('下单失败' + checkError(res))
                } else {
                    this.buyCommodityPost.comInfo.comQuantityNow -= this.buyForm.comQuantity
                    const {data: res2} = await this.$http.post(
                        'commodity/update?',
                        this.buyCommodityPost.comInfo
                    )
                    if (res2.code !== 200) {
                        this.buyCommodityDialogVisible = false
                        return this.$message.error('下单失败' + checkError(res2))
                    } else {
                        this.blockFlag = true
                        this.buyCommodityDialogVisible = false
                        await this.getCommodity()
                        this.closeBuyCommodityDialogVisible()
                    }
                }
            },
            qrcode() {
                new QRCode('qrcodeImg', {
                    width: 200,
                    height: 200,
                    text: 'HTTPS://QR.ALIPAY.COM/FKX04733UHFOJJN0AHTS3E',
                    colorDark: '#000',
                    colorLight: '#fff'
                });
            },
            buyCommodityNextStep() {
                if (this.activeStep === 1) {
                    this.$refs.buyFormRef.validate(valid => {
                        if (valid) {
                            this.addStep()
                            setTimeout(this.qrcode, 100)
                        }
                    })
                } else if (this.activeStep === 2) {
                    this.addStep()
                    this.inter = setInterval(this.progress, 50)
                    setTimeout(this.buy, 5000)
                } else {
                    this.addStep()
                }
            },
            addStep() {
                this.activeStep < 3 ? this.activeStep++ : this.activeStep
            },
            closeBuyCommodityDialogVisible() {
                this.$message.success('下单成功，请到 订单查询 > 我的订单 中进行查看')
                this.buyCommodityDialogVisible = false
            },
            buyCommodityPreStep() {
                this.activeStep > 0 ? this.activeStep-- : this.activeStep
                if (this.activeStep === 2) {
                    setTimeout(this.qrcode, 100)
                }
            },
            buyCommodityDialogClosed() {
                this.activeStep = 0
                this.buyForm.comId = ''
                this.buyForm.comName = ''
                this.buyForm.comDescription = ''
                this.buyForm.comEachPrice = 1
                this.buyForm.comQuantity = 1
                this.buyForm.address = ''
                this.progressLoading = 0
                this.orderForm.orderTime = 1
            },
            async showBuyCommodityDialog(comId) {
                this.buyCommodityDialogVisible = true
                const {data: res} = await this.$http.get(`commodity/selectById?comId=${comId}`)
                this.buyCommodityPost.comInfo = res.data
                this.activeStep = 0

                const {data: add} = await this.$http.get(`address/selectByName?userName=${getCookie('ID')}`)
                if (add.code !== 200) {
                    this.buyCommodityDialogVisible = false
                    return this.$message.error('您还没有配置地址!请前往个人信息页添加！' + checkError(add))
                } else {
                    this.addresses = add.data
                }
            },
            async checkCommodityUserInfo(comId) {
                const {data: res} = await this.$http.get(`commodity/selectCommodityUser?comId=${comId}`)
                if (res.code !== 200) {
                    return this.$message.error('查询用户信息错误' + checkError(res))
                } else {
                    this.callInfo = res.data
                    this.callSalerDialogVisible = true
                }
            },
            progress() {
                if (this.progressLoading <= 100) {
                    this.progressLoading++
                } else {
                    this.progressLoading = 100
                    clearInterval(this.inter)
                }
            },
            // 面包屑导航切换
            changeMenu(activePath) {
                this.information.$emit('activePath', activePath)
            },
            async selectCommodity() {
                const {data: res} = await this.$http.post(
                    `commodity/selectByAnyParam?minQuantity=${this.queryInfo.quantity[0]}&maxQuantity=${this.queryInfo.quantity[1]}
                    &minPrice=${this.queryInfo.price[0]}&maxPrice=${this.queryInfo.price[1]}`, this.queryInfo
                )
                if (res.code !== 200) {
                    this.AllCommodity = []
                    this.showCommodity = []
                    return this.$message.error('查询商品信息失败' + checkError(res))
                }
                if (res.data.length === 0) {
                    return this.$message.error('没有找到符合要求的商品')
                }
                this.mainLoading = false
                this.AllCommodity = res.data
                this.AllCommodity.forEach(function (item) {
                    item.userLastLogin = timestampToTime(item.userLastLogin)
                    item.utcCreate = timestampToTime(item.utcCreate)
                    item.utcModify = timestampToTime(item.utcModify)
                })
                this.showCommodity = this.AllCommodity
                this.total = res.data.length
                if (!this.cardOrTable) {
                    // 根据当前页数和每页显示数控大小截取数据
                    this.showCommodity = sliceData(this.AllCommodity, this.currentPage, this.pageSize)
                    if (this.showUsrList.length === 0) {
                        this.currentPage = this.currentPage - 1
                        this.showCommodity = sliceData(this.AllCommodity, this.currentPage, this.pageSize)
                    }
                }
                return this.$message.success('查询商品成功!')
            },
            async getCommodity() {
                const {data: res} = await this.$http.get(
                    'commodity/select'
                )
                if (res.code !== 200) {
                    return this.$message.error('查询商品信息失败' + checkError(res))
                }
                this.mainLoading = false
                this.AllCommodity = res.data
                this.AllCommodity.forEach(function (item) {
                    item.utcCreate = timestampToTime(item.utcCreate)
                    item.utcModify = timestampToTime(item.utcModify)
                })
                this.showCommodity = this.AllCommodity
                this.total = res.data.length
                if (!this.cardOrTable) {
                    // 根据当前页数和每页显示数控大小截取数据
                    this.showCommodity = sliceData(this.AllCommodity, this.currentPage, this.pageSize)
                    if (this.showUsrList.length === 0) {
                        this.currentPage = this.currentPage - 1
                        this.showCommodity = sliceData(this.AllCommodity, this.currentPage, this.pageSize)
                    }
                }
            }
        }
    }
</script>

<style lang="less" scoped>
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

    i {
        font-size: 102px;
    }

    .centerCol {
        height: 100px;
        display: flex;
        align-items: center
    }

    .centerIcon {
        float: right;
        margin-right: 24px
    }

    .fade-enter-active, .fade-leave-active {
        transition: all 1s;
    }

    .fade-enter, .fade-leave-to {
        opacity: 0;
        transform: translateX(-200px);
    }

    #qrcodeImg {
        box-sizing: border-box;
        display: inline-block;
        padding: 8px;
        background: #cccccc;

        & > img {
            display: inline-block !important;
        }
    }

    .fadeY-enter-active, .fadeY-leave-active {
        transition: all 1s;
    }

    .fadeY-enter, .fadeY-leave-to {
        opacity: 0;
        transform: translateY(-50px);
    }

    .el-tag {
        margin-left: 16px;
        margin-top: 6px;
        margin-bottom: 6px;
    }

    /* 可以设置不同的进入和离开动画 */
    /* 设置持续时间和动画函数 */
    .slide-fade-enter-active {
        transition: all .3s ease;
    }

    .slide-fade-leave-active {
        transition: all .8s cubic-bezier(1.0, 0.5, 0.8, 1.0);
    }

    .slide-fade-enter, .slide-fade-leave-to
        /* .slide-fade-leave-active for below version 2.1.8 */ {
        transform: translateX(10px);
        opacity: 0;
    }
</style>
