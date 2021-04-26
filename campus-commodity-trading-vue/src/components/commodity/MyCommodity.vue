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
                <el-col :span="13" style="text-align: right">
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
                                   style="float: left; margin: 12px" @click="removeCommodity(commodity.comId)"></el-button>
                        <el-button type="primary" icon="el-icon-edit" circle
                                   style="float: right; margin: 12px"></el-button>
                        <i class="el-icon-present"/>
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
                    label-width="100px"
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
                    <el-input-number v-model="addForm.comEachPrice" :precision="1" :step="0.1" :min="0.1" :max="10000"></el-input-number>
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
    </div>
</template>

<script>
    import {checkError, getCookie} from "../../plugins/utils";

    export default {
        name: "MyCommodity",
        data() {
            return {
                dialogLoading: true,
                addDialogVisible: false,
                addForm: {
                    comId: '',
                    comName: '',
                    comQuantity: 0,
                    comQuantityNow: 0,
                    comEachPrice: 1,
                    comDescription: ''
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
                myCommodity: []
            }
        },
        created() {
            this.getMyCommodity()
        },
        methods: {
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
                await this.getMyCommodity()
            },
            showAddDialog() {
                this.addDialogVisible = true
                this.dialogLoading = false
            },
            addDialogClosed() {
                this.$refs.addFormRef.resetFields()
            },
            // 面包屑导航切换
            changeMenu(activePath) {
                this.information.$emit('activePath', activePath)
            },
            async getMyCommodity() {
                const {data: res} = await this.$http.get(
                    `commodity/selectUserCommodity?userName=${getCookie('ID')}`
                )
                if (res.code !== 200) {
                    return this.$message.error('查询用户信息失败' + checkError(res))
                }
                this.mainLoading = false
                this.myCommodity = res.data
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
