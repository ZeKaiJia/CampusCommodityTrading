# 校园商品交易
## 简介
一个简单的商品交易管理系统。基于信息管理系统程序。 
## 短期需求
- 前端区块计算过程放在process动画之前运行。后端调整区块链破坏后的响应信息。
- 开发权限实体。
- docs组件中修改iframe背景颜色为白色，字体颜色为黑色。
- 整合Shiro或Spring Security。
## 区块链技术
经过测试增加一个新的区块即挖矿必须花费一定时间，难度5大概是3秒左右，可以提高难度。因为篡改的区块链将无法赶上长链和有效链，
除非他们比你网络中所有的节点拥有更大的计算速度，可能是未来的量子计算机或者是其他什么。如果有人在区块链系统中恶意篡改数据：
1. 他们的区块链是无效的。
2. 他们无法创建更长的区块链。
3. 网络中诚实的区块链会在长链中更有时间的优势。
4. 有很多区块组成用来存储数据。
5. 有数字签名让区块链链接在一起。
6. 需要挖矿的工作量证明新的区块。
7. 可以用来检查数据是否是有效的同时是未经篡改的。
## 日志
### 2021.5.22
- 修复了几个小bug，动效优化。
- 修复了复制卖家联系方式时提示文字不在dialog层显示的bug。
- 修复了购买商品时号码重复仍旧可以执行的bug。
- 商品收货添加了评论功能，商品修改添加了商品描述功能（伪功能）。
- 定期将开发日志打包到cct-src-doc-log
- 添加开源项目的数据可视化界面，升级管理员界面，还需要调整样式以适配项目内容。
- 修改登录界面组件尺寸，修改商品页面布局。

### 2021.5.23
- 完成服务器部署。

### 2021.5.24
- 修复了登录页面注册新用户时不输入电话和邮箱也会触发校验的bug。
- 使用this.$message({message: '！', type: '', customClass: 'zZindex'})修复了dialog笼罩层遮盖message的bug。
- 修改了不同类型用户登录后的欢迎界面内容。
- 添加了导航栏逻辑，现在可以根据用户的类别分割出不同的菜单项，管理员可以使用全部的菜单项。
- 修改了用户添加新地址的逻辑，现在使用弹出框获取地址信息，减少用户错误操作。
- 修改了购买商品的逻辑，现在下单后不会创建隐藏商品，用户收货后不会将购买的商品投入市场。
- 修改了数据库外键联系，调整后端Controller代码

### 2021.5.25
- 数据库已更新，时间改为每天凌晨12点重置一次。
- 重构后台大数据可视化系统页面内容，调整为项目内容。
- 用户头像上传增加人性化提示。
- 用户和角色列表提供详细内部信息展示。

### 2021.5.26
- 购买商品和我的商品页面添加了卡片格式和列表格式的切换，新增过渡动画

### 2021.5.27
- 订单添加付款状态和到期时间，由于未使用支付宝付款api，默认未付款，到期时间在确认收货时会根据收货时间和租赁时长自动计算。
- 优化用户界面，提供更多查询方式，修复查询bug。
- 新增区块链技术，考虑到实际应用场景，需要新增区块链的数据库表进行存储，否则不方便操作，专门用来对订单进行校验。

### 2021.5.29
- 后端添加区块链逻辑，保护订单的生成。
- 数据库已更新，关闭自动重置函数。
