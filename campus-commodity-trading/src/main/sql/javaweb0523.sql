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

 Date: 23/05/2021 21:53:05
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for rel_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `rel_role_permission`;
CREATE TABLE `rel_role_permission` (
                                       `id` int NOT NULL AUTO_INCREMENT,
                                       `roleNameEn` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色英文名',
                                       `perCode` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '权限代码',
                                       PRIMARY KEY (`id`,`roleNameEn`,`perCode`) USING BTREE,
                                       KEY `perCode` (`perCode`),
                                       KEY `roleNameEn` (`roleNameEn`),
                                       CONSTRAINT `RRPperCode` FOREIGN KEY (`perCode`) REFERENCES `sys_permission` (`perCode`) ON DELETE CASCADE ON UPDATE CASCADE,
                                       CONSTRAINT `RRProleNameEn` FOREIGN KEY (`roleNameEn`) REFERENCES `sys_role` (`roleNameEn`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色权限关联表';

-- ----------------------------
-- Table structure for rel_user_commodity
-- ----------------------------
DROP TABLE IF EXISTS `rel_user_commodity`;
CREATE TABLE `rel_user_commodity` (
                                      `id` int NOT NULL AUTO_INCREMENT COMMENT '序号',
                                      `comId` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商品号',
                                      `userName` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
                                      PRIMARY KEY (`id`),
                                      KEY `name` (`userName`),
                                      KEY `id` (`comId`),
                                      CONSTRAINT `RUCcomId` FOREIGN KEY (`comId`) REFERENCES `sys_commodity` (`comId`) ON DELETE CASCADE ON UPDATE CASCADE,
                                      CONSTRAINT `RUCuserName` FOREIGN KEY (`userName`) REFERENCES `sys_user` (`userName`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户商品关联表';

-- ----------------------------
-- Records of rel_user_commodity
-- ----------------------------
BEGIN;
INSERT INTO `rel_user_commodity` VALUES (2, 'SH002', 'Xb18620208');
INSERT INTO `rel_user_commodity` VALUES (3, 'SH003', 'Xb18620208');
INSERT INTO `rel_user_commodity` VALUES (4, '2', 'Xb18620208');
INSERT INTO `rel_user_commodity` VALUES (5, '3', 'Xb18620208');
INSERT INTO `rel_user_commodity` VALUES (6, '1', 'Xb18620208');
INSERT INTO `rel_user_commodity` VALUES (15, 'SH004', 'Xb18620208');
INSERT INTO `rel_user_commodity` VALUES (32, 'SH001', 'Xb18620208');
INSERT INTO `rel_user_commodity` VALUES (47, 'AB001', 'Xb18620208');
COMMIT;

-- ----------------------------
-- Table structure for rel_user_role
-- ----------------------------
DROP TABLE IF EXISTS `rel_user_role`;
CREATE TABLE `rel_user_role` (
                                 `id` int NOT NULL AUTO_INCREMENT COMMENT '序号',
                                 `userName` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
                                 `roleId` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色号',
                                 PRIMARY KEY (`id`),
                                 KEY `userName` (`userName`),
                                 KEY `roleId` (`roleId`),
                                 CONSTRAINT `RURroleId` FOREIGN KEY (`roleId`) REFERENCES `sys_role` (`roleId`) ON DELETE CASCADE ON UPDATE CASCADE,
                                 CONSTRAINT `RURuserName` FOREIGN KEY (`userName`) REFERENCES `sys_user` (`userName`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户角色关联表';

-- ----------------------------
-- Records of rel_user_role
-- ----------------------------
BEGIN;
INSERT INTO `rel_user_role` VALUES (38, 'Xb18620230', '2');
INSERT INTO `rel_user_role` VALUES (41, 'tzx', '3');
INSERT INTO `rel_user_role` VALUES (52, 'Xb18620208', '1');
INSERT INTO `rel_user_role` VALUES (53, 'admin', '1');
COMMIT;

-- ----------------------------
-- Table structure for sys_commodity
-- ----------------------------
DROP TABLE IF EXISTS `sys_commodity`;
CREATE TABLE `sys_commodity` (
                                 `comId` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商品号',
                                 `comName` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '名称',
                                 `comQuantity` int NOT NULL COMMENT '数量',
                                 `comQuantityNow` int NOT NULL COMMENT '当前数量',
                                 `comEachPrice` double NOT NULL COMMENT '单价',
                                 `comDescription` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '描述',
                                 `comRateCount` int NOT NULL COMMENT '评价次数',
                                 `comRate` double NOT NULL COMMENT '评价',
                                 `comPicture` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '图片',
                                 `utcCreate` bigint NOT NULL COMMENT '创建时间',
                                 `utcModify` bigint NOT NULL COMMENT '修改时间',
                                 `modifyBy` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '修改人',
                                 `valid` bit(1) NOT NULL COMMENT '是否有效',
                                 `remark` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
                                 `customa` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '自定义字段a',
                                 `customb` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '自定义字段b',
                                 PRIMARY KEY (`comId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统商品表';

-- ----------------------------
-- Records of sys_commodity
-- ----------------------------
BEGIN;
INSERT INTO `sys_commodity` VALUES ('1', '扫把', 1, 1, 10, '一把破旧的扫把', 1, 1, 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1620647426805.png', 1621074167413, 1621074167413, 'Xb18620208', b'0', NULL, NULL, NULL);
INSERT INTO `sys_commodity` VALUES ('2', '扫把', 1, 1, 10, '一把破旧的扫把', 1, 1, 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1620647426805.png', 1621074167413, 1621074167413, 'Xb18620208', b'0', NULL, NULL, NULL);
INSERT INTO `sys_commodity` VALUES ('3', '扫把', 1, 1, 10, '一把破旧的扫把', 1, 1, 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1620647426805.png', 1621074167413, 1621074167413, 'Xb18620208', b'0', NULL, NULL, NULL);
INSERT INTO `sys_commodity` VALUES ('AB001', '二维码商品', 100, 100, 1000, '一个付款码', 0, 0, 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1621695850819.png', 1621695844394, 1621695851747, 'Xb18620208', b'1', NULL, NULL, NULL);
INSERT INTO `sys_commodity` VALUES ('SH001', '扫把', 1, 1, 10, '一把破旧的扫把', 1, 1, 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1620647426805.png', 1621074167413, 1621074167413, 'Xb18620208', b'1', NULL, NULL, NULL);
INSERT INTO `sys_commodity` VALUES ('SH002', '拖把', 2, 2, 20, '一把破旧的拖把', 1, 3, 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1620647602176.png', 1621074167413, 1621074167413, 'Xb18620208', b'1', NULL, NULL, NULL);
INSERT INTO `sys_commodity` VALUES ('SH003', '帽子', 3, 3, 30, '一顶破旧的帽子', 1, 4, 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1620654043454.png', 1621074167413, 1621074167413, 'Xb18620208', b'1', NULL, NULL, NULL);
INSERT INTO `sys_commodity` VALUES ('SH004', '靴子', 4, 4, 40, '一双破旧的靴子', 3, 3.67, 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1620654880844.png', 1621074167413, 1621694969099, 'Xb18620208', b'1', NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_order
-- ----------------------------
DROP TABLE IF EXISTS `sys_order`;
CREATE TABLE `sys_order` (
                             `id` int NOT NULL AUTO_INCREMENT COMMENT '序号',
                             `orderComId` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '交易商品',
                             `orderNewId` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '新商品号',
                             `orderSalerName` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '卖家账号',
                             `orderBuyerName` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '买家账号',
                             `orderSalerAddress` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '发货地址',
                             `orderBuyerAddress` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '收货地址',
                             `orderTransportCode` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '运单号',
                             `orderCreateTime` bigint DEFAULT NULL COMMENT '创建时间',
                             `orderTransportTime` bigint DEFAULT NULL COMMENT '发货时间',
                             `orderReceiveTime` bigint DEFAULT NULL COMMENT '收货时间',
                             `orderStatus` int NOT NULL COMMENT '订单状态\n1：已下单\n2：已发货\n3：已收货',
                             `utcCreate` bigint NOT NULL COMMENT '创建时间',
                             `utcModify` bigint NOT NULL COMMENT '修改时间',
                             `modifyBy` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '修改人',
                             `valid` bit(1) NOT NULL COMMENT '是否有效',
                             `remark` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
                             `customa` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '自定义字段a',
                             `customb` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '自定义字段b',
                             PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统订单表';

-- ----------------------------
-- Records of sys_order
-- ----------------------------
BEGIN;
INSERT INTO `sys_order` VALUES (1, 'SH001', '1', 'Xb18620208', 'Xb18620208', NULL, '浙江理工大学科技与艺术学院', NULL, 1621521292269, 0, 0, 1, 1621521292269, 1621521292269, 'Xb18620208', b'1', NULL, NULL, NULL);
INSERT INTO `sys_order` VALUES (2, 'SH002', '2', 'Xb18620208', 'Xb18620230', '测试地址', '买家地址', NULL, 1621531597274, 1621531788815, 0, 2, 1621531597274, 1621531597274, 'Xb18620230', b'1', NULL, NULL, NULL);
INSERT INTO `sys_order` VALUES (3, 'SH003', '2', 'Xb18620208', 'Xb18620230', '测试地址', '买家地址', 'test', 1621531597274, 1621531788815, 1621531788815, 3, 1621531597274, 1621531597274, 'Xb18620230', b'1', NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_permission`;
CREATE TABLE `sys_permission` (
                                  `perId` int NOT NULL AUTO_INCREMENT COMMENT '序号',
                                  `perName` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '权限名',
                                  `perCode` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '代码',
                                  `perUrl` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '请求路径',
                                  `utcCreate` bigint NOT NULL COMMENT '创建时间',
                                  `utcModify` bigint NOT NULL COMMENT '修改时间',
                                  `modifyBy` bigint NOT NULL COMMENT '修改人',
                                  `valid` bit(1) NOT NULL COMMENT '是否有效',
                                  `remark` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
                                  `customa` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '自定义字段a',
                                  `customb` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '自定义字段b',
                                  PRIMARY KEY (`perId`,`perCode`) USING BTREE,
                                  KEY `perCode` (`perCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统权限表';

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
                            `roleId` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色号',
                            `roleNameCn` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '中文名',
                            `roleNameEn` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '英文名',
                            `roleDescription` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '描述',
                            `utcCreate` bigint NOT NULL COMMENT '创建时间',
                            `utcModify` bigint NOT NULL COMMENT '修改时间',
                            `modifyBy` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '修改人',
                            `valid` bit(1) NOT NULL COMMENT '是否有效',
                            `remark` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
                            `customa` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '自定义字段a',
                            `customb` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '自定义字段b',
                            PRIMARY KEY (`roleId`,`roleNameEn`) USING BTREE,
                            KEY `roleId` (`roleId`),
                            KEY `roleNameEn` (`roleNameEn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统角色表';

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
                            `userName` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
                            `userPassword` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
                            `userNick` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '姓名',
                            `userGender` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '性别',
                            `userPhone` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '电话',
                            `userEmail` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮箱',
                            `userQuest` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密保问题',
                            `userAnswer` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密保答案',
                            `userAvatar` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '头像',
                            `userLastLogin` bigint DEFAULT NULL COMMENT '最近登录时间',
                            `utcCreate` bigint NOT NULL COMMENT '创建时间',
                            `utcModify` bigint NOT NULL COMMENT '修改时间',
                            `modifyBy` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '修改人',
                            `valid` bit(1) NOT NULL COMMENT '是否有效',
                            `remark` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
                            `customa` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '自定义字段a',
                            `customb` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '自定义字段b',
                            PRIMARY KEY (`userName`) USING BTREE,
                            KEY `userName` (`userName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统用户表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
BEGIN;
INSERT INTO `sys_user` VALUES ('admin', 'admin', 'admin', '男', NULL, NULL, '您的大学叫什么？', '科艺', NULL, 1621700779401, 1621700765210, 1621700765215, 'Xb18620208', b'1', NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('tzx', '123456', '铁zx', '女', NULL, NULL, '您的大学叫什么？', '科艺', NULL, NULL, 1621074167413, 1621074167413, 'Xb18620208', b'1', NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('Xb18620208', '123456', '贾泽楷', '男', '13506839371', 'jiazekai1003@gmail.com', '您的大学叫什么？', '科艺', 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1620647285178.jpg', 1621700739112, 1621074167413, 1621355622574, 'Xb18620208', b'1', NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('Xb18620230', '123456', '胡馨月', '女', NULL, NULL, '您的大学叫什么？', '科艺', 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1620653759436.jpeg', 1621693187544, 1621074167413, 1621074167413, 'Xb18620208', b'1', NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_user_address
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_address`;
CREATE TABLE `sys_user_address` (
                                    `id` int NOT NULL AUTO_INCREMENT COMMENT '序号',
                                    `userName` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
                                    `address` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '地址',
                                    `utcCreate` bigint NOT NULL COMMENT '创建时间',
                                    `utcModify` bigint NOT NULL COMMENT '修改时间',
                                    `modifyBy` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '修改人',
                                    `valid` bit(1) NOT NULL COMMENT '是否有效',
                                    `remark` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
                                    `customa` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '自定义字段a',
                                    `customb` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '自定义字段b',
                                    PRIMARY KEY (`id`,`userName`),
                                    KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统用户地址表';

-- ----------------------------
-- Records of sys_user_address
-- ----------------------------
BEGIN;
INSERT INTO `sys_user_address` VALUES (1, 'Xb18620208', '浙江理工大学科技与艺术学院', 1621500653289, 1621500653289, 'Xb18620208', b'1', NULL, NULL, NULL);
INSERT INTO `sys_user_address` VALUES (2, 'Xb18620208', '请按回车或点击鼠标选择地址', 1621501115035, 1621501115035, 'Xb18620208', b'1', NULL, NULL, NULL);
INSERT INTO `sys_user_address` VALUES (3, 'Xb18620208', '测试地址', 1621518470623, 1621518470623, 'Xb18620208', b'1', NULL, NULL, NULL);
INSERT INTO `sys_user_address` VALUES (4, 'Xb18620230', '买家地址', 1621530064972, 1621530064972, 'Xb18620230', b'1', NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Procedure structure for resetSQL
-- ----------------------------
DROP PROCEDURE IF EXISTS `resetSQL`;
delimiter ;;
CREATE PROCEDURE `resetSQL`()
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

   Date: 23/05/2021 21:14:49
  */

    SET NAMES utf8mb4;
    SET FOREIGN_KEY_CHECKS = 0;

    -- ----------------------------
-- Table structure for rel_role_permission
-- ----------------------------
    DROP TABLE IF EXISTS `rel_role_permission`;
    CREATE TABLE `rel_role_permission` (
                                           `id` int NOT NULL AUTO_INCREMENT,
                                           `roleNameEn` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色英文名',
                                           `perCode` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '权限代码',
                                           PRIMARY KEY (`id`,`roleNameEn`,`perCode`) USING BTREE,
                                           KEY `perCode` (`perCode`),
                                           KEY `roleNameEn` (`roleNameEn`),
                                           CONSTRAINT `RRPperCode` FOREIGN KEY (`perCode`) REFERENCES `sys_permission` (`perCode`) ON DELETE CASCADE ON UPDATE CASCADE,
                                           CONSTRAINT `RRProleNameEn` FOREIGN KEY (`roleNameEn`) REFERENCES `sys_role` (`roleNameEn`) ON DELETE CASCADE ON UPDATE CASCADE
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色权限关联表';

    -- ----------------------------
-- Table structure for rel_user_commodity
-- ----------------------------
    DROP TABLE IF EXISTS `rel_user_commodity`;
    CREATE TABLE `rel_user_commodity` (
                                          `id` int NOT NULL AUTO_INCREMENT COMMENT '序号',
                                          `comId` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商品号',
                                          `userName` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
                                          PRIMARY KEY (`id`),
                                          KEY `name` (`userName`),
                                          KEY `id` (`comId`),
                                          CONSTRAINT `RUCcomId` FOREIGN KEY (`comId`) REFERENCES `sys_commodity` (`comId`) ON DELETE CASCADE ON UPDATE CASCADE,
                                          CONSTRAINT `RUCuserName` FOREIGN KEY (`userName`) REFERENCES `sys_user` (`userName`) ON DELETE CASCADE ON UPDATE CASCADE
    ) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户商品关联表';

    -- ----------------------------
-- Records of rel_user_commodity
-- ----------------------------

    INSERT INTO `rel_user_commodity` VALUES (2, 'SH002', 'Xb18620208');
    INSERT INTO `rel_user_commodity` VALUES (3, 'SH003', 'Xb18620208');
    INSERT INTO `rel_user_commodity` VALUES (4, '2', 'Xb18620208');
    INSERT INTO `rel_user_commodity` VALUES (5, '3', 'Xb18620208');
    INSERT INTO `rel_user_commodity` VALUES (6, '1', 'Xb18620208');
    INSERT INTO `rel_user_commodity` VALUES (15, 'SH004', 'Xb18620208');
    INSERT INTO `rel_user_commodity` VALUES (32, 'SH001', 'Xb18620208');
    INSERT INTO `rel_user_commodity` VALUES (47, 'AB001', 'Xb18620208');
    COMMIT;

    -- ----------------------------
-- Table structure for rel_user_role
-- ----------------------------
    DROP TABLE IF EXISTS `rel_user_role`;
    CREATE TABLE `rel_user_role` (
                                     `id` int NOT NULL AUTO_INCREMENT COMMENT '序号',
                                     `userName` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
                                     `roleId` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色号',
                                     PRIMARY KEY (`id`),
                                     KEY `userName` (`userName`),
                                     KEY `roleId` (`roleId`),
                                     CONSTRAINT `RURroleId` FOREIGN KEY (`roleId`) REFERENCES `sys_role` (`roleId`) ON DELETE CASCADE ON UPDATE CASCADE,
                                     CONSTRAINT `RURuserName` FOREIGN KEY (`userName`) REFERENCES `sys_user` (`userName`) ON DELETE CASCADE ON UPDATE CASCADE
    ) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户角色关联表';

    -- ----------------------------
-- Records of rel_user_role
-- ----------------------------

    INSERT INTO `rel_user_role` VALUES (38, 'Xb18620230', '2');
    INSERT INTO `rel_user_role` VALUES (41, 'tzx', '3');
    INSERT INTO `rel_user_role` VALUES (52, 'Xb18620208', '1');
    INSERT INTO `rel_user_role` VALUES (53, 'admin', '1');
    COMMIT;

    -- ----------------------------
-- Table structure for sys_commodity
-- ----------------------------
    DROP TABLE IF EXISTS `sys_commodity`;
    CREATE TABLE `sys_commodity` (
                                     `comId` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商品号',
                                     `comName` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '名称',
                                     `comQuantity` int NOT NULL COMMENT '数量',
                                     `comQuantityNow` int NOT NULL COMMENT '当前数量',
                                     `comEachPrice` double NOT NULL COMMENT '单价',
                                     `comDescription` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '描述',
                                     `comRateCount` int NOT NULL COMMENT '评价次数',
                                     `comRate` double NOT NULL COMMENT '评价',
                                     `comPicture` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '图片',
                                     `utcCreate` bigint NOT NULL COMMENT '创建时间',
                                     `utcModify` bigint NOT NULL COMMENT '修改时间',
                                     `modifyBy` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '修改人',
                                     `valid` bit(1) NOT NULL COMMENT '是否有效',
                                     `remark` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
                                     `customa` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '自定义字段a',
                                     `customb` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '自定义字段b',
                                     PRIMARY KEY (`comId`) USING BTREE
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统商品表';

    -- ----------------------------
-- Records of sys_commodity
-- ----------------------------

    INSERT INTO `sys_commodity` VALUES ('1', '扫把', 1, 1, 10, '一把破旧的扫把', 1, 1, 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1620647426805.png', 1621074167413, 1621074167413, 'Xb18620208', b'0', NULL, NULL, NULL);
    INSERT INTO `sys_commodity` VALUES ('2', '扫把', 1, 1, 10, '一把破旧的扫把', 1, 1, 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1620647426805.png', 1621074167413, 1621074167413, 'Xb18620208', b'0', NULL, NULL, NULL);
    INSERT INTO `sys_commodity` VALUES ('3', '扫把', 1, 1, 10, '一把破旧的扫把', 1, 1, 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1620647426805.png', 1621074167413, 1621074167413, 'Xb18620208', b'0', NULL, NULL, NULL);
    INSERT INTO `sys_commodity` VALUES ('AB001', '二维码商品', 100, 100, 1000, '一个付款码', 0, 0, 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1621695850819.png', 1621695844394, 1621695851747, 'Xb18620208', b'1', NULL, NULL, NULL);
    INSERT INTO `sys_commodity` VALUES ('SH001', '扫把', 1, 1, 10, '一把破旧的扫把', 1, 1, 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1620647426805.png', 1621074167413, 1621074167413, 'Xb18620208', b'1', NULL, NULL, NULL);
    INSERT INTO `sys_commodity` VALUES ('SH002', '拖把', 2, 2, 20, '一把破旧的拖把', 1, 3, 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1620647602176.png', 1621074167413, 1621074167413, 'Xb18620208', b'1', NULL, NULL, NULL);
    INSERT INTO `sys_commodity` VALUES ('SH003', '帽子', 3, 3, 30, '一顶破旧的帽子', 1, 4, 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1620654043454.png', 1621074167413, 1621074167413, 'Xb18620208', b'1', NULL, NULL, NULL);
    INSERT INTO `sys_commodity` VALUES ('SH004', '靴子', 4, 4, 40, '一双破旧的靴子', 3, 3.67, 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1620654880844.png', 1621074167413, 1621694969099, 'Xb18620208', b'1', NULL, NULL, NULL);
    COMMIT;

    -- ----------------------------
-- Table structure for sys_order
-- ----------------------------
    DROP TABLE IF EXISTS `sys_order`;
    CREATE TABLE `sys_order` (
                                 `id` int NOT NULL AUTO_INCREMENT COMMENT '序号',
                                 `orderComId` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '交易商品',
                                 `orderNewId` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '新商品号',
                                 `orderSalerName` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '卖家账号',
                                 `orderBuyerName` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '买家账号',
                                 `orderSalerAddress` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '发货地址',
                                 `orderBuyerAddress` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '收货地址',
                                 `orderTransportCode` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '运单号',
                                 `orderCreateTime` bigint DEFAULT NULL COMMENT '创建时间',
                                 `orderTransportTime` bigint DEFAULT NULL COMMENT '发货时间',
                                 `orderReceiveTime` bigint DEFAULT NULL COMMENT '收货时间',
                                 `orderStatus` int NOT NULL COMMENT '订单状态\n1：已下单\n2：已发货\n3：已收货',
                                 `utcCreate` bigint NOT NULL COMMENT '创建时间',
                                 `utcModify` bigint NOT NULL COMMENT '修改时间',
                                 `modifyBy` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '修改人',
                                 `valid` bit(1) NOT NULL COMMENT '是否有效',
                                 `remark` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
                                 `customa` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '自定义字段a',
                                 `customb` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '自定义字段b',
                                 PRIMARY KEY (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统订单表';

    -- ----------------------------
-- Records of sys_order
-- ----------------------------

    INSERT INTO `sys_order` VALUES (1, 'SH001', '1', 'Xb18620208', 'Xb18620208', NULL, '浙江理工大学科技与艺术学院', NULL, 1621521292269, 0, 0, 1, 1621521292269, 1621521292269, 'Xb18620208', b'1', NULL, NULL, NULL);
    INSERT INTO `sys_order` VALUES (2, 'SH002', '2', 'Xb18620208', 'Xb18620230', '测试地址', '买家地址', NULL, 1621531597274, 1621531788815, 0, 2, 1621531597274, 1621531597274, 'Xb18620230', b'1', NULL, NULL, NULL);
    INSERT INTO `sys_order` VALUES (3, 'SH003', '2', 'Xb18620208', 'Xb18620230', '测试地址', '买家地址', 'test', 1621531597274, 1621531788815, 1621531788815, 3, 1621531597274, 1621531597274, 'Xb18620230', b'1', NULL, NULL, NULL);
    COMMIT;

    -- ----------------------------
-- Table structure for sys_permission
-- ----------------------------
    DROP TABLE IF EXISTS `sys_permission`;
    CREATE TABLE `sys_permission` (
                                      `perId` int NOT NULL AUTO_INCREMENT COMMENT '序号',
                                      `perName` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '权限名',
                                      `perCode` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '代码',
                                      `perUrl` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '请求路径',
                                      `utcCreate` bigint NOT NULL COMMENT '创建时间',
                                      `utcModify` bigint NOT NULL COMMENT '修改时间',
                                      `modifyBy` bigint NOT NULL COMMENT '修改人',
                                      `valid` bit(1) NOT NULL COMMENT '是否有效',
                                      `remark` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
                                      `customa` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '自定义字段a',
                                      `customb` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '自定义字段b',
                                      PRIMARY KEY (`perId`,`perCode`) USING BTREE,
                                      KEY `perCode` (`perCode`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统权限表';

    -- ----------------------------
-- Table structure for sys_role
-- ----------------------------
    DROP TABLE IF EXISTS `sys_role`;
    CREATE TABLE `sys_role` (
                                `roleId` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色号',
                                `roleNameCn` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '中文名',
                                `roleNameEn` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '英文名',
                                `roleDescription` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '描述',
                                `utcCreate` bigint NOT NULL COMMENT '创建时间',
                                `utcModify` bigint NOT NULL COMMENT '修改时间',
                                `modifyBy` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '修改人',
                                `valid` bit(1) NOT NULL COMMENT '是否有效',
                                `remark` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
                                `customa` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '自定义字段a',
                                `customb` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '自定义字段b',
                                PRIMARY KEY (`roleId`,`roleNameEn`) USING BTREE,
                                KEY `roleId` (`roleId`),
                                KEY `roleNameEn` (`roleNameEn`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统角色表';

    -- ----------------------------
-- Records of sys_role
-- ----------------------------

    INSERT INTO `sys_role` VALUES ('1', '管理员', 'admin', '系统管理员，拥有最高权限', 1621074167413, 1621074167413, 'Xb18620208', b'1', NULL, NULL, NULL);
    INSERT INTO `sys_role` VALUES ('2', '买方', 'buyer', '购买二手商品方', 1621074167413, 1621074167413, 'Xb18620208', b'1', NULL, NULL, NULL);
    INSERT INTO `sys_role` VALUES ('3', '卖方', 'saler', '出售二手商品方', 1621074167413, 1621074167413, 'Xb18620208', b'1', NULL, NULL, NULL);
    COMMIT;

    -- ----------------------------
-- Table structure for sys_user
-- ----------------------------
    DROP TABLE IF EXISTS `sys_user`;
    CREATE TABLE `sys_user` (
                                `userName` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
                                `userPassword` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
                                `userNick` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '姓名',
                                `userGender` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '性别',
                                `userPhone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '电话',
                                `userEmail` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮箱',
                                `userQuest` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密保问题',
                                `userAnswer` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密保答案',
                                `userAvatar` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '头像',
                                `userLastLogin` bigint DEFAULT NULL COMMENT '最近登录时间',
                                `utcCreate` bigint NOT NULL COMMENT '创建时间',
                                `utcModify` bigint NOT NULL COMMENT '修改时间',
                                `modifyBy` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '修改人',
                                `valid` bit(1) NOT NULL COMMENT '是否有效',
                                `remark` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
                                `customa` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '自定义字段a',
                                `customb` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '自定义字段b',
                                PRIMARY KEY (`userName`) USING BTREE,
                                KEY `userName` (`userName`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统用户表';

    -- ----------------------------
-- Records of sys_user
-- ----------------------------

    INSERT INTO `sys_user` VALUES ('admin', 'admin', 'admin', '男', NULL, NULL, '您的大学叫什么？', '科艺', NULL, 1621700779401, 1621700765210, 1621700765215, 'Xb18620208', b'1', NULL, NULL, NULL);
    INSERT INTO `sys_user` VALUES ('tzx', '123456', '铁zx', '女', NULL, NULL, '您的大学叫什么？', '科艺', NULL, NULL, 1621074167413, 1621074167413, 'Xb18620208', b'1', NULL, NULL, NULL);
    INSERT INTO `sys_user` VALUES ('Xb18620208', '123456', '贾泽楷', '男', '13506839371', 'jiazekai1003@gmail.com', '您的大学叫什么？', '科艺', 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1620647285178.jpg', 1621700739112, 1621074167413, 1621355622574, 'Xb18620208', b'1', NULL, NULL, NULL);
    INSERT INTO `sys_user` VALUES ('Xb18620230', '123456', '胡馨月', '女', NULL, NULL, '您的大学叫什么？', '科艺', 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1620653759436.jpeg', 1621693187544, 1621074167413, 1621074167413, 'Xb18620208', b'1', NULL, NULL, NULL);
    COMMIT;

    -- ----------------------------
-- Table structure for sys_user_address
-- ----------------------------
    DROP TABLE IF EXISTS `sys_user_address`;
    CREATE TABLE `sys_user_address` (
                                        `id` int NOT NULL AUTO_INCREMENT COMMENT '序号',
                                        `userName` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
                                        `address` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '地址',
                                        `utcCreate` bigint NOT NULL COMMENT '创建时间',
                                        `utcModify` bigint NOT NULL COMMENT '修改时间',
                                        `modifyBy` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '修改人',
                                        `valid` bit(1) NOT NULL COMMENT '是否有效',
                                        `remark` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
                                        `customa` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '自定义字段a',
                                        `customb` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '自定义字段b',
                                        PRIMARY KEY (`id`,`userName`),
                                        KEY `id` (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统用户地址表';

    -- ----------------------------
-- Records of sys_user_address
-- ----------------------------

    INSERT INTO `sys_user_address` VALUES (1, 'Xb18620208', '浙江理工大学科技与艺术学院', 1621500653289, 1621500653289, 'Xb18620208', b'1', NULL, NULL, NULL);
    INSERT INTO `sys_user_address` VALUES (2, 'Xb18620208', '请按回车或点击鼠标选择地址', 1621501115035, 1621501115035, 'Xb18620208', b'1', NULL, NULL, NULL);
    INSERT INTO `sys_user_address` VALUES (3, 'Xb18620208', '测试地址', 1621518470623, 1621518470623, 'Xb18620208', b'1', NULL, NULL, NULL);
    INSERT INTO `sys_user_address` VALUES (4, 'Xb18620230', '买家地址', 1621530064972, 1621530064972, 'Xb18620230', b'1', NULL, NULL, NULL);
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
CREATE EVENT `resetSQL`
    ON SCHEDULE
        EVERY '2' HOUR STARTS '2021-05-23 21:30:31'
    ON COMPLETION PRESERVE
    DO CALL resetSQL()
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
