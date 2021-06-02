<template>
    <div>
        <!--面包屑导航区-->
        <el-breadcrumb separator-class="el-icon-arrow-right">
            <el-breadcrumb-item :to="{ path: '/home' }" @click.native="changeMenu('/')">首页</el-breadcrumb-item>
            <el-breadcrumb-item>用户管理</el-breadcrumb-item>
            <el-breadcrumb-item>个人信息</el-breadcrumb-item>
        </el-breadcrumb>
        <!--查询卡片区-->
        <el-card style="margin-top: 14px" v-loading="mainLoading">
            <el-row :gutter="20">
                <el-col :span="6">
                    <div class="centerFont">证件照
                        <el-upload
                                :on-change="handleChange"
                                class="upload-demo"
                                action=""
                                :show-file-list="false"
                                :http-request="updateAvatar"
                                accept="image/jpeg,image/png,image/jpg"
                                :file-list="fileList"
                        >
                            <el-button
                                    type="primary"
                                    icon="el-icon-upload2"
                                    size="mini"
                                    round
                            />
                        </el-upload>
                    </div>
                </el-col>
                <el-col :span="18">
                    <div class="centerFont">基本信息
                        <el-button
                                type="primary"
                                icon="el-icon-edit"
                                size="mini"
                                @click="showEditDialog()"
                                style="margin-left: 12px;"
                                round
                        />
                    </div>
                </el-col>
            </el-row>
            <el-row :gutter="20" style="margin-top: 16px">
                <!--证件照区-->
                <el-col :span="6" align="center">
                    <el-row>
                        <el-image
                                v-loading="loading"
                                style="width: 16.5vw; height: 16.5vw; min-width: 145px; min-height: 145px"
                                :src="picSrc"
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
                    </el-row>
                </el-col>
                <!--基本信息区-->
                <el-col :span="6" style="align-items: center">
                    <el-row style="margin-top: -15px;">
                        <el-table :data="myInfo" :header-cell-style="{background:'#eef1f6',color:'#606266'}">
                            <el-table-column label="用户名" prop="userName" align="center"/>
                        </el-table>
                    </el-row>
                    <el-row style="margin-top: 28px">
                        <el-table :data="myInfo" :header-cell-style="{background:'#eef1f6',color:'#606266'}">
                            <el-table-column label="密码" prop="userPassword" align="center"/>
                        </el-table>
                    </el-row>
                </el-col>
                <el-col :span="6" style="align-items: center">
                    <el-row style="margin-top: -15px;">
                        <el-table :data="myInfo" :header-cell-style="{background:'#eef1f6',color:'#606266'}">
                            <el-table-column label="姓名" prop="userNick" align="center"/>
                        </el-table>
                    </el-row>
                    <el-row style="margin-top: 28px;">
                        <el-table :data="myInfo" :header-cell-style="{background:'#eef1f6',color:'#606266'}">
                            <el-table-column label="性别" prop="userGender" align="center"/>
                        </el-table>
                    </el-row>
                </el-col>
                <el-col :span="6" style="align-items: center">
                    <el-row style="margin-top: -15px">
                        <el-table :data="myInfo" :header-cell-style="{background:'#eef1f6',color:'#606266'}">
                            <el-table-column label="联系电话" align="center">
                                <template slot-scope="scope">
                                    <span>{{scope.row.userPhone === null ? '暂无信息' : scope.row.userPhone}}</span>
                                </template>
                            </el-table-column>
                        </el-table>
                    </el-row>
                    <el-row style="margin-top: 28px">
                        <el-table :data="myInfo" :header-cell-style="{background:'#eef1f6',color:'#606266'}">
                            <el-table-column label="电子邮箱" align="center">
                                <template slot-scope="scope">
                                    <span>{{scope.row.userEmail === null ? '暂无信息' : scope.row.userEmail}}</span>
                                </template>
                            </el-table-column>
                        </el-table>
                    </el-row>
                </el-col>
            </el-row>
        </el-card>
        <el-card style="margin-top: 24px">
            <el-row :gutter="20">
                <el-col :span="4">
                    <div class="centerFont" style="transform: translateY(75%)">地址信息维护</div>
                </el-col>
                <el-col :span="10">
                    <el-select v-model="address"
                               placeholder="查看地址信息"
                               style="width: 33vw;"
                               clearable
                               filterable
                               allow-create
                               value-key="id"
                               default-first-option>
                        <el-option
                                v-for="item in addresses"
                                :key="item.id"
                                :label="item.address"
                                :value="item">
                        </el-option>
                    </el-select>
                </el-col>
                <el-col :span="1" style="text-align: center">
                    <el-button v-if="!searchFlag" type="text" icon="el-icon-d-arrow-right" circle
                               style="margin-top: 4px; font-size: 32px; padding: 0"
                               @click="searchFlag = !searchFlag"></el-button>
                    <el-button v-if="searchFlag" type="text" icon="el-icon-d-arrow-left" circle
                               style="margin-top: 4px; font-size: 32px; padding: 0"
                               @click="searchFlag = !searchFlag"></el-button>
                </el-col>
                <transition name="fade">
                    <el-col :span="3" v-if="searchFlag">
                        <el-button type="success" plain @click="addAddress()">添加新地址</el-button>
                    </el-col>
                </transition>
                <transition name="fade">
                    <el-col :span="3" v-if="searchFlag">
                        <el-button type="danger" plain @click="deleteAddress()">删除当前地址</el-button>
                    </el-col>
                </transition>
            </el-row>
        </el-card>
        <!--修改用户的对话框-->
        <el-dialog
                title="修改信息"
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
                    <el-input v-model="editForm.userPassword"/>
                </el-form-item>
                <el-form-item label="姓名" prop="userNick">
                    <el-input v-model="editForm.userNick"/>
                </el-form-item>
                <el-form-item label="性别" prop="userGender">
                    <el-radio-group v-model="editForm.userGender" size="small">
                        <el-radio-button label="男"></el-radio-button>
                        <el-radio-button label="女"></el-radio-button>
                    </el-radio-group>
                </el-form-item>
                <el-form-item label="联系电话" prop="userPhone">
                    <el-input v-model.number="editForm.userPhone" type="number"/>
                </el-form-item>
                <el-form-item label="电子邮箱" prop="userEmail">
                    <el-input v-model="editForm.userEmail"/>
                </el-form-item>
            </el-form>
            <!--底部按钮区-->
            <span slot="footer" class="dialog-footer">
        <el-button @click="editDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="editUser">修 改</el-button>
      </span>
        </el-dialog>
        <!--回到顶部-->
        <el-backtop :bottom="50" :right="50" :visibility-height="10">🚀</el-backtop>
    </div>
