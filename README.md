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
## 日志
### 2021.4.20
- 完成欢迎页面的80％。最后一个内容取决于其他模块，因此我将在后面进行编码。 
### 2021.4.24
- 支持通过用户的问答来查找用户密码的新功能。完成Login.vue，Users.vue和Types.vue。
### 2021.5.6
- 仔细思考下，本软件在国外开源使用的概率几乎为零，为零让合作伙伴看得懂，今天将README翻译成了中文，上述内容纯属机翻，可能词不达意请理解。
- 使用require导入本地图片，取消使用外链图片的访问不稳定问题。
- 修改角色页面的提示次数，用户每次登陆只会提示两次。
- 修复了我的商品界面显示的商品数量为最高数量。
- 添加通过商品号查询用户的接口。
- 修改添加商品的接口，现在不需要设置relation中的商品数量，因为购买商品之后的商品号需要用户重新定义，这样的话就不会发生数据库主键的重复。
- 修复表单校验规则中拖动条的验证时机为change，这样每次修改都可以进行验证。
- 基本完成了购买商品的页面，用户可以查询商品卖家的联系方式，通过核对信息后转换数据内容的形式将其购置为自己的商品，并且添加了二维码付款的功能。
