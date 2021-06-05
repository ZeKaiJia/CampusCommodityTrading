/*
 Navicat Premium Data Transfer

 Source Server         : java
 Source Server Type    : MySQL
 Source Server Version : 80019
 Source Host           : localhost:3306
 Source Schema         : javaweb

 Target Server Type    : MySQL
 Target Server Version : 80019
 File Encoding         : 65001

 Date: 05/06/2021 23:26:25
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for rel_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `rel_role_permission`;
CREATE TABLE `rel_role_permission`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `roleId` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色号',
  `perCode` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '权限代码',
  PRIMARY KEY (`id`, `roleId`, `perCode`) USING BTREE,
  INDEX `perCode`(`perCode`) USING BTREE,
  INDEX `RRProleId`(`roleId`) USING BTREE,
  CONSTRAINT `RRPperCode` FOREIGN KEY (`perCode`) REFERENCES `sys_permission` (`perCode`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `RRProleId` FOREIGN KEY (`roleId`) REFERENCES `sys_role` (`roleId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 366 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '角色权限关联表';

-- ----------------------------
-- Records of rel_role_permission
-- ----------------------------
BEGIN;
INSERT INTO `rel_role_permission` (`id`, `roleId`, `perCode`) VALUES (266, '1', 'admin:address:select'), (269, '1', 'admin:order:select'), (297, '1', 'admin:permission:delete'), (299, '1', 'admin:permission:findPermissionByRoleId'), (284, '1', 'admin:permission:insert'), (295, '1', 'admin:permission:managePermission'), (276, '1', 'admin:permission:select'), (289, '1', 'admin:permission:selectById'), (285, '1', 'admin:permission:update'), (296, '1', 'admin:role:delete'), (275, '1', 'admin:role:insert'), (293, '1', 'admin:role:update'), (290, '1', 'admin:user:delete'), (277, '1', 'admin:user:select'), (361, '3', 'anon:user:update'), (273, '1', 'buyer:commodity:select'), (337, '2', 'buyer:commodity:select'), (268, '1', 'buyer:commodity:selectByPriceBetween'), (331, '2', 'buyer:commodity:selectByPriceBetween'), (264, '1', 'buyer:commodity:selectByQuantityBetween'), (324, '2', 'buyer:commodity:selectByQuantityBetween'), (288, '1', 'buyer:commodity:selectByQuantityNow'), (334, '2', 'buyer:commodity:selectByQuantityNow'), (287, '1', 'buyer:commodity:selectCommodityUser'), (335, '2', 'buyer:commodity:selectCommodityUser'), (263, '1', 'buyer:commodity:updateRate'), (323, '2', 'buyer:commodity:updateRate'), (274, '1', 'buyer:order:insert'), (341, '2', 'buyer:order:insert'), (278, '1', 'saler:commodity:delete'), (362, '3', 'saler:commodity:delete'), (280, '1', 'saler:commodity:deleteAllZero'), (363, '3', 'saler:commodity:deleteAllZero'), (292, '1', 'saler:commodity:insert'), (358, '3', 'saler:commodity:insert'), (298, '1', 'user:address:delete'), (343, '2', 'user:address:delete'), (360, '3', 'user:address:delete'), (261, '1', 'user:address:deleteByName'), (325, '2', 'user:address:deleteByName'), (346, '3', 'user:address:deleteByName'), (271, '1', 'user:address:insert'), (338, '2', 'user:address:insert'), (355, '3', 'user:address:insert'), (286, '1', 'user:address:selectByName'), (333, '2', 'user:address:selectByName'), (353, '3', 'user:address:selectByName'), (272, '1', 'user:address:update'), (339, '2', 'user:address:update'), (356, '3', 'user:address:update'), (265, '1', 'user:commodity:selectByAnyParam'), (328, '2', 'user:commodity:selectByAnyParam'), (349, '3', 'user:commodity:selectByAnyParam'), (281, '1', 'user:commodity:selectById'), (326, '2', 'user:commodity:selectById'), (347, '3', 'user:commodity:selectById'), (267, '1', 'user:commodity:selectByName'), (332, '2', 'user:commodity:selectByName'), (352, '3', 'user:commodity:selectByName'), (262, '1', 'user:commodity:selectUserCommodity'), (327, '2', 'user:commodity:selectUserCommodity'), (348, '3', 'user:commodity:selectUserCommodity'), (283, '1', 'user:commodity:update'), (330, '2', 'user:commodity:update'), (351, '3', 'user:commodity:update'), (282, '1', 'user:gitee:refreshPage'), (329, '2', 'user:gitee:refreshPage'), (350, '3', 'user:gitee:refreshPage'), (279, '1', 'user:gitee:saveImg'), (344, '2', 'user:gitee:saveImg'), (364, '3', 'user:gitee:saveImg'), (270, '1', 'user:order:selectByAnyParam'), (336, '2', 'user:order:selectByAnyParam'), (354, '3', 'user:order:selectByAnyParam'), (300, '1', 'user:order:selectById'), (345, '2', 'user:order:selectById'), (365, '3', 'user:order:selectById'), (291, '1', 'user:order:update'), (340, '2', 'user:order:update'), (357, '3', 'user:order:update'), (294, '1', 'user:user:logout'), (342, '2', 'user:user:logout'), (359, '3', 'user:user:logout');
COMMIT;

-- ----------------------------
-- Table structure for rel_user_commodity
-- ----------------------------
DROP TABLE IF EXISTS `rel_user_commodity`;
CREATE TABLE `rel_user_commodity`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '序号',
  `comId` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商品号',
  `userName` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `name`(`userName`) USING BTREE,
  INDEX `id`(`comId`) USING BTREE,
  CONSTRAINT `RUCcomId` FOREIGN KEY (`comId`) REFERENCES `sys_commodity` (`comId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `RUCuserName` FOREIGN KEY (`userName`) REFERENCES `sys_user` (`userName`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 57 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户商品关联表';

-- ----------------------------
-- Records of rel_user_commodity
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for rel_user_role
-- ----------------------------
DROP TABLE IF EXISTS `rel_user_role`;
CREATE TABLE `rel_user_role`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '序号',
  `userName` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  `roleId` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `userName`(`userName`) USING BTREE,
  INDEX `roleId`(`roleId`) USING BTREE,
  CONSTRAINT `RURroleId` FOREIGN KEY (`roleId`) REFERENCES `sys_role` (`roleId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `RURuserName` FOREIGN KEY (`userName`) REFERENCES `sys_user` (`userName`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 98 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户角色关联表';

-- ----------------------------
-- Records of rel_user_role
-- ----------------------------
BEGIN;
INSERT INTO `rel_user_role` (`id`, `userName`, `roleId`) VALUES (1, 'admin', '1'), (2, 'buyer', '2'), (3, 'test', '1'), (4, 'saler', '3'), (5, 'buyer2', '2'), (6, 'saler2', '3'), (70, 'Xb18620201', '1'), (71, 'Xb18620202', '1'), (72, 'Xb18620203', '1'), (73, 'Xb18620204', '1'), (74, 'Xb18620205', '1'), (75, 'Xb18620207', '1'), (76, 'Xb18620208', '1'), (77, 'Xb18620210', '1'), (78, 'Xb18620213', '1'), (79, 'Xb18620214', '1'), (80, 'Xb18620215', '1'), (81, 'Xb18620216', '1'), (82, 'Xb18620217', '1'), (83, 'Xb18620218', '1'), (84, 'Xb18620219', '1'), (85, 'Xb18620220', '1'), (86, 'Xb18620221', '1'), (87, 'Xb18620222', '1'), (88, 'Xb18620224', '1'), (89, 'Xb18620225', '1'), (90, 'Xb18620227', '1'), (91, 'Xb18620230', '1'), (92, 'Xb18620231', '1'), (93, 'Xb18620232', '1'), (94, 'Xc18520308', '1'), (95, 'Xf18220105', '1'), (96, 'X201801018', '1'), (97, 'Xb17620226', '1');
COMMIT;

-- ----------------------------
-- Table structure for sec_block_chain
-- ----------------------------
DROP TABLE IF EXISTS `sec_block_chain`;
CREATE TABLE `sec_block_chain`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '序号',
  `data` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '数据',
  `hash` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '哈希值',
  `previousHash` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '上一个区块哈希值',
  `timeStamp` bigint(0) NULL DEFAULT NULL COMMENT '时间戳',
  `nonce` int(0) NULL DEFAULT NULL COMMENT '一次性值',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '安全区块链';

-- ----------------------------
-- Records of sec_block_chain
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_commodity
-- ----------------------------
DROP TABLE IF EXISTS `sys_commodity`;
CREATE TABLE `sys_commodity`  (
  `comId` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商品号',
  `comName` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '名称',
  `comQuantity` int(0) NOT NULL COMMENT '数量',
  `comQuantityNow` int(0) NOT NULL COMMENT '当前数量',
  `comEachPrice` double NOT NULL COMMENT '单价',
  `comDescription` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '描述',
  `comRateCount` int(0) NOT NULL COMMENT '评价次数',
  `comRate` double NOT NULL COMMENT '评价',
  `comPicture` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '图片',
  `utcCreate` bigint(0) NOT NULL COMMENT '创建时间',
  `utcModify` bigint(0) NOT NULL COMMENT '修改时间',
  `modifyBy` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '修改人',
  `valid` bit(1) NOT NULL COMMENT '是否有效',
  `remark` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `customa` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '自定义字段a',
  `customb` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '自定义字段b',
  PRIMARY KEY (`comId`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '系统商品表';

-- ----------------------------
-- Records of sys_commodity
-- ----------------------------
BEGIN;
INSERT INTO `sys_commodity` (`comId`, `comName`, `comQuantity`, `comQuantityNow`, `comEachPrice`, `comDescription`, `comRateCount`, `comRate`, `comPicture`, `utcCreate`, `utcModify`, `modifyBy`, `valid`, `remark`, `customa`, `customb`) VALUES ('厨具001', '不锈钢菜刀', 88, 86, 6.8, '一套不锈钢刀具', 1, 1, 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1622906032566.png', 1622906027922, 1622906150425, 'buyer2', b'1', NULL, NULL, NULL), ('器械001', '洒水器', 100, 0, 18, '360°农业自动洒水器', 1, 4, 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1622905871531.png', 1622905868083, 1622906240524, 'buyer', b'1', NULL, NULL, NULL), ('宠物001', '领养博美幼犬', 1, 0, 12, '只需运费！！！', 1, 2, 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1621874272655.jpg', 1621874264014, 1622906166458, 'buyer2', b'1', NULL, NULL, NULL), ('家具001', '大理石圆桌', 6, 6, 68, '轻奢大理石装饰桌', 1, 3, 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1622906068486.jpg', 1622906064592, 1622906069218, 'saler2', b'1', NULL, NULL, NULL), ('家具002', '吊椅', 100, 100, 9.9, '塑料鸟巢吊椅', 1, 4, 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1622906117715.png', 1622906113406, 1622906119980, 'saler2', b'1', NULL, NULL, NULL), ('服饰001', '帆布鞋', 40, 40, 15, '平底匡威帆布鞋', 1, 5, 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1622905966339.png', 1622905960142, 1622905967742, 'saler', b'1', NULL, NULL, NULL), ('生活001', '防紫外线伞', 100, 96, 5, '临时用伞', 2, 4.5, 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1621874745440.jpg', 1621874739991, 1622906271399, 'buyer', b'1', NULL, NULL, NULL), ('电器001', '大容量移动电源', 5, 5, 50, '淘宝同款超大容量移动电源', 1, 3.5, 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1621874463368.jpg', 1621874459351, 1622226485034, 'admin', b'1', NULL, NULL, NULL), ('饰品001', '情侣项链', 2, 1, 6, '两对情侣纯银项链', 1, 2.5, 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1622905916193.png', 1622905912372, 1622906255620, 'buyer', b'1', NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_order
-- ----------------------------
DROP TABLE IF EXISTS `sys_order`;
CREATE TABLE `sys_order`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '序号',
  `orderComId` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '交易商品',
  `orderSalerName` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '卖家账号',
  `orderBuyerName` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '买家账号',
  `orderSalerAddress` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '发货地址',
  `orderBuyerAddress` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '收货地址',
  `orderTransportCode` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '运单号',
  `orderCreateTime` bigint(0) NULL DEFAULT NULL COMMENT '创建时间',
  `orderTransportTime` bigint(0) NULL DEFAULT NULL COMMENT '发货时间',
  `orderReceiveTime` bigint(0) NULL DEFAULT NULL COMMENT '收货时间',
  `orderStatus` int(0) NOT NULL COMMENT '订单状态\n1：已下单\n2：已发货\n3：已收货',
  `orderPayStatus` int(0) NOT NULL COMMENT '付款状态\n1：已付款\n2：未付款',
  `orderTime` bigint(0) NOT NULL COMMENT '截止时间',
  `utcCreate` bigint(0) NOT NULL COMMENT '创建时间',
  `utcModify` bigint(0) NOT NULL COMMENT '修改时间',
  `modifyBy` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '修改人',
  `valid` bit(1) NOT NULL COMMENT '是否有效',
  `remark` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `customa` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '自定义字段a',
  `customb` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '自定义字段b',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '系统订单表';

-- ----------------------------
-- Records of sys_order
-- ----------------------------
BEGIN;
INSERT INTO `sys_order` (`id`, `orderComId`, `orderSalerName`, `orderBuyerName`, `orderSalerAddress`, `orderBuyerAddress`, `orderTransportCode`, `orderCreateTime`, `orderTransportTime`, `orderReceiveTime`, `orderStatus`, `orderPayStatus`, `orderTime`, `utcCreate`, `utcModify`, `modifyBy`, `valid`, `remark`, `customa`, `customb`) VALUES (8, '厨具001', 'saler2', 'buyer2', '2号出租方地址', '2号买家地址', '1978657234', 1622906149437, 1622906329036, NULL, 2, 2, 604800000, 1622906150412, 1622906150412, 'buyer2', b'1', NULL, NULL, NULL), (9, '宠物001', 'saler', 'buyer2', '出租方地址', '2号买家地址', '1857462758', 1622906165060, 1622906295423, NULL, 2, 2, 31536000000, 1622906166450, 1622906166450, 'buyer2', b'1', NULL, NULL, NULL), (10, '器械001', 'saler', 'buyer2', NULL, '2号买家地址', NULL, 1622906186364, NULL, NULL, 1, 2, 2592000000, 1622906187458, 1622906187458, 'buyer2', b'1', NULL, NULL, NULL), (11, '器械001', 'saler', 'buyer', '发货地址1', '买家收货地址', '1968473857', 1622906239345, 1622906309823, 1622906360037, 3, 2, 1623511160037, 1622906240504, 1622906240504, 'buyer', b'1', NULL, NULL, NULL), (12, '饰品001', 'saler', 'buyer', NULL, '浙江理工大学科技与艺术学院', NULL, 1622906253684, NULL, NULL, 1, 2, 604800000, 1622906255598, 1622906255598, 'buyer', b'1', NULL, NULL, NULL), (13, '生活001', 'saler2', 'buyer', '测试发货地址2', '浙江理工大学科技与艺术学院', '1258675623', 1622906270575, 1622906337351, NULL, 2, 2, 2592000000, 1622906271376, 1622906271376, 'buyer', b'1', NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_permission`;
CREATE TABLE `sys_permission`  (
  `perId` int(0) NOT NULL AUTO_INCREMENT COMMENT '序号',
  `perName` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '权限名',
  `perCode` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '代码',
  `perUrl` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '请求路径',
  `utcCreate` bigint(0) NOT NULL COMMENT '创建时间',
  `utcModify` bigint(0) NOT NULL COMMENT '修改时间',
  `modifyBy` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '修改人',
  `valid` bit(1) NOT NULL COMMENT '是否有效',
  `remark` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `customa` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '自定义字段a',
  `customb` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '自定义字段b',
  PRIMARY KEY (`perId`, `perCode`) USING BTREE,
  INDEX `perCode`(`perCode`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 50 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '系统权限表';

-- ----------------------------
-- Records of sys_permission
-- ----------------------------
BEGIN;
INSERT INTO `sys_permission` (`perId`, `perName`, `perCode`, `perUrl`, `utcCreate`, `utcModify`, `modifyBy`, `valid`, `remark`, `customa`, `customb`) VALUES (1, '添加用户', 'anon:user:insert', 'user/insert', 1622385207468, 1622385441400, 'admin', b'1', NULL, '0', NULL), (2, '删除用户', 'admin:user:delete', 'user/delete', 1622385595617, 1622385595617, 'admin', b'1', NULL, '2', NULL), (3, '更新用户信息', 'anon:user:update', 'user/update', 1622385633154, 1622385633154, 'admin', b'1', NULL, '0', NULL), (4, '查询全体用户', 'admin:user:select', 'user/select', 1622385708360, 1622385708360, 'admin', b'1', NULL, '2', NULL), (5, '根据用户名查询用户', 'anon:user:selectByName', 'user/selectByName', 1622385766718, 1622385766718, 'admin', b'1', NULL, '0', NULL), (6, '用户登陆', 'anon:user:login', 'user/login', 1622385802158, 1622385802158, 'admin', b'1', NULL, '0', NULL), (7, '用户退出', 'user:user:logout', 'user/logout', 1622385852039, 1622385852039, 'admin', b'1', NULL, '1', NULL), (8, '强制登录', 'inner:user:toLogin', 'user/toLogin', 1622385915891, 1622385915891, 'admin', b'1', NULL, '3', NULL), (9, '添加角色', 'admin:role:insert', 'role/insert', 1622385966197, 1622385966197, 'admin', b'1', NULL, '2', NULL), (10, '删除角色', 'admin:role:delete', 'role/delete', 1622385990035, 1622385990035, 'admin', b'1', NULL, '2', NULL), (11, '更新角色', 'admin:role:update', 'role/update', 1622386016974, 1622386016974, 'admin', b'1', NULL, '2', NULL), (12, '查询全体角色', 'anon:role:select', 'role/select', 1622386179215, 1622386179215, 'admin', b'1', NULL, '0', NULL), (13, '根据用户名查询角色', 'anon:role:selectUserRole', 'role/selectUserRole', 1622386303575, 1622386303575, 'admin', b'1', NULL, '0', NULL), (14, '根据角色号查询角色', 'anon:role:selectById', 'role/selectById', 1622386326940, 1622462924531, 'admin', b'1', NULL, '0', NULL), (15, '添加地址', 'user:address:insert', 'address/insert', 1622386396514, 1622386396514, 'admin', b'1', NULL, '1', NULL), (16, '删除地址', 'user:address:delete', 'address/delete', 1622386424450, 1622386424450, 'admin', b'1', NULL, '1', NULL), (17, '按用户名删除地址', 'user:address:deleteByName', 'address/deleteByName', 1622386457995, 1622386457995, 'admin', b'1', NULL, '1', NULL), (18, '更新地址', 'user:address:update', 'address/update', 1622386484174, 1622386484174, 'admin', b'1', NULL, '1', NULL), (19, '查询全部地址', 'admin:address:select', 'address/select', 1622386506544, 1622388921654, 'admin', b'1', NULL, '2', NULL), (20, '根据用户名查询地址', 'user:address:selectByName', 'address/selectByName', 1622386533492, 1622388926341, 'admin', b'1', NULL, '1', NULL), (21, '添加商品', 'saler:commodity:insert', 'commodity/insert', 1622388002204, 1622388002204, 'admin', b'1', NULL, '1', NULL), (22, '删除商品', 'saler:commodity:delete', 'commodity/delete', 1622388323569, 1622388323569, 'admin', b'1', NULL, '1', NULL), (23, '删除用户无存货商品', 'saler:commodity:deleteAllZero', 'commodity/deleteAllZero', 1622388346996, 1622388346996, 'admin', b'1', NULL, '1', NULL), (24, '更新商品信息', 'user:commodity:update', 'commodity/update', 1622388373349, 1622462882618, 'admin', b'1', NULL, '1', NULL), (25, '更新商品评价', 'buyer:commodity:updateRate', 'commodity/updateRate', 1622388412021, 1622388412021, 'admin', b'1', NULL, '1', NULL), (26, '查询全体商品', 'buyer:commodity:select', 'commodity/select', 1622388455498, 1622388455498, 'admin', b'1', NULL, '1', NULL), (27, '根据商品号查询商品', 'user:commodity:selectById', 'commodity/selectById', 1622388490387, 1622388490387, 'admin', b'1', NULL, '1', NULL), (28, '根据商品名称查询商品', 'user:commodity:selectByName', 'commodity/selectByName', 1622388517712, 1622388517712, 'admin', b'1', NULL, '1', NULL), (29, '根据商品价格包含区间查询商品', 'buyer:commodity:selectByPriceBetween', 'commodity/selectByPriceBetween', 1622388590735, 1622388590735, 'admin', b'1', NULL, '1', NULL), (30, '根据商品存货查询商品', 'buyer:commodity:selectByQuantityNow', 'commodity/selectByQuantityNow', 1622388612491, 1622388612491, 'admin', b'1', NULL, '1', NULL), (31, '根据商品存货区间查询商品', 'buyer:commodity:selectByQuantityBetween', 'commodity/selectByQuantityBetween', 1622388637591, 1622388637591, 'admin', b'1', NULL, '1', NULL), (32, '根据用户名查询商品', 'user:commodity:selectUserCommodity', 'commodity/selectUserCommodity', 1622388669086, 1622388669086, 'admin', b'1', NULL, '1', NULL), (33, '根据商品号查询用户', 'buyer:commodity:selectCommodityUser', 'commodity/selectCommodityUser', 1622388710379, 1622388710379, 'admin', b'1', NULL, '1', NULL), (34, '根据指定字段查询商品', 'user:commodity:selectByAnyParam', 'commodity/selectByAnyParam', 1622388735338, 1622388908842, 'admin', b'1', NULL, '1', NULL), (35, '添加订单', 'buyer:order:insert', 'order/insert', 1622388762483, 1622388762483, 'admin', b'1', NULL, '1', NULL), (36, '删除订单', 'inner:order:delete', 'order/delete', 1622388790449, 1622388790449, 'admin', b'1', NULL, '3', NULL), (37, '更新订单', 'user:order:update', 'order/update', 1622388833428, 1622388833428, 'admin', b'1', NULL, '1', NULL), (38, '查询全体订单', 'admin:order:select', 'order/select', 1622388853496, 1622388853496, 'admin', b'1', NULL, '2', NULL), (39, '根据ID号查询订单', 'user:order:selectById', 'order/selectById', 1622388899751, 1622465413076, 'admin', b'1', NULL, '2', NULL), (40, '根据指定字段查询订单', 'user:order:selectByAnyParam', 'order/selectByAnyParam', 1622388963543, 1622388963543, 'admin', b'1', NULL, '1', NULL), (41, '上传文件', 'user:gitee:saveImg', 'gitee/saveImg', 1622389006703, 1622389006703, 'admin', b'1', NULL, '1', NULL), (42, '刷新Gitee Page', 'user:gitee:refreshPage', 'gitee/refreshPage', 1622389031352, 1622389031352, 'admin', b'1', NULL, '1', NULL), (43, '添加权限', 'admin:permission:insert', 'permission/insert', 1622389069564, 1622389069564, 'admin', b'1', NULL, '2', NULL), (44, '删除权限', 'admin:permission:delete', 'permission/delete', 1622389091018, 1622389091018, 'admin', b'1', NULL, '2', NULL), (45, '更新权限', 'admin:permission:update', 'permission/update', 1622389109556, 1622389109556, 'admin', b'1', NULL, '2', NULL), (46, '查询全体权限', 'admin:permission:select', 'permission/select', 1622389179678, 1622389179678, 'admin', b'1', NULL, '2', NULL), (47, '根据ID查询权限', 'admin:permission:selectById', 'permission/selectById', 1622389222987, 1622389222987, 'admin', b'1', NULL, '2', NULL), (48, '根据角色号查询权限', 'admin:permission:findPermissionByRoleId', 'permission/findPermissionByRoleId', 1622432653963, 1622432653963, 'admin', b'1', NULL, '2', NULL), (49, '创建角色权限链接', 'admin:permission:managePermission', 'permission/managePermission', 1622432679207, 1622432679207, 'admin', b'1', NULL, '2', NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `roleId` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色号',
  `roleNameCn` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '中文名',
  `roleNameEn` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '英文名',
  `roleDescription` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '描述',
  `utcCreate` bigint(0) NOT NULL COMMENT '创建时间',
  `utcModify` bigint(0) NOT NULL COMMENT '修改时间',
  `modifyBy` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '修改人',
  `valid` bit(1) NOT NULL COMMENT '是否有效',
  `remark` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `customa` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '权限等级\n0：公共权限\n1：用户权限\n2：管理权限\n3：内部权限',
  `customb` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '自定义字段b',
  PRIMARY KEY (`roleId`, `roleNameEn`) USING BTREE,
  INDEX `roleId`(`roleId`) USING BTREE,
  INDEX `roleNameEn`(`roleNameEn`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '系统角色表';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
BEGIN;
INSERT INTO `sys_role` (`roleId`, `roleNameCn`, `roleNameEn`, `roleDescription`, `utcCreate`, `utcModify`, `modifyBy`, `valid`, `remark`, `customa`, `customb`) VALUES ('1', '管理员', 'admin', '管理员角色，拥有最高权限', 1621074167413, 1621074167413, 'Xb18620208', b'1', NULL, NULL, NULL), ('2', '承租方', 'buyer', '承租商品角色', 1621074167413, 1621074167413, 'Xb18620208', b'1', NULL, NULL, NULL), ('3', '出租方', 'saler', '出租商品角色', 1621074167413, 1621074167413, 'Xb18620208', b'1', NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `userName` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  `userPassword` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
  `userNick` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '姓名',
  `userGender` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '性别',
  `userPhone` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '电话',
  `userEmail` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  `userQuest` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密保问题',
  `userAnswer` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密保答案',
  `userAvatar` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像',
  `userLastLogin` bigint(0) NULL DEFAULT NULL COMMENT '最近登录时间',
  `utcCreate` bigint(0) NOT NULL COMMENT '创建时间',
  `utcModify` bigint(0) NOT NULL COMMENT '修改时间',
  `modifyBy` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '修改人',
  `valid` bit(1) NOT NULL COMMENT '是否有效',
  `remark` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `customa` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '自定义字段a',
  `customb` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '自定义字段b',
  PRIMARY KEY (`userName`) USING BTREE,
  INDEX `userName`(`userName`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '系统用户表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
BEGIN;
INSERT INTO `sys_user` (`userName`, `userPassword`, `userNick`, `userGender`, `userPhone`, `userEmail`, `userQuest`, `userAnswer`, `userAvatar`, `userLastLogin`, `utcCreate`, `utcModify`, `modifyBy`, `valid`, `remark`, `customa`, `customb`) VALUES ('admin', 'admin', 'admin', '男', '13506839371', '845923059@qq.com', '您的大学叫什么？', '科艺', 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1621873483819.jpg', 1622905755460, 1621700765210, 1622427713723, 'admin', b'1', NULL, NULL, NULL), ('buyer', 'admin', '承租方', '女', '13565120077', 'hxy1999@gmail.com', '您最好的朋友叫什么？', '贾泽楷', NULL, 1622906349853, 1621873543898, 1621873543898, 'admin', b'1', NULL, NULL, NULL), ('buyer2', 'admin', '承租方2', '女', '13459834838', '2@qq.com', '您的大学叫什么？', '科艺', NULL, 1622906129536, 1621873937734, 1621875584846, 'admin', b'1', NULL, NULL, NULL), ('saler', 'admin', '出租方', '男', '13506839372', '888888888@qq.com', '您的大学叫什么？', '科艺', 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1621873980422.png', 1622906281157, 1621873454905, 1621873982071, 'saler', b'1', NULL, NULL, NULL), ('saler2', 'admin', '出租方2', '男', '13311111111', '121212@11.com', '您的大学叫什么？', '科艺', 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1621874549792.jpeg', 1622906318310, 1621873918374, 1621875604877, 'admin', b'1', NULL, NULL, NULL), ('test', 'admin', '测试用户', '男', '13509090909', 'oxoxoxoxoxo@163.com', '您的电子邮箱是？', 'oxoxoxoxoxo@163.com', NULL, NULL, 1621873643774, 1621873643774, 'admin', b'1', NULL, NULL, NULL), ('X201801018', 'admin', '谢雨宏', '男', '15257878631', '1531258826@qq.com', '您的大学叫什么？', '科艺', '', NULL, 1622905772397, 1622905772397, 'admin', b'1', NULL, NULL, NULL), ('Xb17620226', 'admin', '赵海涛', '男', '13566478616', '1174696826@qq.com', '您的大学叫什么？', '科艺', '', NULL, 1622905772397, 1622905772397, 'admin', b'1', NULL, NULL, NULL), ('Xb18620201', 'admin', '曾龙', '男', '17826732865', '1071821598@qq.com', '您的大学叫什么？', '科艺', '', NULL, 1622905772396, 1622905772396, 'admin', b'1', NULL, NULL, NULL), ('Xb18620202', 'admin', '陈伟健', '男', '17826731969', '1194108898@qq.com', '您的大学叫什么？', '科艺', '', NULL, 1622905772396, 1622905772396, 'admin', b'1', NULL, NULL, NULL), ('Xb18620203', 'admin', '陈伟健', '男', '17826731971', '10698134312@qq.com', '您的大学叫什么？', '科艺', '', NULL, 1622905772396, 1622905772396, 'admin', b'1', NULL, NULL, NULL), ('Xb18620204', 'admin', '冯长江', '男', '15356750051', '1479697542@qq.com', '您的大学叫什么？', '科艺', '', NULL, 1622905772396, 1622905772396, 'admin', b'1', NULL, NULL, NULL), ('Xb18620205', 'admin', '郭文彬', '男', '15356751363', '2841313980@qq.com', '您的大学叫什么？', '科艺', '', NULL, 1622905772396, 1622905772396, 'admin', b'1', NULL, NULL, NULL), ('Xb18620207', 'admin', '黄声普', '男', '13506879544', '1012745950@qq.com', '您的大学叫什么？', '科艺', '', NULL, 1622905772396, 1622905772396, 'admin', b'1', NULL, NULL, NULL), ('Xb18620208', 'admin', '贾泽楷', '男', '13506839371', '845923059@qq.com', '您的大学叫什么？', '科艺', '', NULL, 1622905772396, 1622905772396, 'admin', b'1', NULL, NULL, NULL), ('Xb18620210', 'admin', '李九龙', '男', '15356750383', '1109269674@qq.com', '您的大学叫什么？', '科艺', '', NULL, 1622905772396, 1622905772396, 'admin', b'1', NULL, NULL, NULL), ('Xb18620213', 'admin', '林宇成', '男', '15356750081', '1376381634@qq.com', '您的大学叫什么？', '科艺', '', NULL, 1622905772396, 1622905772396, 'admin', b'1', NULL, NULL, NULL), ('Xb18620214', 'admin', '陆俊弘', '男', '15957369637', '656791514@qq.com', '您的大学叫什么？', '科艺', '', NULL, 1622905772396, 1622905772396, 'admin', b'1', NULL, NULL, NULL), ('Xb18620215', 'admin', '潘智凯', '男', '13858727026', '18081570202@qq.com', '您的大学叫什么？', '科艺', '', NULL, 1622905772396, 1622905772396, 'admin', b'1', NULL, NULL, NULL), ('Xb18620216', 'admin', '钱辰炜', '男', '17826732122', '799552121@qq.com', '您的大学叫什么？', '科艺', '', NULL, 1622905772396, 1622905772396, 'admin', b'1', NULL, NULL, NULL), ('Xb18620217', 'admin', '王超', '男', '18072293537', '2764602366@qq.com', '您的大学叫什么？', '科艺', '', NULL, 1622905772396, 1622905772396, 'admin', b'1', NULL, NULL, NULL), ('Xb18620218', 'admin', '王楚', '男', '15727965775', '1196033581@qq.com', '您的大学叫什么？', '科艺', '', NULL, 1622905772396, 1622905772396, 'admin', b'1', NULL, NULL, NULL), ('Xb18620219', 'admin', '王世宇', '男', '15168079872', '1637005665@qq.com', '您的大学叫什么？', '科艺', '', NULL, 1622905772396, 1622905772396, 'admin', b'1', NULL, NULL, NULL), ('Xb18620220', 'admin', '巫超', '男', '15268758935', '1446307400@qq.com', '您的大学叫什么？', '科艺', '', NULL, 1622905772396, 1622905772396, 'admin', b'1', NULL, NULL, NULL), ('Xb18620221', 'admin', '吴焌辉', '男', '18555878163', '1508710375@qq.com', '您的大学叫什么？', '科艺', '', NULL, 1622905772396, 1622905772396, 'admin', b'1', NULL, NULL, NULL), ('Xb18620222', 'admin', '徐志灵', '男', '15058506567', '2414753551@qq.com', '您的大学叫什么？', '科艺', '', NULL, 1622905772396, 1622905772396, 'admin', b'1', NULL, NULL, NULL), ('Xb18620224', 'admin', '叶海成', '男', '17857556616', '2529545724@qq.com', '您的大学叫什么？', '科艺', '', NULL, 1622905772396, 1622905772396, 'admin', b'1', NULL, NULL, NULL), ('Xb18620225', 'admin', '叶镇武', '男', '17826731321', '1462429940@qq.com', '您的大学叫什么？', '科艺', '', NULL, 1622905772396, 1622905772396, 'admin', b'1', NULL, NULL, NULL), ('Xb18620227', 'admin', '张鸿彬', '男', '13567532661', '2502943906@qq.com', '您的大学叫什么？', '科艺', '', NULL, 1622905772396, 1622905772396, 'admin', b'1', NULL, NULL, NULL), ('Xb18620230', 'admin', '胡馨月', '女', '13565120077', '704319667@qq.com', '您的大学叫什么？', '科艺', '', NULL, 1622905772396, 1622905772396, 'admin', b'1', NULL, NULL, NULL), ('Xb18620231', 'admin', '宓彦阳', '女', '13506782217', '1428119389@qq.com', '您的大学叫什么？', '科艺', '', NULL, 1622905772396, 1622905772396, 'admin', b'1', NULL, NULL, NULL), ('Xb18620232', 'admin', '吴宇欣', '女', '17826733417', '1937501322@qq.com', '您的大学叫什么？', '科艺', '', NULL, 1622905772397, 1622905772397, 'admin', b'1', NULL, NULL, NULL), ('Xc18520308', 'admin', '张朱镇', '男', '15356750679', '814137054@qq.com', '您的大学叫什么？', '科艺', '', NULL, 1622905772397, 1622905772397, 'admin', b'1', NULL, NULL, NULL), ('Xf18220105', 'admin', '董根阳', '男', '15356752183', '2542878652@qq.com', '您的大学叫什么？', '科艺', '', NULL, 1622905772397, 1622905772397, 'admin', b'1', NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_user_address
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_address`;
CREATE TABLE `sys_user_address`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '序号',
  `userName` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  `address` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '地址',
  `utcCreate` bigint(0) NOT NULL COMMENT '创建时间',
  `utcModify` bigint(0) NOT NULL COMMENT '修改时间',
  `modifyBy` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '修改人',
  `valid` bit(1) NOT NULL COMMENT '是否有效',
  `remark` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `customa` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '自定义字段a',
  `customb` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '自定义字段b',
  PRIMARY KEY (`id`, `userName`) USING BTREE,
  INDEX `id`(`id`) USING BTREE,
  INDEX `SUAuserName`(`userName`) USING BTREE,
  CONSTRAINT `SUAuserName` FOREIGN KEY (`userName`) REFERENCES `sys_user` (`userName`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '系统用户地址表';

-- ----------------------------
-- Records of sys_user_address
-- ----------------------------
BEGIN;
INSERT INTO `sys_user_address` (`id`, `userName`, `address`, `utcCreate`, `utcModify`, `modifyBy`, `valid`, `remark`, `customa`, `customb`) VALUES (1, 'admin', 'admin测试地址', 1621873376500, 1621873376500, 'admin', b'1', NULL, NULL, NULL), (2, 'admin', 'admin承租方地址', 1621873384606, 1621873384606, 'admin', b'1', NULL, NULL, NULL), (3, 'admin', 'admin出租房地址', 1621873391202, 1621873391202, 'admin', b'1', NULL, NULL, NULL), (4, 'saler', '出租方地址', 1621874003044, 1621874003044, 'saler', b'1', NULL, NULL, NULL), (5, 'saler', '发货地址1', 1621874008811, 1621874008811, 'saler', b'1', NULL, NULL, NULL), (6, 'saler2', '2号出租方地址', 1621874564556, 1621874564556, 'saler2', b'1', NULL, NULL, NULL), (7, 'saler2', '测试发货地址2', 1621874572479, 1621874572479, 'saler2', b'1', NULL, NULL, NULL), (8, 'buyer', '买家收货地址', 1621874791682, 1621874791682, 'buyer', b'1', NULL, NULL, NULL), (9, 'buyer', '浙江理工大学科技与艺术学院', 1621874804457, 1621874804457, 'buyer', b'1', NULL, NULL, NULL), (10, 'buyer2', '2号买家地址', 1621875488119, 1621875488119, 'buyer2', b'1', NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Procedure structure for resetSQL
-- ----------------------------
DROP PROCEDURE IF EXISTS `resetSQL`;
delimiter ;;
CREATE DEFINER = `root`@`localhost` PROCEDURE `resetSQL`()
  MODIFIES SQL DATA 
  DETERMINISTIC
  SQL SECURITY INVOKER
BEGIN
  /*
 Navicat Premium Data Transfer

 Source Server         : java
 Source Server Type    : MySQL
 Source Server Version : 80019
 Source Host           : localhost:3306
 Source Schema         : javaweb

 Target Server Type    : MySQL
 Target Server Version : 80019
 File Encoding         : 65001

 Date: 05/06/2021 23:22:20
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for rel_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `rel_role_permission`;
CREATE TABLE `rel_role_permission`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `roleId` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色号',
  `perCode` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '权限代码',
  PRIMARY KEY (`id`, `roleId`, `perCode`) USING BTREE,
  INDEX `perCode`(`perCode`) USING BTREE,
  INDEX `RRProleId`(`roleId`) USING BTREE,
  CONSTRAINT `RRPperCode` FOREIGN KEY (`perCode`) REFERENCES `sys_permission` (`perCode`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `RRProleId` FOREIGN KEY (`roleId`) REFERENCES `sys_role` (`roleId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 366 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '角色权限关联表';

-- ----------------------------
-- Records of rel_role_permission
-- ----------------------------

INSERT INTO `rel_role_permission` (`id`, `roleId`, `perCode`) VALUES (266, '1', 'admin:address:select'), (269, '1', 'admin:order:select'), (297, '1', 'admin:permission:delete'), (299, '1', 'admin:permission:findPermissionByRoleId'), (284, '1', 'admin:permission:insert'), (295, '1', 'admin:permission:managePermission'), (276, '1', 'admin:permission:select'), (289, '1', 'admin:permission:selectById'), (285, '1', 'admin:permission:update'), (296, '1', 'admin:role:delete'), (275, '1', 'admin:role:insert'), (293, '1', 'admin:role:update'), (290, '1', 'admin:user:delete'), (277, '1', 'admin:user:select'), (361, '3', 'anon:user:update'), (273, '1', 'buyer:commodity:select'), (337, '2', 'buyer:commodity:select'), (268, '1', 'buyer:commodity:selectByPriceBetween'), (331, '2', 'buyer:commodity:selectByPriceBetween'), (264, '1', 'buyer:commodity:selectByQuantityBetween'), (324, '2', 'buyer:commodity:selectByQuantityBetween'), (288, '1', 'buyer:commodity:selectByQuantityNow'), (334, '2', 'buyer:commodity:selectByQuantityNow'), (287, '1', 'buyer:commodity:selectCommodityUser'), (335, '2', 'buyer:commodity:selectCommodityUser'), (263, '1', 'buyer:commodity:updateRate'), (323, '2', 'buyer:commodity:updateRate'), (274, '1', 'buyer:order:insert'), (341, '2', 'buyer:order:insert'), (278, '1', 'saler:commodity:delete'), (362, '3', 'saler:commodity:delete'), (280, '1', 'saler:commodity:deleteAllZero'), (363, '3', 'saler:commodity:deleteAllZero'), (292, '1', 'saler:commodity:insert'), (358, '3', 'saler:commodity:insert'), (298, '1', 'user:address:delete'), (343, '2', 'user:address:delete'), (360, '3', 'user:address:delete'), (261, '1', 'user:address:deleteByName'), (325, '2', 'user:address:deleteByName'), (346, '3', 'user:address:deleteByName'), (271, '1', 'user:address:insert'), (338, '2', 'user:address:insert'), (355, '3', 'user:address:insert'), (286, '1', 'user:address:selectByName'), (333, '2', 'user:address:selectByName'), (353, '3', 'user:address:selectByName'), (272, '1', 'user:address:update'), (339, '2', 'user:address:update'), (356, '3', 'user:address:update'), (265, '1', 'user:commodity:selectByAnyParam'), (328, '2', 'user:commodity:selectByAnyParam'), (349, '3', 'user:commodity:selectByAnyParam'), (281, '1', 'user:commodity:selectById'), (326, '2', 'user:commodity:selectById'), (347, '3', 'user:commodity:selectById'), (267, '1', 'user:commodity:selectByName'), (332, '2', 'user:commodity:selectByName'), (352, '3', 'user:commodity:selectByName'), (262, '1', 'user:commodity:selectUserCommodity'), (327, '2', 'user:commodity:selectUserCommodity'), (348, '3', 'user:commodity:selectUserCommodity'), (283, '1', 'user:commodity:update'), (330, '2', 'user:commodity:update'), (351, '3', 'user:commodity:update'), (282, '1', 'user:gitee:refreshPage'), (329, '2', 'user:gitee:refreshPage'), (350, '3', 'user:gitee:refreshPage'), (279, '1', 'user:gitee:saveImg'), (344, '2', 'user:gitee:saveImg'), (364, '3', 'user:gitee:saveImg'), (270, '1', 'user:order:selectByAnyParam'), (336, '2', 'user:order:selectByAnyParam'), (354, '3', 'user:order:selectByAnyParam'), (300, '1', 'user:order:selectById'), (345, '2', 'user:order:selectById'), (365, '3', 'user:order:selectById'), (291, '1', 'user:order:update'), (340, '2', 'user:order:update'), (357, '3', 'user:order:update'), (294, '1', 'user:user:logout'), (342, '2', 'user:user:logout'), (359, '3', 'user:user:logout');
COMMIT;

-- ----------------------------
-- Table structure for rel_user_commodity
-- ----------------------------
DROP TABLE IF EXISTS `rel_user_commodity`;
CREATE TABLE `rel_user_commodity`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '序号',
  `comId` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商品号',
  `userName` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `name`(`userName`) USING BTREE,
  INDEX `id`(`comId`) USING BTREE,
  CONSTRAINT `RUCcomId` FOREIGN KEY (`comId`) REFERENCES `sys_commodity` (`comId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `RUCuserName` FOREIGN KEY (`userName`) REFERENCES `sys_user` (`userName`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 51 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户商品关联表';

-- ----------------------------
-- Records of rel_user_commodity
-- ----------------------------

INSERT INTO `rel_user_commodity` (`id`, `comId`, `userName`) VALUES (1, '宠物001', 'saler'), (2, '电器001', 'saler'), (3, '生活001', 'saler2'), (51, '器械001', 'saler'), (52, '饰品001', 'saler'), (53, '服饰001', 'saler'), (54, '厨具001', 'saler2'), (55, '家具001', 'saler2'), (56, '家具002', 'saler2');
COMMIT;

-- ----------------------------
-- Table structure for rel_user_role
-- ----------------------------
DROP TABLE IF EXISTS `rel_user_role`;
CREATE TABLE `rel_user_role`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '序号',
  `userName` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  `roleId` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色号',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `userName`(`userName`) USING BTREE,
  INDEX `roleId`(`roleId`) USING BTREE,
  CONSTRAINT `RURroleId` FOREIGN KEY (`roleId`) REFERENCES `sys_role` (`roleId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `RURuserName` FOREIGN KEY (`userName`) REFERENCES `sys_user` (`userName`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 70 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户角色关联表';

-- ----------------------------
-- Records of rel_user_role
-- ----------------------------

INSERT INTO `rel_user_role` (`id`, `userName`, `roleId`) VALUES (1, 'admin', '1'), (2, 'buyer', '2'), (3, 'test', '1'), (4, 'saler', '3'), (5, 'buyer2', '2'), (6, 'saler2', '3'), (70, 'Xb18620201', '1'), (71, 'Xb18620202', '1'), (72, 'Xb18620203', '1'), (73, 'Xb18620204', '1'), (74, 'Xb18620205', '1'), (75, 'Xb18620207', '1'), (76, 'Xb18620208', '1'), (77, 'Xb18620210', '1'), (78, 'Xb18620213', '1'), (79, 'Xb18620214', '1'), (80, 'Xb18620215', '1'), (81, 'Xb18620216', '1'), (82, 'Xb18620217', '1'), (83, 'Xb18620218', '1'), (84, 'Xb18620219', '1'), (85, 'Xb18620220', '1'), (86, 'Xb18620221', '1'), (87, 'Xb18620222', '1'), (88, 'Xb18620224', '1'), (89, 'Xb18620225', '1'), (90, 'Xb18620227', '1'), (91, 'Xb18620230', '1'), (92, 'Xb18620231', '1'), (93, 'Xb18620232', '1'), (94, 'Xc18520308', '1'), (95, 'Xf18220105', '1'), (96, 'X201801018', '1'), (97, 'Xb17620226', '1');
COMMIT;

-- ----------------------------
-- Table structure for sec_block_chain
-- ----------------------------
DROP TABLE IF EXISTS `sec_block_chain`;
CREATE TABLE `sec_block_chain`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '序号',
  `data` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '数据',
  `hash` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '哈希值',
  `previousHash` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '上一个区块哈希值',
  `timeStamp` bigint(0) NULL DEFAULT NULL COMMENT '时间戳',
  `nonce` int(0) NULL DEFAULT NULL COMMENT '一次性值',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '安全区块链';

-- ----------------------------
-- Records of sec_block_chain
-- ----------------------------

INSERT INTO `sec_block_chain` (`id`, `data`, `hash`, `previousHash`, `timeStamp`, `nonce`) VALUES (1, '1622226482209', '00000415f5704de29a82114d37959bd806f03b6ced333d66910a6f0ca9ae9db3', '0', 1622226482212, 435389), (2, '1622226545082', '00000e659df88697e5307f88d8fc8ebed00beb712e6fb3ddb48765cc2b273486', '00000415f5704de29a82114d37959bd806f03b6ced333d66910a6f0ca9ae9db3', 1622226545083, 1490220), (3, '1622226625401', '00000ebb508fb8d58bce86d5d7285fbf1ffb46b12f729353772bce52a3f89caa', '00000e659df88697e5307f88d8fc8ebed00beb712e6fb3ddb48765cc2b273486', 1622226625403, 55541), (6, '1622906149437', '00000f20ceb4f4cbe86aed45c0a9dabb4df10122d14b3775b340ab1853c131eb', '00000ebb508fb8d58bce86d5d7285fbf1ffb46b12f729353772bce52a3f89caa', 1622906149445, 183647), (7, '1622906165060', '000004b0c7d3d6a10007e81e4436855419b07efe6692c00735d3349b1caa0477', '00000f20ceb4f4cbe86aed45c0a9dabb4df10122d14b3775b340ab1853c131eb', 1622906165060, 318663), (8, '1622906186364', '0000007da73c1a941ddd048af129dcc6c1eabd44da23bf8ab0044c59c541cec7', '000004b0c7d3d6a10007e81e4436855419b07efe6692c00735d3349b1caa0477', 1622906186364, 245946), (9, '1622906239345', '000005d4d75c1a8992f61bf4b215452fda0750361d405a2571d5311f411e2604', '0000007da73c1a941ddd048af129dcc6c1eabd44da23bf8ab0044c59c541cec7', 1622906239346, 263204), (10, '1622906253684', '000004d1d357247c055d085892dc70bad75a2479c929acb8be46c56b11a8b66e', '000005d4d75c1a8992f61bf4b215452fda0750361d405a2571d5311f411e2604', 1622906253685, 469575), (11, '1622906270575', '00000d523184a353d421be93f2a7ae4b0600ce4b8cbfac6b576ae01dd7b9f36f', '000004d1d357247c055d085892dc70bad75a2479c929acb8be46c56b11a8b66e', 1622906270575, 177660);
COMMIT;

-- ----------------------------
-- Table structure for sys_commodity
-- ----------------------------
DROP TABLE IF EXISTS `sys_commodity`;
CREATE TABLE `sys_commodity`  (
  `comId` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商品号',
  `comName` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '名称',
  `comQuantity` int(0) NOT NULL COMMENT '数量',
  `comQuantityNow` int(0) NOT NULL COMMENT '当前数量',
  `comEachPrice` double NOT NULL COMMENT '单价',
  `comDescription` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '描述',
  `comRateCount` int(0) NOT NULL COMMENT '评价次数',
  `comRate` double NOT NULL COMMENT '评价',
  `comPicture` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '图片',
  `utcCreate` bigint(0) NOT NULL COMMENT '创建时间',
  `utcModify` bigint(0) NOT NULL COMMENT '修改时间',
  `modifyBy` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '修改人',
  `valid` bit(1) NOT NULL COMMENT '是否有效',
  `remark` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `customa` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '自定义字段a',
  `customb` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '自定义字段b',
  PRIMARY KEY (`comId`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '系统商品表';

-- ----------------------------
-- Records of sys_commodity
-- ----------------------------

INSERT INTO `sys_commodity` (`comId`, `comName`, `comQuantity`, `comQuantityNow`, `comEachPrice`, `comDescription`, `comRateCount`, `comRate`, `comPicture`, `utcCreate`, `utcModify`, `modifyBy`, `valid`, `remark`, `customa`, `customb`) VALUES ('厨具001', '不锈钢菜刀', 88, 86, 6.8, '一套不锈钢刀具', 1, 1, 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1622906032566.png', 1622906027922, 1622906150425, 'buyer2', b'1', NULL, NULL, NULL), ('器械001', '洒水器', 100, 0, 18, '360°农业自动洒水器', 1, 4, 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1622905871531.png', 1622905868083, 1622906240524, 'buyer', b'1', NULL, NULL, NULL), ('宠物001', '领养博美幼犬', 1, 0, 12, '只需运费！！！', 1, 2, 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1621874272655.jpg', 1621874264014, 1622906166458, 'buyer2', b'1', NULL, NULL, NULL), ('家具001', '大理石圆桌', 6, 6, 68, '轻奢大理石装饰桌', 1, 3, 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1622906068486.jpg', 1622906064592, 1622906069218, 'saler2', b'1', NULL, NULL, NULL), ('家具002', '吊椅', 100, 100, 9.9, '塑料鸟巢吊椅', 1, 4, 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1622906117715.png', 1622906113406, 1622906119980, 'saler2', b'1', NULL, NULL, NULL), ('服饰001', '帆布鞋', 40, 40, 15, '平底匡威帆布鞋', 1, 5, 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1622905966339.png', 1622905960142, 1622905967742, 'saler', b'1', NULL, NULL, NULL), ('生活001', '防紫外线伞', 100, 96, 5, '临时用伞', 2, 4.5, 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1621874745440.jpg', 1621874739991, 1622906271399, 'buyer', b'1', NULL, NULL, NULL), ('电器001', '大容量移动电源', 5, 5, 50, '淘宝同款超大容量移动电源', 1, 3.5, 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1621874463368.jpg', 1621874459351, 1622226485034, 'admin', b'1', NULL, NULL, NULL), ('饰品001', '情侣项链', 2, 1, 6, '两对情侣纯银项链', 1, 2.5, 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1622905916193.png', 1622905912372, 1622906255620, 'buyer', b'1', NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_order
-- ----------------------------
DROP TABLE IF EXISTS `sys_order`;
CREATE TABLE `sys_order`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '序号',
  `orderComId` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '交易商品',
  `orderSalerName` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '卖家账号',
  `orderBuyerName` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '买家账号',
  `orderSalerAddress` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '发货地址',
  `orderBuyerAddress` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '收货地址',
  `orderTransportCode` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '运单号',
  `orderCreateTime` bigint(0) NULL DEFAULT NULL COMMENT '创建时间',
  `orderTransportTime` bigint(0) NULL DEFAULT NULL COMMENT '发货时间',
  `orderReceiveTime` bigint(0) NULL DEFAULT NULL COMMENT '收货时间',
  `orderStatus` int(0) NOT NULL COMMENT '订单状态\n1：已下单\n2：已发货\n3：已收货',
  `orderPayStatus` int(0) NOT NULL COMMENT '付款状态\n1：已付款\n2：未付款',
  `orderTime` bigint(0) NOT NULL COMMENT '截止时间',
  `utcCreate` bigint(0) NOT NULL COMMENT '创建时间',
  `utcModify` bigint(0) NOT NULL COMMENT '修改时间',
  `modifyBy` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '修改人',
  `valid` bit(1) NOT NULL COMMENT '是否有效',
  `remark` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `customa` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '自定义字段a',
  `customb` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '自定义字段b',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '系统订单表';

-- ----------------------------
-- Records of sys_order
-- ----------------------------

INSERT INTO `sys_order` (`id`, `orderComId`, `orderSalerName`, `orderBuyerName`, `orderSalerAddress`, `orderBuyerAddress`, `orderTransportCode`, `orderCreateTime`, `orderTransportTime`, `orderReceiveTime`, `orderStatus`, `orderPayStatus`, `orderTime`, `utcCreate`, `utcModify`, `modifyBy`, `valid`, `remark`, `customa`, `customb`) VALUES (8, '厨具001', 'saler2', 'buyer2', '2号出租方地址', '2号买家地址', '1978657234', 1622906149437, 1622906329036, NULL, 2, 2, 604800000, 1622906150412, 1622906150412, 'buyer2', b'1', NULL, NULL, NULL), (9, '宠物001', 'saler', 'buyer2', '出租方地址', '2号买家地址', '1857462758', 1622906165060, 1622906295423, NULL, 2, 2, 31536000000, 1622906166450, 1622906166450, 'buyer2', b'1', NULL, NULL, NULL), (10, '器械001', 'saler', 'buyer2', NULL, '2号买家地址', NULL, 1622906186364, NULL, NULL, 1, 2, 2592000000, 1622906187458, 1622906187458, 'buyer2', b'1', NULL, NULL, NULL), (11, '器械001', 'saler', 'buyer', '发货地址1', '买家收货地址', '1968473857', 1622906239345, 1622906309823, 1622906360037, 3, 2, 1623511160037, 1622906240504, 1622906240504, 'buyer', b'1', NULL, NULL, NULL), (12, '饰品001', 'saler', 'buyer', NULL, '浙江理工大学科技与艺术学院', NULL, 1622906253684, NULL, NULL, 1, 2, 604800000, 1622906255598, 1622906255598, 'buyer', b'1', NULL, NULL, NULL), (13, '生活001', 'saler2', 'buyer', '测试发货地址2', '浙江理工大学科技与艺术学院', '1258675623', 1622906270575, 1622906337351, NULL, 2, 2, 2592000000, 1622906271376, 1622906271376, 'buyer', b'1', NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_permission`;
CREATE TABLE `sys_permission`  (
  `perId` int(0) NOT NULL AUTO_INCREMENT COMMENT '序号',
  `perName` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '权限名',
  `perCode` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '代码',
  `perUrl` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '请求路径',
  `utcCreate` bigint(0) NOT NULL COMMENT '创建时间',
  `utcModify` bigint(0) NOT NULL COMMENT '修改时间',
  `modifyBy` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '修改人',
  `valid` bit(1) NOT NULL COMMENT '是否有效',
  `remark` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `customa` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '自定义字段a',
  `customb` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '自定义字段b',
  PRIMARY KEY (`perId`, `perCode`) USING BTREE,
  INDEX `perCode`(`perCode`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 50 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '系统权限表';

-- ----------------------------
-- Records of sys_permission
-- ----------------------------

INSERT INTO `sys_permission` (`perId`, `perName`, `perCode`, `perUrl`, `utcCreate`, `utcModify`, `modifyBy`, `valid`, `remark`, `customa`, `customb`) VALUES (1, '添加用户', 'anon:user:insert', 'user/insert', 1622385207468, 1622385441400, 'admin', b'1', NULL, '0', NULL), (2, '删除用户', 'admin:user:delete', 'user/delete', 1622385595617, 1622385595617, 'admin', b'1', NULL, '2', NULL), (3, '更新用户信息', 'anon:user:update', 'user/update', 1622385633154, 1622385633154, 'admin', b'1', NULL, '0', NULL), (4, '查询全体用户', 'admin:user:select', 'user/select', 1622385708360, 1622385708360, 'admin', b'1', NULL, '2', NULL), (5, '根据用户名查询用户', 'anon:user:selectByName', 'user/selectByName', 1622385766718, 1622385766718, 'admin', b'1', NULL, '0', NULL), (6, '用户登陆', 'anon:user:login', 'user/login', 1622385802158, 1622385802158, 'admin', b'1', NULL, '0', NULL), (7, '用户退出', 'user:user:logout', 'user/logout', 1622385852039, 1622385852039, 'admin', b'1', NULL, '1', NULL), (8, '强制登录', 'inner:user:toLogin', 'user/toLogin', 1622385915891, 1622385915891, 'admin', b'1', NULL, '3', NULL), (9, '添加角色', 'admin:role:insert', 'role/insert', 1622385966197, 1622385966197, 'admin', b'1', NULL, '2', NULL), (10, '删除角色', 'admin:role:delete', 'role/delete', 1622385990035, 1622385990035, 'admin', b'1', NULL, '2', NULL), (11, '更新角色', 'admin:role:update', 'role/update', 1622386016974, 1622386016974, 'admin', b'1', NULL, '2', NULL), (12, '查询全体角色', 'anon:role:select', 'role/select', 1622386179215, 1622386179215, 'admin', b'1', NULL, '0', NULL), (13, '根据用户名查询角色', 'anon:role:selectUserRole', 'role/selectUserRole', 1622386303575, 1622386303575, 'admin', b'1', NULL, '0', NULL), (14, '根据角色号查询角色', 'anon:role:selectById', 'role/selectById', 1622386326940, 1622462924531, 'admin', b'1', NULL, '0', NULL), (15, '添加地址', 'user:address:insert', 'address/insert', 1622386396514, 1622386396514, 'admin', b'1', NULL, '1', NULL), (16, '删除地址', 'user:address:delete', 'address/delete', 1622386424450, 1622386424450, 'admin', b'1', NULL, '1', NULL), (17, '按用户名删除地址', 'user:address:deleteByName', 'address/deleteByName', 1622386457995, 1622386457995, 'admin', b'1', NULL, '1', NULL), (18, '更新地址', 'user:address:update', 'address/update', 1622386484174, 1622386484174, 'admin', b'1', NULL, '1', NULL), (19, '查询全部地址', 'admin:address:select', 'address/select', 1622386506544, 1622388921654, 'admin', b'1', NULL, '2', NULL), (20, '根据用户名查询地址', 'user:address:selectByName', 'address/selectByName', 1622386533492, 1622388926341, 'admin', b'1', NULL, '1', NULL), (21, '添加商品', 'saler:commodity:insert', 'commodity/insert', 1622388002204, 1622388002204, 'admin', b'1', NULL, '1', NULL), (22, '删除商品', 'saler:commodity:delete', 'commodity/delete', 1622388323569, 1622388323569, 'admin', b'1', NULL, '1', NULL), (23, '删除用户无存货商品', 'saler:commodity:deleteAllZero', 'commodity/deleteAllZero', 1622388346996, 1622388346996, 'admin', b'1', NULL, '1', NULL), (24, '更新商品信息', 'user:commodity:update', 'commodity/update', 1622388373349, 1622462882618, 'admin', b'1', NULL, '1', NULL), (25, '更新商品评价', 'buyer:commodity:updateRate', 'commodity/updateRate', 1622388412021, 1622388412021, 'admin', b'1', NULL, '1', NULL), (26, '查询全体商品', 'buyer:commodity:select', 'commodity/select', 1622388455498, 1622388455498, 'admin', b'1', NULL, '1', NULL), (27, '根据商品号查询商品', 'user:commodity:selectById', 'commodity/selectById', 1622388490387, 1622388490387, 'admin', b'1', NULL, '1', NULL), (28, '根据商品名称查询商品', 'user:commodity:selectByName', 'commodity/selectByName', 1622388517712, 1622388517712, 'admin', b'1', NULL, '1', NULL), (29, '根据商品价格包含区间查询商品', 'buyer:commodity:selectByPriceBetween', 'commodity/selectByPriceBetween', 1622388590735, 1622388590735, 'admin', b'1', NULL, '1', NULL), (30, '根据商品存货查询商品', 'buyer:commodity:selectByQuantityNow', 'commodity/selectByQuantityNow', 1622388612491, 1622388612491, 'admin', b'1', NULL, '1', NULL), (31, '根据商品存货区间查询商品', 'buyer:commodity:selectByQuantityBetween', 'commodity/selectByQuantityBetween', 1622388637591, 1622388637591, 'admin', b'1', NULL, '1', NULL), (32, '根据用户名查询商品', 'user:commodity:selectUserCommodity', 'commodity/selectUserCommodity', 1622388669086, 1622388669086, 'admin', b'1', NULL, '1', NULL), (33, '根据商品号查询用户', 'buyer:commodity:selectCommodityUser', 'commodity/selectCommodityUser', 1622388710379, 1622388710379, 'admin', b'1', NULL, '1', NULL), (34, '根据指定字段查询商品', 'user:commodity:selectByAnyParam', 'commodity/selectByAnyParam', 1622388735338, 1622388908842, 'admin', b'1', NULL, '1', NULL), (35, '添加订单', 'buyer:order:insert', 'order/insert', 1622388762483, 1622388762483, 'admin', b'1', NULL, '1', NULL), (36, '删除订单', 'inner:order:delete', 'order/delete', 1622388790449, 1622388790449, 'admin', b'1', NULL, '3', NULL), (37, '更新订单', 'user:order:update', 'order/update', 1622388833428, 1622388833428, 'admin', b'1', NULL, '1', NULL), (38, '查询全体订单', 'admin:order:select', 'order/select', 1622388853496, 1622388853496, 'admin', b'1', NULL, '2', NULL), (39, '根据ID号查询订单', 'user:order:selectById', 'order/selectById', 1622388899751, 1622465413076, 'admin', b'1', NULL, '2', NULL), (40, '根据指定字段查询订单', 'user:order:selectByAnyParam', 'order/selectByAnyParam', 1622388963543, 1622388963543, 'admin', b'1', NULL, '1', NULL), (41, '上传文件', 'user:gitee:saveImg', 'gitee/saveImg', 1622389006703, 1622389006703, 'admin', b'1', NULL, '1', NULL), (42, '刷新Gitee Page', 'user:gitee:refreshPage', 'gitee/refreshPage', 1622389031352, 1622389031352, 'admin', b'1', NULL, '1', NULL), (43, '添加权限', 'admin:permission:insert', 'permission/insert', 1622389069564, 1622389069564, 'admin', b'1', NULL, '2', NULL), (44, '删除权限', 'admin:permission:delete', 'permission/delete', 1622389091018, 1622389091018, 'admin', b'1', NULL, '2', NULL), (45, '更新权限', 'admin:permission:update', 'permission/update', 1622389109556, 1622389109556, 'admin', b'1', NULL, '2', NULL), (46, '查询全体权限', 'admin:permission:select', 'permission/select', 1622389179678, 1622389179678, 'admin', b'1', NULL, '2', NULL), (47, '根据ID查询权限', 'admin:permission:selectById', 'permission/selectById', 1622389222987, 1622389222987, 'admin', b'1', NULL, '2', NULL), (48, '根据角色号查询权限', 'admin:permission:findPermissionByRoleId', 'permission/findPermissionByRoleId', 1622432653963, 1622432653963, 'admin', b'1', NULL, '2', NULL), (49, '创建角色权限链接', 'admin:permission:managePermission', 'permission/managePermission', 1622432679207, 1622432679207, 'admin', b'1', NULL, '2', NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `roleId` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色号',
  `roleNameCn` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '中文名',
  `roleNameEn` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '英文名',
  `roleDescription` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '描述',
  `utcCreate` bigint(0) NOT NULL COMMENT '创建时间',
  `utcModify` bigint(0) NOT NULL COMMENT '修改时间',
  `modifyBy` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '修改人',
  `valid` bit(1) NOT NULL COMMENT '是否有效',
  `remark` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `customa` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '权限等级\n0：公共权限\n1：用户权限\n2：管理权限\n3：内部权限',
  `customb` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '自定义字段b',
  PRIMARY KEY (`roleId`, `roleNameEn`) USING BTREE,
  INDEX `roleId`(`roleId`) USING BTREE,
  INDEX `roleNameEn`(`roleNameEn`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '系统角色表';

-- ----------------------------
-- Records of sys_role
-- ----------------------------

INSERT INTO `sys_role` (`roleId`, `roleNameCn`, `roleNameEn`, `roleDescription`, `utcCreate`, `utcModify`, `modifyBy`, `valid`, `remark`, `customa`, `customb`) VALUES ('1', '管理员', 'admin', '管理员角色，拥有最高权限', 1621074167413, 1621074167413, 'Xb18620208', b'1', NULL, NULL, NULL), ('2', '承租方', 'buyer', '承租商品角色', 1621074167413, 1621074167413, 'Xb18620208', b'1', NULL, NULL, NULL), ('3', '出租方', 'saler', '出租商品角色', 1621074167413, 1621074167413, 'Xb18620208', b'1', NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `userName` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  `userPassword` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
  `userNick` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '姓名',
  `userGender` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '性别',
  `userPhone` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '电话',
  `userEmail` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  `userQuest` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密保问题',
  `userAnswer` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密保答案',
  `userAvatar` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像',
  `userLastLogin` bigint(0) NULL DEFAULT NULL COMMENT '最近登录时间',
  `utcCreate` bigint(0) NOT NULL COMMENT '创建时间',
  `utcModify` bigint(0) NOT NULL COMMENT '修改时间',
  `modifyBy` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '修改人',
  `valid` bit(1) NOT NULL COMMENT '是否有效',
  `remark` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `customa` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '自定义字段a',
  `customb` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '自定义字段b',
  PRIMARY KEY (`userName`) USING BTREE,
  INDEX `userName`(`userName`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '系统用户表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------

INSERT INTO `sys_user` (`userName`, `userPassword`, `userNick`, `userGender`, `userPhone`, `userEmail`, `userQuest`, `userAnswer`, `userAvatar`, `userLastLogin`, `utcCreate`, `utcModify`, `modifyBy`, `valid`, `remark`, `customa`, `customb`) VALUES ('admin', 'admin', 'admin', '男', '13506839371', '845923059@qq.com', '您的大学叫什么？', '科艺', 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1621873483819.jpg', 1622905755460, 1621700765210, 1622427713723, 'admin', b'1', NULL, NULL, NULL), ('buyer', 'admin', '承租方', '女', '13565120077', 'hxy1999@gmail.com', '您最好的朋友叫什么？', '贾泽楷', NULL, 1622906349853, 1621873543898, 1621873543898, 'admin', b'1', NULL, NULL, NULL), ('buyer2', 'admin', '承租方2', '女', '13459834838', '2@qq.com', '您的大学叫什么？', '科艺', NULL, 1622906129536, 1621873937734, 1621875584846, 'admin', b'1', NULL, NULL, NULL), ('saler', 'admin', '出租方', '男', '13506839372', '888888888@qq.com', '您的大学叫什么？', '科艺', 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1621873980422.png', 1622906281157, 1621873454905, 1621873982071, 'saler', b'1', NULL, NULL, NULL), ('saler2', 'admin', '出租方2', '男', '13311111111', '121212@11.com', '您的大学叫什么？', '科艺', 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1621874549792.jpeg', 1622906318310, 1621873918374, 1621875604877, 'admin', b'1', NULL, NULL, NULL), ('test', 'admin', '测试用户', '男', '13509090909', 'oxoxoxoxoxo@163.com', '您的电子邮箱是？', 'oxoxoxoxoxo@163.com', NULL, NULL, 1621873643774, 1621873643774, 'admin', b'1', NULL, NULL, NULL), ('X201801018', 'admin', '谢雨宏', '男', '15257878631', '1531258826@qq.com', '您的大学叫什么？', '科艺', '', NULL, 1622905772397, 1622905772397, 'admin', b'1', NULL, NULL, NULL), ('Xb17620226', 'admin', '赵海涛', '男', '13566478616', '1174696826@qq.com', '您的大学叫什么？', '科艺', '', NULL, 1622905772397, 1622905772397, 'admin', b'1', NULL, NULL, NULL), ('Xb18620201', 'admin', '曾龙', '男', '17826732865', '1071821598@qq.com', '您的大学叫什么？', '科艺', '', NULL, 1622905772396, 1622905772396, 'admin', b'1', NULL, NULL, NULL), ('Xb18620202', 'admin', '陈伟健', '男', '17826731969', '1194108898@qq.com', '您的大学叫什么？', '科艺', '', NULL, 1622905772396, 1622905772396, 'admin', b'1', NULL, NULL, NULL), ('Xb18620203', 'admin', '陈伟健', '男', '17826731971', '10698134312@qq.com', '您的大学叫什么？', '科艺', '', NULL, 1622905772396, 1622905772396, 'admin', b'1', NULL, NULL, NULL), ('Xb18620204', 'admin', '冯长江', '男', '15356750051', '1479697542@qq.com', '您的大学叫什么？', '科艺', '', NULL, 1622905772396, 1622905772396, 'admin', b'1', NULL, NULL, NULL), ('Xb18620205', 'admin', '郭文彬', '男', '15356751363', '2841313980@qq.com', '您的大学叫什么？', '科艺', '', NULL, 1622905772396, 1622905772396, 'admin', b'1', NULL, NULL, NULL), ('Xb18620207', 'admin', '黄声普', '男', '13506879544', '1012745950@qq.com', '您的大学叫什么？', '科艺', '', NULL, 1622905772396, 1622905772396, 'admin', b'1', NULL, NULL, NULL), ('Xb18620208', 'admin', '贾泽楷', '男', '13506839371', '845923059@qq.com', '您的大学叫什么？', '科艺', '', NULL, 1622905772396, 1622905772396, 'admin', b'1', NULL, NULL, NULL), ('Xb18620210', 'admin', '李九龙', '男', '15356750383', '1109269674@qq.com', '您的大学叫什么？', '科艺', '', NULL, 1622905772396, 1622905772396, 'admin', b'1', NULL, NULL, NULL), ('Xb18620213', 'admin', '林宇成', '男', '15356750081', '1376381634@qq.com', '您的大学叫什么？', '科艺', '', NULL, 1622905772396, 1622905772396, 'admin', b'1', NULL, NULL, NULL), ('Xb18620214', 'admin', '陆俊弘', '男', '15957369637', '656791514@qq.com', '您的大学叫什么？', '科艺', '', NULL, 1622905772396, 1622905772396, 'admin', b'1', NULL, NULL, NULL), ('Xb18620215', 'admin', '潘智凯', '男', '13858727026', '18081570202@qq.com', '您的大学叫什么？', '科艺', '', NULL, 1622905772396, 1622905772396, 'admin', b'1', NULL, NULL, NULL), ('Xb18620216', 'admin', '钱辰炜', '男', '17826732122', '799552121@qq.com', '您的大学叫什么？', '科艺', '', NULL, 1622905772396, 1622905772396, 'admin', b'1', NULL, NULL, NULL), ('Xb18620217', 'admin', '王超', '男', '18072293537', '2764602366@qq.com', '您的大学叫什么？', '科艺', '', NULL, 1622905772396, 1622905772396, 'admin', b'1', NULL, NULL, NULL), ('Xb18620218', 'admin', '王楚', '男', '15727965775', '1196033581@qq.com', '您的大学叫什么？', '科艺', '', NULL, 1622905772396, 1622905772396, 'admin', b'1', NULL, NULL, NULL), ('Xb18620219', 'admin', '王世宇', '男', '15168079872', '1637005665@qq.com', '您的大学叫什么？', '科艺', '', NULL, 1622905772396, 1622905772396, 'admin', b'1', NULL, NULL, NULL), ('Xb18620220', 'admin', '巫超', '男', '15268758935', '1446307400@qq.com', '您的大学叫什么？', '科艺', '', NULL, 1622905772396, 1622905772396, 'admin', b'1', NULL, NULL, NULL), ('Xb18620221', 'admin', '吴焌辉', '男', '18555878163', '1508710375@qq.com', '您的大学叫什么？', '科艺', '', NULL, 1622905772396, 1622905772396, 'admin', b'1', NULL, NULL, NULL), ('Xb18620222', 'admin', '徐志灵', '男', '15058506567', '2414753551@qq.com', '您的大学叫什么？', '科艺', '', NULL, 1622905772396, 1622905772396, 'admin', b'1', NULL, NULL, NULL), ('Xb18620224', 'admin', '叶海成', '男', '17857556616', '2529545724@qq.com', '您的大学叫什么？', '科艺', '', NULL, 1622905772396, 1622905772396, 'admin', b'1', NULL, NULL, NULL), ('Xb18620225', 'admin', '叶镇武', '男', '17826731321', '1462429940@qq.com', '您的大学叫什么？', '科艺', '', NULL, 1622905772396, 1622905772396, 'admin', b'1', NULL, NULL, NULL), ('Xb18620227', 'admin', '张鸿彬', '男', '13567532661', '2502943906@qq.com', '您的大学叫什么？', '科艺', '', NULL, 1622905772396, 1622905772396, 'admin', b'1', NULL, NULL, NULL), ('Xb18620230', 'admin', '胡馨月', '女', '13565120077', '704319667@qq.com', '您的大学叫什么？', '科艺', '', NULL, 1622905772396, 1622905772396, 'admin', b'1', NULL, NULL, NULL), ('Xb18620231', 'admin', '宓彦阳', '女', '13506782217', '1428119389@qq.com', '您的大学叫什么？', '科艺', '', NULL, 1622905772396, 1622905772396, 'admin', b'1', NULL, NULL, NULL), ('Xb18620232', 'admin', '吴宇欣', '女', '17826733417', '1937501322@qq.com', '您的大学叫什么？', '科艺', '', NULL, 1622905772397, 1622905772397, 'admin', b'1', NULL, NULL, NULL), ('Xc18520308', 'admin', '张朱镇', '男', '15356750679', '814137054@qq.com', '您的大学叫什么？', '科艺', '', NULL, 1622905772397, 1622905772397, 'admin', b'1', NULL, NULL, NULL), ('Xf18220105', 'admin', '董根阳', '男', '15356752183', '2542878652@qq.com', '您的大学叫什么？', '科艺', '', NULL, 1622905772397, 1622905772397, 'admin', b'1', NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_user_address
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_address`;
CREATE TABLE `sys_user_address`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '序号',
  `userName` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  `address` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '地址',
  `utcCreate` bigint(0) NOT NULL COMMENT '创建时间',
  `utcModify` bigint(0) NOT NULL COMMENT '修改时间',
  `modifyBy` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '修改人',
  `valid` bit(1) NOT NULL COMMENT '是否有效',
  `remark` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `customa` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '自定义字段a',
  `customb` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '自定义字段b',
  PRIMARY KEY (`id`, `userName`) USING BTREE,
  INDEX `id`(`id`) USING BTREE,
  INDEX `SUAuserName`(`userName`) USING BTREE,
  CONSTRAINT `SUAuserName` FOREIGN KEY (`userName`) REFERENCES `sys_user` (`userName`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '系统用户地址表';

-- ----------------------------
-- Records of sys_user_address
-- ----------------------------

INSERT INTO `sys_user_address` (`id`, `userName`, `address`, `utcCreate`, `utcModify`, `modifyBy`, `valid`, `remark`, `customa`, `customb`) VALUES (1, 'admin', 'admin测试地址', 1621873376500, 1621873376500, 'admin', b'1', NULL, NULL, NULL), (2, 'admin', 'admin承租方地址', 1621873384606, 1621873384606, 'admin', b'1', NULL, NULL, NULL), (3, 'admin', 'admin出租房地址', 1621873391202, 1621873391202, 'admin', b'1', NULL, NULL, NULL), (4, 'saler', '出租方地址', 1621874003044, 1621874003044, 'saler', b'1', NULL, NULL, NULL), (5, 'saler', '发货地址1', 1621874008811, 1621874008811, 'saler', b'1', NULL, NULL, NULL), (6, 'saler2', '2号出租方地址', 1621874564556, 1621874564556, 'saler2', b'1', NULL, NULL, NULL), (7, 'saler2', '测试发货地址2', 1621874572479, 1621874572479, 'saler2', b'1', NULL, NULL, NULL), (8, 'buyer', '买家收货地址', 1621874791682, 1621874791682, 'buyer', b'1', NULL, NULL, NULL), (9, 'buyer', '浙江理工大学科技与艺术学院', 1621874804457, 1621874804457, 'buyer', b'1', NULL, NULL, NULL), (10, 'buyer2', '2号买家地址', 1621875488119, 1621875488119, 'buyer2', b'1', NULL, NULL, NULL);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;

END
;;
delimiter ;

-- ----------------------------
-- Event structure for resetSQL
-- ----------------------------
DROP EVENT IF EXISTS `resetSQL`;
delimiter ;;
CREATE DEFINER = `root`@`localhost` EVENT `resetSQL`
ON SCHEDULE
EVERY '1' DAY STARTS '2021-06-06 06:00:00'
DO CALL resetSQL()
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
