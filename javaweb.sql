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

 Date: 19/05/2021 00:59:30
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for rel_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `rel_role_permission`;
CREATE TABLE `rel_role_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `roleNameEn` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '角色英文名',
  `perCode` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '权限代码',
  PRIMARY KEY (`id`,`roleNameEn`,`perCode`) USING BTREE,
  KEY `perCode` (`perCode`),
  KEY `roleNameEn` (`roleNameEn`),
  CONSTRAINT `perCode` FOREIGN KEY (`perCode`) REFERENCES `sys_permission` (`perCode`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `roleNameEn` FOREIGN KEY (`roleNameEn`) REFERENCES `sys_role` (`roleNameEn`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='角色权限关联表';

-- ----------------------------
-- Table structure for rel_user_commodity
-- ----------------------------
DROP TABLE IF EXISTS `rel_user_commodity`;
CREATE TABLE `rel_user_commodity` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '序号',
  `comId` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '商品号',
  `userName` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '用户名',
  PRIMARY KEY (`id`),
  KEY `name` (`userName`),
  KEY `id` (`comId`),
  CONSTRAINT `id` FOREIGN KEY (`comId`) REFERENCES `sys_commodity` (`comId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `name` FOREIGN KEY (`userName`) REFERENCES `sys_user` (`userName`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='用户商品关联表';

-- ----------------------------
-- Records of rel_user_commodity
-- ----------------------------
BEGIN;
INSERT INTO `rel_user_commodity` VALUES (2, 'SH002', 'Xb18620208');
INSERT INTO `rel_user_commodity` VALUES (3, 'SH003', 'Xb18620208');
INSERT INTO `rel_user_commodity` VALUES (15, 'SH004', 'Xb18620208');
INSERT INTO `rel_user_commodity` VALUES (32, 'SH001', 'Xb18620208');
INSERT INTO `rel_user_commodity` VALUES (42, '12', 'Xb18620208');
COMMIT;

-- ----------------------------
-- Table structure for rel_user_role
-- ----------------------------
DROP TABLE IF EXISTS `rel_user_role`;
CREATE TABLE `rel_user_role` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '序号',
  `userName` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '用户名',
  `roleId` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '角色号',
  PRIMARY KEY (`id`),
  KEY `userName` (`userName`),
  KEY `roleId` (`roleId`),
  CONSTRAINT `roleId` FOREIGN KEY (`roleId`) REFERENCES `sys_role` (`roleId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `userName` FOREIGN KEY (`userName`) REFERENCES `sys_user` (`userName`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='用户角色关联表';

-- ----------------------------
-- Records of rel_user_role
-- ----------------------------
BEGIN;
INSERT INTO `rel_user_role` VALUES (38, 'Xb18620230', '2');
INSERT INTO `rel_user_role` VALUES (41, 'LiuHX', '1');
INSERT INTO `rel_user_role` VALUES (52, 'Xb18620208', '1');
COMMIT;

-- ----------------------------
-- Table structure for sys_commodity
-- ----------------------------
DROP TABLE IF EXISTS `sys_commodity`;
CREATE TABLE `sys_commodity` (
  `comId` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '商品号',
  `comName` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '名称',
  `comQuantity` int NOT NULL COMMENT '数量',
  `comQuantityNow` int NOT NULL COMMENT '当前数量',
  `comEachPrice` double NOT NULL COMMENT '单价',
  `comDescription` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '描述',
  `comRateCount` int NOT NULL COMMENT '评价次数',
  `comRate` double NOT NULL COMMENT '评价',
  `comPicture` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '图片',
  `utcCreate` bigint NOT NULL COMMENT '创建时间',
  `utcModify` bigint NOT NULL COMMENT '修改时间',
  `modifyBy` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '修改人',
  `valid` bit(1) NOT NULL COMMENT '是否有效',
  `remark` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  `customa` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '自定义字段a',
  `customb` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '自定义字段b',
  PRIMARY KEY (`comId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='系统商品表';

-- ----------------------------
-- Records of sys_commodity
-- ----------------------------
BEGIN;
INSERT INTO `sys_commodity` VALUES ('12', '12', 1, 1, 1, '12', 0, 0, '', 1621354212502, 1621354212530, 'Xb18620208', b'0', NULL, NULL, NULL);
INSERT INTO `sys_commodity` VALUES ('SH001', '扫把', 1, 1, 10, '一把破旧的扫把', 1, 1, 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1620647426805.png', 1621074167413, 1621074167413, 'Xb18620208', b'1', NULL, NULL, NULL);
INSERT INTO `sys_commodity` VALUES ('SH002', '拖把', 2, 2, 20, '一把破旧的拖把', 1, 3, 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1620647602176.png', 1621074167413, 1621074167413, 'Xb18620208', b'1', NULL, NULL, NULL);
INSERT INTO `sys_commodity` VALUES ('SH003', '帽子', 3, 3, 30, '一顶破旧的帽子', 1, 4, 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1620654043454.png', 1621074167413, 1621074167413, 'Xb18620208', b'1', NULL, NULL, NULL);
INSERT INTO `sys_commodity` VALUES ('SH004', '靴子', 4, 3, 40, '一双破旧的靴子', 4, 3.75, 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1620654880844.png', 1621074167413, 1621354212607, 'Xb18620208', b'1', NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_order
-- ----------------------------
DROP TABLE IF EXISTS `sys_order`;
CREATE TABLE `sys_order` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '序号',
  `orderComId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '交易商品',
  `orderNewId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '新商品号',
  `orderSalerName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '卖家账号',
  `orderBuyerName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '买家账号',
  `orderCreateTime` bigint DEFAULT NULL COMMENT '创建时间',
  `orderTransportTime` bigint DEFAULT NULL COMMENT '发货时间',
  `orderReceiveTime` bigint DEFAULT NULL COMMENT '收货时间',
  `orderStatus` int NOT NULL COMMENT '订单状态\n1：已下单\n2：已发货\n3：已收货',
  `utcCreate` bigint NOT NULL COMMENT '创建时间',
  `utcModify` bigint NOT NULL COMMENT '修改时间',
  `modifyBy` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '修改人',
  `valid` bit(1) NOT NULL COMMENT '是否有效',
  `remark` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  `customa` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '自定义字段a',
  `customb` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '自定义字段b',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='系统订单表';

-- ----------------------------
-- Records of sys_order
-- ----------------------------
BEGIN;
INSERT INTO `sys_order` VALUES (12, 'SH004', '12', 'Xb18620208', 'Xb18620208', 1621354212588, NULL, NULL, 1, 1621354212588, 1621354212588, 'Xb18620208', b'1', NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_permission`;
CREATE TABLE `sys_permission` (
  `perId` int NOT NULL AUTO_INCREMENT COMMENT '序号',
  `perName` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '权限名',
  `perCode` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '代码',
  `perUrl` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '请求路径',
  `utcCreate` bigint NOT NULL COMMENT '创建时间',
  `utcModify` bigint NOT NULL COMMENT '修改时间',
  `modifyBy` bigint NOT NULL COMMENT '修改人',
  `valid` bit(1) NOT NULL COMMENT '是否有效',
  `remark` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  `customa` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '自定义字段a',
  `customb` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '自定义字段b',
  PRIMARY KEY (`perId`,`perCode`) USING BTREE,
  KEY `perCode` (`perCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='系统权限表';

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `roleId` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '角色号',
  `roleNameCn` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '中文名',
  `roleNameEn` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '英文名',
  `roleDescription` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '描述',
  `utcCreate` bigint NOT NULL COMMENT '创建时间',
  `utcModify` bigint NOT NULL COMMENT '修改时间',
  `modifyBy` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '修改人',
  `valid` bit(1) NOT NULL COMMENT '是否有效',
  `remark` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  `customa` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '自定义字段a',
  `customb` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '自定义字段b',
  PRIMARY KEY (`roleId`,`roleNameEn`) USING BTREE,
  KEY `roleId` (`roleId`),
  KEY `roleNameEn` (`roleNameEn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='系统角色表';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
BEGIN;
INSERT INTO `sys_role` VALUES ('1', '管理员', 'admin', '系统管理员，拥有最高权限', 1621074167413, 1621074167413, 'Xb18620208', b'1', NULL, NULL, NULL);
INSERT INTO `sys_role` VALUES ('2', '买方', 'buyer', '购买二手商品方', 1621074167413, 1621074167413, 'Xb18620208', b'1', NULL, NULL, NULL);
INSERT INTO `sys_role` VALUES ('3', '卖方', 'saler', '出售二手商品方', 1621074167413, 1621074167413, 'Xb18620208', b'1', NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `userName` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '用户名',
  `userPassword` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '密码',
  `userNick` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '姓名',
  `userGender` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '性别',
  `userPhone` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '电话',
  `userEmail` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '邮箱',
  `userQuest` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '密保问题',
  `userAnswer` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '密保答案',
  `userAvatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '头像',
  `userLastLogin` bigint DEFAULT NULL COMMENT '最近登录时间',
  `utcCreate` bigint NOT NULL COMMENT '创建时间',
  `utcModify` bigint NOT NULL COMMENT '修改时间',
  `modifyBy` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '修改人',
  `valid` bit(1) NOT NULL COMMENT '是否有效',
  `remark` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  `customa` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '自定义字段a',
  `customb` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '自定义字段b',
  PRIMARY KEY (`userName`) USING BTREE,
  KEY `userName` (`userName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='系统用户表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
BEGIN;
INSERT INTO `sys_user` VALUES ('LiuHX', '123456', '刘海霞', '女', NULL, NULL, '您的大学叫什么？', '科艺', NULL, NULL, 1621074167413, 1621074167413, 'Xb18620208', b'1', NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('Xb18620208', '123456', '贾泽楷', '男', '13506839371', 'jiazekai1003@gmail.com', '您的大学叫什么？', '科艺', 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1620647285178.jpg', 1621343116755, 1621074167413, 1621355622574, 'Xb18620208', b'1', NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('Xb18620230', '123456', '胡馨月', '女', NULL, NULL, '您的大学叫什么？', '科艺', 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1620653759436.jpeg', NULL, 1621074167413, 1621074167413, 'Xb18620208', b'1', NULL, NULL, NULL);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
