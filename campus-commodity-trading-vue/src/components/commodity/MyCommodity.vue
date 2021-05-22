<template>
    <div>
        <!--面包屑导航区-->
        <el-breadcrumb separator-class="el-icon-arrow-right">
            <el-breadcrumb-item :to="{ path: '/home' }" @click.native="changeMenu('/')">首页</el-breadcrumb-item>
            <el-breadcrumb-item>商品管理</el-breadcrumb-item>
            <el-breadcrumb-item>我的商品</el-breadcrumb-item>
        </el-breadcrumb>
        <!--查询卡片区-->
        <el-card style="margin-top: 14px" v-loading="mainLoading">
            <el-row :gutter="20">
                <el-col :span="2">
                    <el-button type="text" icon="el-icon-refresh" circle style="margin-left: 0; font-size: 32px; padding: 0"
                               @click="removeZeroCommodity"></el-button>
                </el-col>
                <el-col :span="11" style="text-align: right">
                    <div class="centerFont">我的商品库</div>
                </el-col>
                <el-col :span="11">
                    <el-button type="success" icon="el-icon-plus" circle style="margin-left: 0"
                               @click="showAddDialog"></el-button>
                </el-col>
            </el-row>
            <el-row>
                <el-col :span="6" v-for="(commodity, index) in myCommodity" :key="commodity.comId"
                        :offset="index % 3 === 0 ? 0 : 3">
                    <el-card :body-style="{ padding: '0px' }" style="text-align: center; margin: 24px 0;">
                        <el-button type="danger" icon="el-icon-delete" circle
                                   style="float: left; margin: 12px"
                                   @click="removeCommodity(commodity.comId)"></el-button>
                        <el-button type="primary" icon="el-icon-edit" circle
                                   style="float: right; margin: 12px"
                                   @click="showEditDialog(commodity.comId)"></el-button>
                        <el-upload
                                :on-change="handleChange"
                                class="upload-demo"
                                action=""
                                :show-file-list="false"
                                :http-request="updatePicture"
                                accept="image/jpeg,image/png,image/jpg"
                                :file-list="fileList"
                                @click.native="getCurrentId(commodity.comId)"
                        >
                            <i v-if="commodity.comPicture === '' || commodity.comPicture === null"
                               class="el-icon-present"/>
                            <el-image
                                    v-if="commodity.comPicture !== '' && commodity.comPicture !== null"
                                    v-loading="loading"
                                    style="width: 6.5vw; height: 6.5vw; min-width: 100px; min-height: 100px"
                                    :src="commodity.comPicture"
                                    fit="cover"
                                    @load="loadSuccess"
                                    @error="loadError"
                            >
                                <div slot="error" class="image-slot"
                                     style="display: flex; justify-content: center; align-items: center; height: 100%; flex-flow: column">
                                    <span class="el-icon-picture-outline" style="width: 48px; height: 48px; font-size: 48px"/>
                                    <span style="margin-top: 12px">加载失败</span>
                                </div>
                            </el-image>
                        </el-upload>
                        <el-rate
                                v-if="commodity.comRate !== 0"
                                v-model="commodity.comRate"
                                :icon-classes="iconClasses"
                                void-icon-class="el-icon-star-off"
                                :colors="['#99A9BF', '#F7BA2A', '#FF9900']"
                                disabled show-score>
                        </el-rate>
                        <el-row v-if="commodity.comRate === 0">暂无评价</el-row>
                        <el-row>编号 - {{commodity.comId}}</el-row>
                        <el-row>名称 - {{commodity.comName}}</el-row>
                        <el-row>数量 - {{commodity.comQuantity}}单位</el-row>
                        <el-row>存货 - {{commodity.comQuantityNow}}单位</el-row>
                        <el-row>单价 - {{commodity.comEachPrice}}元</el-row>
                        <el-row>描述 - {{commodity.comDescription}}</el-row>
                    </el-card>
                </el-col>
            </el-row>
        </el-card>
        <!--添加商品的对话框-->
        <el-dialog
                title="添加商品"
                :visible.sync="addDialogVisible"
                width="50%"
                @close="addDialogClosed"
        >
            <!--内容主题区域-->
            <el-form
                    :model="addForm"
                    :rules="addFormRules"
                    ref="addFormRef"
                    label-width="80px"
                    v-loading="dialogLoading"
            >
                <el-form-item label="商品号" prop="comId">
                    <el-input v-model="addForm.comId"/>
                </el-form-item>
                <el-form-item label="名称" prop="comName">
                    <el-input v-model="addForm.comName"/>
                </el-form-item>
                <el-form-item label="数量" prop="comQuantity">
                    <el-slider v-model="addForm.comQuantity" show-input :min="1" :max="100"
                               style="margin-left: 10px"></el-slider>
                </el-form-item>
                <el-form-item label="单价" prop="comEachPrice">
                    <el-input-number v-model="addForm.comEachPrice" :precision="1" :step="0.1" :min="0.1" :max="1000"></el-input-number>
                元
                </el-form-item>
                <el-form-item label="描述" prop="comDescription">
                    <el-input v-model="addForm.comDescription"/>
                </el-form-item>
            </el-form>
            <!--底部按钮区-->
            <span slot="footer" class="dialog-footer">
                <el-button @click="addDialogVisible = false">取 消</el-button>
                <el-button type="primary" @click="addCommodity">发 布</el-button>
            </span>
        </el-dialog>
        <!--修改商品的对话框-->
        <el-dialog
                title="修改商品"
                :visible.sync="editDialogVisible"
                width="50%"
                @close="editDialogClosed"
                style="margin-top: -50px"
        >
            <!--内容主题区域-->
            <el-form
                    :model="editForm"
                    :rules="editFormRules"
                    ref="editFormRef"
                    label-width="80px"
                    v-loading="dialogLoading"
            >
                <el-form-item label="商品号" prop="comId">
                    <el-input v-model="editForm.comId" disabled/>
                </el-form-item>
                <el-form-item label="名称" prop="comName">
                    <el-input v-model="editForm.comName"/>
                </el-form-item>
                <el-form-item label="数量" prop="comQuantity">
                    <el-slider v-model="editForm.comQuantity" show-input :min="1" :max="100"
                               style="margin-left: 10px"></el-slider>
                </el-form-item>
                <el-form-item label="存货" prop="comQuantityNow">
                    <el-slider v-model="editForm.comQuantityNow" show-input :min="0" :max="editForm.comQuantity"
                               style="margin-left: 10px"></el-slider>
                </el-form-item>
                <el-form-item label="单价" prop="comEachPrice">
                    <el-input-number v-model="editForm.comEachPrice" :precision="1" :step="0.1" :min="0.1" :max="1000"></el-input-number>
                    元
                </el-form-item>
                <el-form-item label="描述" prop="comDescription">
                    <el-input v-model="editForm.comDescription"/>
                </el-form-item>
            </el-form>
            <el-card style="height: 200px">
                <quill-editor ref="text" v-model="content" class="myQuillEditor"
                              style="height: 100px"/>
            </el-card>
            <!--底部按钮区-->
            <span slot="footer" class="dialog-footer">
                <el-button @click="editDialogVisible = false">取 消</el-button>
                <el-button type="primary" @click="editCommodity">修 改</el-button>
            </span>
        </el-dialog>
    </div>
