# 智能化共享租赁平台
## 简介
一个简单的商品交易管理系统。基于信息管理系统程序。 

## 短期需求
- Excel导入时还需要为用户创建角色，添加表单校验和异常捕获。
- docs组件中修改iframe背景颜色为白色，字体颜色为黑色。

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
### 2021.5.31
- 优化了购买商品时商品数量的显示，现在最多只显示原有商品的存货数量。
- 修改了部分用户无法授权的权限。
- 修复Swagger提示。
- 修复了用户没有评价的商品提示暂无评价导致的卡片视图不美观问题。
- 修复了购买商品界面表格视图按钮的错误。
- 修复了租赁方下架商品之后导致的承租方无法结单的问题。
- 修复了租赁方首页导航至不存在页面的问题。
- 修复了返回顶部组件失效的问题，并且为其添加动画。

### 2021.6.1
- 修复了返回顶部的动态绑定值类型错误。

### 2021.6.2
- 添加了用户Excel表导入功能。

### 2021.6.4
- 新增用户数据导出功能，表格样式待完善。
- 允许Mybatis多语句操作。
- 动态调整前端axios请求路径。

### 2021.6.5
- 进一步优化动态请求路径。
- 优化表格导出样式。~~想问题千万不能钻牛角尖，当你觉得一件事非常复杂繁琐的时候，不妨想一想有没有什么捷径。~~
- 修改单次上传数据量上限为100MB，单文件上限为10MB。
- 完善数据库数据，更新数据库文件。
- 部署正式版软件，今后都不需要修改参数即可完成部署。
