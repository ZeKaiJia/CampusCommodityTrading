# 校园商品交易
## 描述
这是我的Java Web类的前后分离项目。 
## 简介
一个简单的商品交易管理系统。基于信息管理系统程序。 
## 计划安排
### 前端
-现在，我开始构建Front程序。 
-查找越来越少的加载器错误。高版本的less不能分析'less'的配置。因此，我必须卸载它们并安装低版本。 
### 后端
-现在设计SQL表。包括sys_user，sys_role，sys_commodity和rel_user_role在内，实际上它们只是用户，角色和商品的三个模型。
我将用更多模型来完成本模块。 
-完成简单的api程序。 
## 短期需求（此处感谢我机智的女朋友想出这么多需求，救命）
- 订单记录（加表）
- 商品详细（富文本编辑）
- 发货方式（地址，外卖员角色，配送价格，配送时间限制）
- 在线聊天系统
## 日志
### 2021.4.20
- 完成欢迎页面的80％。最后一个内容取决于其他模块，因此我将在后面进行编码。 
### 2021.4.24
- 支持通过用户的问答来查找用户密码的新功能。完成Login.vue，Users.vue和Types.vue。
### 2021.5.6
- 仔细思考下，本软件在国外开源使用的概率几乎为零，为了让合作伙伴看得懂，今天将README翻译成了中文，上述内容纯属机翻，可能词不达意请理解。
- 使用require导入本地图片，取消使用外链图片的访问不稳定问题。
- 修改角色页面的提示次数，用户每次登陆只会提示两次。
- 修复了我的商品界面显示的商品数量为最高数量。
- 添加通过商品号查询用户的接口。
- 修改添加商品的接口，现在不需要设置relation中的商品数量，因为购买商品之后的商品号需要用户重新定义，这样的话就不会发生数据库主键的重复。
- 修复表单校验规则中拖动条的验证时机为change，这样每次修改都可以进行验证。
- 基本完成了购买商品的页面，用户可以查询商品卖家的联系方式，通过核对信息后转换数据内容的形式将其购置为自己的商品，并且添加了二维码付款的功能。
### 2021.5.7
- 修复了多次打开同一标签导致重复创建clipboard对象，重复提示成功信息的错误
- 新增商品查询接口
- 修改Mapper中`字段 != ''`的判断，这样会导致更新商品数量为0时被Mybatis拦截
- 添加了清空我的商品中库存为0的商品功能
- 正在开发购买页面查询功能，需要提供更多的后台API接口

### 2021.5.10
- 后端新增图片上传接口，可以将base64编码过后的图片上传至gitee仓库供前端访问。还需要修改数据库用户表的字段。
- 前端新增用户头像修改功能，根据用户性别初始化五组头像，可以由用户自己上传并保存在服务器上。
- 添加商品图片上传功能，图片加载方面还可以优化，有时候会遇到上传后仍旧是上一张图片的情况，暂时没找到原因。
- 完成商品查找功能，可以按照多字段搜索，String类型的字段支持模糊查找。
- 修复了图片上传时叠加fileList导致重复上传的bug。
- 更新数据库文件，现在可以重新构建数据库。

### 2021.5.11
- 添加商品评价功能，数据库sys_commodity表新增comRate（评价分数）comRateCount（评价人数）两个字段，浏览页面评价只读，购买时可以填写并发布评价。
- 数据库文件已更新。

### 2021.5.13
- 新增数据库订单表，添加订单实体。
- 后端新增订单相关接口，支持多字段查询，根据订单状态自动更新时间信息