</template>

<script>
    import {checkError, getCookie} from "../../plugins/utils";

    export default {
        name: "MyCommodity",
        data() {
            return {
                content: '',
                iconClasses: ['el-icon-heavy-rain', 'el-icon-cloudy-and-sunny', 'el-icon-sunny'],
                currentComId: '',
                headers: {
                    'Content-Type': 'multipart/form-data'
                },
                loading: false,
                fileList: [],
                dialogLoading: true,
                addDialogVisible: false,
                editDialogVisible: false,
                addForm: {
                    comId: '',
                    comName: '',
                    comQuantity: 0,
                    comQuantityNow: 0,
                    comEachPrice: 1,
                    comDescription: ''
                },
                editForm: {
                    comId: '',
                    comName: '',
                    comQuantity: '',
                    comQuantityNow: '',
                    comEachPrice: '',
                    comDescription: '',
                    comPicture: ''
                },
                // 添加表单的验证规则对象
                addFormRules: {
                    comId: [
                        {required: true, message: '请输入商品标号', trigger: 'blur'},
                        {min: 2, max: 10, message: '长度在2到10个字符', trigger: 'blur'}
                    ],
                    comName: [
                        {required: true, message: '请输入商品名称', trigger: 'blur'},
                        {min: 2, max: 10, message: '长度在2到10个字符', trigger: 'blur'}
                    ],
                    comQuantity: [
                        {required: true, message: '请确定商品数量', trigger: 'change'}
                    ],
                    comEachPrice: [
                        {required: true, message: '请确定商品单价', trigger: 'change'}
                    ],
                    comDescription: [
                        {required: true, message: '请输入商品描述', trigger: 'blur'}
                    ]
                },
                // 修改表单的验证规则对象
                editFormRules: {
                    comName: [
                        {required: true, message: '请输入商品名称', trigger: 'blur'},
                        {min: 2, max: 10, message: '长度在2到10个字符', trigger: 'blur'}
                    ],
                    comQuantity: [
                        {required: true, message: '请确定商品数量', trigger: 'blur'}
                    ],
                    comQuantityNow: [
                        {required: true, message: '请确定商品数量', trigger: 'blur'}
                    ],
                    comEachPrice: [
                        {required: true, message: '请确定商品单价', trigger: 'blur'}
                    ],
                    comDescription: [
                        {required: true, message: '请输入商品描述', trigger: 'blur'}
                    ]
                },
                mainLoading: true,
                myCommodity: [],
                // 路由url
                routeUrl: '/myCommodity',
            }
        },
        created() {
            this.information.$emit('activePath', this.routeUrl)
            this.getMyCommodity()
        },
        methods: {
            // 图片加载成功
            loadSuccess() {
                this.loading = false
            },
            // 图片加载失败
            loadError() {
                this.loading = false
            },
            getCurrentId(comId) {
                this.currentComId = comId
            },
            async updatePicture() {
                this.loading = true
                const param = new FormData()
                this.fileList.forEach(
                    // eslint-disable-next-line no-unused-vars
                    (val, index) => {
                        param.append("fileImg", val.raw)
                    }
                )
                const {data: res} = await this.$http.post(
                    '/gitee/saveImg',
                    param
                )
                if (res.code !== 200) {
                    return this.$message.error('文件大小不能超过1M且只能上传一张')
                } else {
                    this.editForm.comDescription = ''
                    this.editForm.comId = this.currentComId
                    this.editForm.comPicture = "https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/" + res.data.resultImgUrl.split('/').pop()
                    const {data: res2} = await this.$http.post(
                        'commodity/update',
                        this.editForm
                    )
                    if (res2.code !== 200) {
                        return this.$message.error('更新图片失败')
                    }
                }
                this.loading = false
                this.getMyCommodity()
                return this.$message.success('上传图片成功')
            },
            handleChange(file, fileList) {
                this.fileList = fileList.slice(-1)
            },
            // 点击按钮销毁无存货商品
            async removeZeroCommodity() {
                // 弹框询问
                const confirmResult = await this.$confirm(
                    '此操作将永久删除所有您仓库中存货为0的商品, 是否继续?',
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
                const { data: res } = await this.$http.post(`commodity/deleteAllZero?userName=${getCookie('ID')}`)
                if (res.code !== 200) {
                    return this.$message.error('删除商品失败' + checkError(res))
                }
                this.$message.success('删除商品成功')
                await this.getMyCommodity()
            },
            // 点击按钮修改商品信息
            async editCommodity() {
                this.$refs.editFormRef.validate(async (valid) => {
                    if (!valid) return this.$message.error('请填写正确的商品信息后再提交')
                    this.dialogLoading = true
                    const { data: res } = await this.$http.post(
                        'commodity/update',
                        this.editForm
                    )
                    this.dialogLoading = false
                    if (res.code !== 200) {
                        this.editDialogVisible = false
                        return this.$message.error('修改商品失败' + checkError(res))
                    } else {
                        this.editDialogVisible = false
                        this.$message.success('修改商品成功')
                    }
                    await this.getMyCommodity()
                })
            },
            // 点击按钮删除商品信息
            async removeCommodity(comId) {
                // 弹框询问
                const confirmResult = await this.$confirm(
                    '此操作将永久删除该商品, 是否继续?',
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
                const { data: res } = await this.$http.post(`commodity/delete?userName=${getCookie('ID')}&comId=${comId}`)
                if (res.code !== 200) {
                    return this.$message.error('删除商品失败' + checkError(res))
                }
                this.$message.success('删除商品成功')
                this.getMyCommodity()
            },
            showAddDialog() {
                this.addDialogVisible = true
                this.dialogLoading = false
            },
            async showEditDialog(comId) {
                this.dialogLoading = true
                const { data: res } = await this.$http.get(
                    `commodity/selectById?comId=${comId}`
                )
                if (res.code !== 200) {
                    return this.$message.error('查询商品信息失败' + checkError(res))
                }
                this.editForm = res.data
                this.editDialogVisible = true
                this.dialogLoading = false
            },
            addDialogClosed() {
                this.$refs.addFormRef.resetFields()
            },
            editDialogClosed() {
                this.$refs.editFormRef.resetFields()
            },
            // 面包屑导航切换
            changeMenu(activePath) {
                this.information.$emit('activePath', activePath)
            },
            async getMyCommodity() {
                const {data: res} = await this.$http.get(
                    `commodity/selectUserCommodity?userName=${getCookie('ID')}`
                )
                this.mainLoading = false
                if (res.code !== 200) {
                    return this.$message.error('查询用户商品失败 ' + checkError(res))
                }
                // 按Id排序
                this.myCommodity = res.data.filter(n => n).sort(
                    function (a, b) {
                        return a.comId > b.comId ? 1 : -1
                    }
                )
            },
            async addCommodity() {
                this.$refs.addFormRef.validate(async (valid) => {
                    if (!valid) return this.$message.error('请填写正确的商品信息后再提交')
                    this.dialogLoading = true
                    this.addForm.comQuantityNow = this.addForm.comQuantity
                    const { data: res } = await this.$http.post(
                        `commodity/insert?userName=${getCookie('ID')}&number=${this.addForm.comQuantity}`,
                        this.addForm
                    )
                    this.dialogLoading = false
                    if (res.code !== 200) {
                        this.addDialogVisible = false
                        return this.$message.error('发布商品失败' + checkError(res))
                    } else {
                        this.addDialogVisible = false
                        this.$message.success('发布商品成功')
                    }
                    await this.getMyCommodity()
                })
            }
        }
    }
</script>

<style lang="less" scoped>
    .centerFont {
        font-weight: bold;
        font-size: 28px;
    }

    i {
        font-size: 100px;
    }
</style>