</template>

<script>
    import {checkError, getCookie} from '../../plugins/utils'

    export default {
        name: 'Self',
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
                searchFlag: false,
                address: null,
                addresses: [],
                addressForm: {
                    userName: getCookie('ID'),
                    address: ''
                },
                headers: {
                    'Content-Type': 'multipart/form-data'
                },
                fileList: [],
                dialogLoading: true,
                editDialogVisible: false,
                // 修改用户的表单数据
                editForm: {
                    userName: '',
                    userPassword: '',
                    userNick: '',
                    userGender: '',
                    userPhone: '',
                    userEmail: '',
                    roleNameCn: '',
                    userAvatar: ''
                },
                editFormRules: {
                    userPassword: [
                        {validator: checkPass, trigger: 'blur'},
                        {required: true, message: '请输入用户密码', trigger: 'blur'},
                        {min: 2, max: 10, message: '长度在2到10个字符', trigger: 'blur'}
                    ],
                    userNick: [
                        {required: true, message: '请输入您的姓名', trigger: 'blur'},
                        {min: 2, max: 10, message: '长度在2到10个字符', trigger: 'blur'}
                    ],
                    userGender: [
                        {required: true, message: '请选择您的性别', trigger: 'blur'}
                    ],
                    userPhone: [
                        {validator: checkMobile, trigger: 'blur'}
                    ],
                    userEmail: [
                        {validator: checkEmail, trigger: 'blur'}
                    ],
                    roleNameCn: [
                        {required: true, message: '请选择用户角色类型', trigger: 'blur'}
                    ]
                },
                myInfo: [],
                // 路由url
                routeUrl: '/self',
                // 图片地址
                src: [
                    require('../../assets/img/headPic/woman1.png'),
                    require('../../assets/img/headPic/woman2.png'),
                    require('../../assets/img/headPic/woman3.png'),
                    require('../../assets/img/headPic/woman4.png'),
                    require('../../assets/img/headPic/woman5.png'),
                    require('../../assets/img/headPic/man1.png'),
                    require('../../assets/img/headPic/man2.png'),
                    require('../../assets/img/headPic/man3.png'),
                    require('../../assets/img/headPic/man4.png'),
                    require('../../assets/img/headPic/man5.png')
                ],
                picSrc: '',
                // 开启加载
                loading: true,
                mainLoading: true
            }
        },
        created() {
            this.information.$emit('activePath', this.routeUrl)
            this.getAllInfo()
        },
        methods: {
            // 验证地址
            checkAddress(value) {
                if ( value !== null && value !== '') {
                    return true
                } else {
                    return false
                }
            },
            async addAddress() {
                this.$prompt('请输入新地址信息', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    inputValidator: this.checkAddress,
                    inputErrorMessage: '请输入地址信息'
                }).then((value) => {
                    this.addAddress2(value)
                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '取消输入'
                    });
                });
            },
            async addAddress2(value) {
                this.addressForm.address = value.value
                const {data: res} = await this.$http.post('address/insert', this.addressForm)
                if (res.code !== 200) {
                    return this.$message.error('添加地址失败')
                } else {
                    await this.getAllInfo()
                    return this.$message.success('添加地址成功')
                }
            },
            async deleteAddress() {
                if (typeof (this.address) == "undefined" || !this.address) {
                    return this.$message.warning('请选择要删除的地址')
                }
                if (typeof (this.address.id) == "undefined" || !this.address.id) {
                    return this.$message.warning('请选择已添加的地址')
                }
                const {data: res} = await this.$http.post(`address/delete?id=${this.address.id}`)
                if (res.code !== 200) {
                    return this.$message.error('删除地址失败')
                } else {
                    this.address = ''
                    await this.getAllInfo()
                    return this.$message.success('删除地址成功')
                }
            },
            handleChange(file, fileList) {
                this.fileList = fileList.slice(-1)
            },
            async updateAvatar() {
                this.$notify({
                    title: '警告',
                    message: '若无法上传，请刷新页面并重新选择1M一下的图片',
                    type: 'warning',
                    showClose: false
                });
                this.loading = true
                const param = new FormData()
                this.fileList.forEach(
                    // eslint-disable-next-line no-unused-vars
                    (val, index) => {
                        param.append("fileImg", val.raw)
                    }
                )
                const {data: res} = await this.$http.post(
                    '/upload/saveImg',
                    param
                )
                if (res.code !== 200 || res.status === 500) {
                    this.loading = false
                    return this.$message.error('文件大小不能超过1M且只能上传一张')
                } else {
                    this.editForm.userAvatar = "https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/" + res.data.resultImgUrl.split('/').pop()
                    this.editForm.userName = getCookie('ID')
                    const {data: role} = await this.$http.get(
                        `role/selectById?roleId=${getCookie('type')}`
                    )
                    const {data: res2} = await this.$http.post(
                        `user/update?roleNameCn=${role.data.roleNameCn}&status=0`,
                        this.editForm
                    )
                    if (res2.code !== 200) {
                        return this.$message.error('更新头像失败')
                    }
                }
                this.loading = false
                this.getAllInfo()
                return this.$message.success('上传头像成功')
            },
            // 点击按钮修改用户信息
            editUser() {
                this.$refs.editFormRef.validate(async (valid) => {
                    if (!valid) return this.$message({message: '请填写正确的用户信息后提交！', type: 'error', customClass: 'zZindex'})
                    this.dialogLoading = true
                    const {data: role} = await this.$http.get(
                        `role/selectById?roleId=${getCookie('type')}`
                    )
                    const {data: res} = await this.$http.post(
                        `user/update?roleNameCn=${role.data.roleNameCn}&status=0`,
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
                    await this.getAllInfo()
                })
            },
            // 监听修改用户对话框的点击事件
            async showEditDialog() {
                const {data: res} = await this.$http.get(
                    `user/selectByName?userName=${getCookie('ID')}`
                )
                if (res.code !== 200) {
                    return this.$message.error('查询用户信息失败' + checkError(res))
                }
                // 获取角色信息
                const {data: type} = await this.$http.get(`role/selectUserRole?userName=${res.data.userName}`)
                if (type.code === 404) {
                    res.data.roleNameCn = ''
                } else {
                    res.data.roleNameCn = type.data.roleNameCn
                }
                this.editForm = res.data
                this.editDialogVisible = true
                this.dialogLoading = false
            },
            editDialogClosed() {
                this.$refs.editFormRef.resetFields()
            },
            // 查找所有相关信息
            async getAllInfo() {
                const name = getCookie('ID')
                const {data: res} = await this.$http.get(`user/selectByName?userName=${name}`)
                this.mainLoading = false
                if (res.code !== 200) {
                    return this.$message.error('获取用户信息失败!' + checkError(res))
                } else {
                    this.myInfo = []
                    this.myInfo.push(res.data)
                    this.loadPic(res.data.userGender)
                }
                const {data: add} = await this.$http.get(`address/selectByName?userName=${name}`)
                if (add.code !== 200) {
                    return this.$message.error('获取地址信息失败!' + checkError(res))
                } else {
                    this.addresses = add.data
                }
            },
            // 获取图片地址
            loadPic(gender) {
                if (this.myInfo[0].userAvatar !== '' && this.myInfo[0].userAvatar !== null) {
                    this.picSrc = this.myInfo[0].userAvatar
                } else {
                    // 获取上次查询的证件照
                    const prePicSrc = this.picSrc
                    // 判断性别获取地址
                    if (gender === '男') {
                        this.picSrc = this.src[Math.floor(Math.random() * 5) + 5]
                    } else {
                        this.picSrc = this.src[Math.floor(Math.random() * 5)]
                    }
                    // 如果图片地址不相同则开启加载
                    if (prePicSrc !== this.picSrc) {
                        this.loading = true
                    }
                }
            },
            // 图片加载成功
            loadSuccess() {
                this.loading = false
            },
            // 图片加载失败
            loadError() {
                this.loading = false
            },
            // 面包屑导航切换
            changeMenu(activePath) {
                this.information.$emit('activePath', activePath)
            }
        }
    }
</script>

<style lang="less" scoped>
    .centerFont {
        font-weight: bold;
        font-size: 20px;
        text-align: center;
    }

    .upload-demo {
        width: 50px !important;
        display: inline-block;
    }

    .fade-enter-active, .fade-leave-active {
        transition: all 1s;
    }

    .fade-enter, .fade-leave-to {
        opacity: 0;
        transform: translateX(-200px);
    }
</style>
