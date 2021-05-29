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

 Date: 29/05/2021 02:34:21
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
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户商品关联表';

-- ----------------------------
-- Records of rel_user_commodity
-- ----------------------------
BEGIN;
INSERT INTO `rel_user_commodity` VALUES (1, '宠物001', 'saler');
INSERT INTO `rel_user_commodity` VALUES (2, '电器001', 'saler');
INSERT INTO `rel_user_commodity` VALUES (3, '生活001', 'saler2');
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
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户角色关联表';

-- ----------------------------
-- Records of rel_user_role
-- ----------------------------
BEGIN;
INSERT INTO `rel_user_role` VALUES (1, 'admin', '1');
INSERT INTO `rel_user_role` VALUES (2, 'buyer', '2');
INSERT INTO `rel_user_role` VALUES (3, 'test', '1');
INSERT INTO `rel_user_role` VALUES (4, 'saler', '3');
INSERT INTO `rel_user_role` VALUES (5, 'buyer2', '2');
INSERT INTO `rel_user_role` VALUES (6, 'saler2', '3');
INSERT INTO `rel_user_role` VALUES (68, 'wjmm', '2');
COMMIT;

-- ----------------------------
-- Table structure for sec_block_chain
-- ----------------------------
DROP TABLE IF EXISTS `sec_block_chain`;
CREATE TABLE `sec_block_chain` (
                                   `id` int NOT NULL AUTO_INCREMENT COMMENT '序号',
                                   `data` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '数据',
                                   `hash` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '哈希值',
                                   `previousHash` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '上一个区块哈希值',
                                   `timeStamp` bigint DEFAULT NULL COMMENT '时间戳',
                                   `nonce` int DEFAULT NULL COMMENT '一次性值',
                                   PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='安全区块链';

-- ----------------------------
-- Records of sec_block_chain
-- ----------------------------
BEGIN;
INSERT INTO `sec_block_chain` VALUES (1, '1622226482209', '00000415f5704de29a82114d37959bd806f03b6ced333d66910a6f0ca9ae9db3', '0', 1622226482212, 435389);
INSERT INTO `sec_block_chain` VALUES (2, '1622226545082', '00000e659df88697e5307f88d8fc8ebed00beb712e6fb3ddb48765cc2b273486', '00000415f5704de29a82114d37959bd806f03b6ced333d66910a6f0ca9ae9db3', 1622226545083, 1490220);
INSERT INTO `sec_block_chain` VALUES (3, '1622226625401', '00000ebb508fb8d58bce86d5d7285fbf1ffb46b12f729353772bce52a3f89caa', '00000e659df88697e5307f88d8fc8ebed00beb712e6fb3ddb48765cc2b273486', 1622226625403, 55541);
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
INSERT INTO `sys_commodity` VALUES ('宠物001', '领养博美幼犬', 1, 1, 12, '只需运费！！！', 0, 0, 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1621874272655.jpg', 1621874264014, 1621874274464, 'saler', b'1', NULL, NULL, NULL);
INSERT INTO `sys_commodity` VALUES ('生活001', '防紫外线伞', 100, 97, 5, '临时用伞', 2, 4.5, 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1621874745440.jpg', 1621874739991, 1622226625636, 'admin', b'1', NULL, NULL, NULL);
INSERT INTO `sys_commodity` VALUES ('电器001', '大容量移动电源', 5, 2, 50, '淘宝同款超大容量移动电源', 0, 0, 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1621874463368.jpg', 1621874459351, 1622226485034, 'admin', b'1', NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_order
-- ----------------------------
DROP TABLE IF EXISTS `sys_order`;
CREATE TABLE `sys_order` (
                             `id` int NOT NULL AUTO_INCREMENT COMMENT '序号',
                             `orderComId` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '交易商品',
                             `orderSalerName` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '卖家账号',
                             `orderBuyerName` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '买家账号',
                             `orderSalerAddress` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '发货地址',
                             `orderBuyerAddress` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '收货地址',
                             `orderTransportCode` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '运单号',
                             `orderCreateTime` bigint DEFAULT NULL COMMENT '创建时间',
                             `orderTransportTime` bigint DEFAULT NULL COMMENT '发货时间',
                             `orderReceiveTime` bigint DEFAULT NULL COMMENT '收货时间',
                             `orderStatus` int NOT NULL COMMENT '订单状态\n1：已下单\n2：已发货\n3：已收货',
                             `orderPayStatus` int NOT NULL COMMENT '付款状态\n1：已付款\n2：未付款',
                             `orderTime` bigint NOT NULL COMMENT '截止时间',
                             `utcCreate` bigint NOT NULL COMMENT '创建时间',
                             `utcModify` bigint NOT NULL COMMENT '修改时间',
                             `modifyBy` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '修改人',
                             `valid` bit(1) NOT NULL COMMENT '是否有效',
                             `remark` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
                             `customa` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '自定义字段a',
                             `customb` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '自定义字段b',
                             PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统订单表';

-- ----------------------------
-- Records of sys_order
-- ----------------------------
BEGIN;
INSERT INTO `sys_order` VALUES (1, '生活001', 'saler2', 'buyer', '2号出租方地址', '浙江理工大学科技与艺术学院', '23923829', 1621875250998, 1621875350227, 1622131945032, 3, 2, 1622736745032, 1621875250998, 1621875250998, 'buyer', b'1', NULL, NULL, NULL);
INSERT INTO `sys_order` VALUES (2, '电器001', 'saler', 'buyer', '发货地址1', '买家收货地址', '213424123', 1621875316693, 1621875384120, NULL, 2, 2, 604800000, 1621875316693, 1621875316693, 'buyer', b'1', NULL, NULL, NULL);
INSERT INTO `sys_order` VALUES (3, '电器001', 'saler', 'buyer2', NULL, '2号买家地址', NULL, 1621875509932, NULL, NULL, 1, 2, 604800000, 1621875509932, 1621875509932, 'buyer2', b'1', NULL, NULL, NULL);
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
INSERT INTO `sys_role` VALUES ('1', '管理员', 'admin', '管理员角色，拥有最高权限', 1621074167413, 1621074167413, 'Xb18620208', b'1', NULL, NULL, NULL);
INSERT INTO `sys_role` VALUES ('2', '承租方', 'buyer', '承租商品角色', 1621074167413, 1621074167413, 'Xb18620208', b'1', NULL, NULL, NULL);
INSERT INTO `sys_role` VALUES ('3', '出租方', 'saler', '出租商品角色', 1621074167413, 1621074167413, 'Xb18620208', b'1', NULL, NULL, NULL);
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
INSERT INTO `sys_user` VALUES ('admin', 'admin', 'admin', '男', '13506839371', '845923059@qq.com', '您的大学叫什么？', '科艺', 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1621873483819.jpg', 1622222776354, 1621700765210, 1621873487075, 'admin', b'1', NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('buyer', 'admin', '承租方', '女', '13565120077', 'hxy1999@gmail.com', '您最好的朋友叫什么？', '贾泽楷', NULL, 1621875393876, 1621873543898, 1621873543898, 'admin', b'1', NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('buyer2', 'admin', '承租方2', '女', '13459834838', '2@qq.com', '您的大学叫什么？', '科艺', NULL, 1621875471676, 1621873937734, 1621875584846, 'admin', b'1', NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('saler', 'admin', '出租方', '男', '13506839372', '888888888@qq.com', '您的大学叫什么？', '科艺', 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1621873980422.png', 1621875369107, 1621873454905, 1621873982071, 'saler', b'1', NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('saler2', 'admin', '出租方2', '男', '13311111111', '121212@11.com', '您的大学叫什么？', '科艺', 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1621874549792.jpeg', 1621875329870, 1621873918374, 1621875604877, 'admin', b'1', NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('test', 'admin', '测试用户', '男', '13509090909', 'oxoxoxoxoxo@163.com', '您的电子邮箱是？', 'oxoxoxoxoxo@163.com', NULL, NULL, 1621873643774, 1621873643774, 'admin', b'1', NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('wjmm', '989898', '贾泽楷', '男', '13506839371', NULL, '您的大学叫什么？', '科艺', NULL, 1622220231326, 1622220189969, 1622220745933, 'wjmm', b'1', NULL, NULL, NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统用户地址表';

-- ----------------------------
-- Records of sys_user_address
-- ----------------------------
BEGIN;
INSERT INTO `sys_user_address` VALUES (1, 'admin', 'admin测试地址', 1621873376500, 1621873376500, 'admin', b'1', NULL, NULL, NULL);
INSERT INTO `sys_user_address` VALUES (2, 'admin', 'admin承租方地址', 1621873384606, 1621873384606, 'admin', b'1', NULL, NULL, NULL);
INSERT INTO `sys_user_address` VALUES (3, 'admin', 'admin出租房地址', 1621873391202, 1621873391202, 'admin', b'1', NULL, NULL, NULL);
INSERT INTO `sys_user_address` VALUES (4, 'saler', '出租方地址', 1621874003044, 1621874003044, 'saler', b'1', NULL, NULL, NULL);
INSERT INTO `sys_user_address` VALUES (5, 'saler', '发货地址1', 1621874008811, 1621874008811, 'saler', b'1', NULL, NULL, NULL);
INSERT INTO `sys_user_address` VALUES (6, 'saler2', '2号出租方地址', 1621874564556, 1621874564556, 'saler2', b'1', NULL, NULL, NULL);
INSERT INTO `sys_user_address` VALUES (7, 'saler2', '测试发货地址2', 1621874572479, 1621874572479, 'saler2', b'1', NULL, NULL, NULL);
INSERT INTO `sys_user_address` VALUES (8, 'buyer', '买家收货地址', 1621874791682, 1621874791682, 'buyer', b'1', NULL, NULL, NULL);
INSERT INTO `sys_user_address` VALUES (9, 'buyer', '浙江理工大学科技与艺术学院', 1621874804457, 1621874804457, 'buyer', b'1', NULL, NULL, NULL);
INSERT INTO `sys_user_address` VALUES (10, 'buyer2', '2号买家地址', 1621875488119, 1621875488119, 'buyer2', b'1', NULL, NULL, NULL);
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

   Date: 25/05/2021 12:09:04
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
    ) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户商品关联表';

    -- ----------------------------
-- Records of rel_user_commodity
-- ----------------------------

    INSERT INTO `rel_user_commodity` VALUES (1, '宠物001', 'saler');
    INSERT INTO `rel_user_commodity` VALUES (2, '电器001', 'saler');
    INSERT INTO `rel_user_commodity` VALUES (3, '生活001', 'saler2');
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
    ) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户角色关联表';

    -- ----------------------------
-- Records of rel_user_role
-- ----------------------------

    INSERT INTO `rel_user_role` VALUES (1, 'admin', '1');
    INSERT INTO `rel_user_role` VALUES (2, 'buyer', '2');
    INSERT INTO `rel_user_role` VALUES (3, 'test', '1');
    INSERT INTO `rel_user_role` VALUES (4, 'saler', '3');
    INSERT INTO `rel_user_role` VALUES (5, 'buyer2', '2');
    INSERT INTO `rel_user_role` VALUES (6, 'saler2', '3');
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

    INSERT INTO `sys_commodity` VALUES ('宠物001', '领养博美幼犬', 1, 1, 12, '只需运费！！！', 0, 0, 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1621874272655.jpg', 1621874264014, 1621874274464, 'saler', b'1', NULL, NULL, NULL);
    INSERT INTO `sys_commodity` VALUES ('生活001', '防紫外线伞', 100, 99, 5, '临时用伞', 1, 4, 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1621874745440.jpg', 1621874739991, 1621875251069, 'buyer', b'1', NULL, NULL, NULL);
    INSERT INTO `sys_commodity` VALUES ('电器001', '大容量移动电源', 5, 3, 50, '淘宝同款超大容量移动电源', 0, 0, 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1621874463368.jpg', 1621874459351, 1621875509948, 'buyer2', b'1', NULL, NULL, NULL);
    COMMIT;

    -- ----------------------------
-- Table structure for sys_order
-- ----------------------------
    DROP TABLE IF EXISTS `sys_order`;
    CREATE TABLE `sys_order` (
                                 `id` int NOT NULL AUTO_INCREMENT COMMENT '序号',
                                 `orderComId` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '交易商品',
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
    ) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统订单表';

    -- ----------------------------
-- Records of sys_order
-- ----------------------------

    INSERT INTO `sys_order` VALUES (1, '生活001', 'saler2', 'buyer', '2号出租方地址', '浙江理工大学科技与艺术学院', '23923829', 1621875250998, 1621875350227, 1621875456066, 3, 1621875250998, 1621875250998, 'buyer', b'1', NULL, NULL, NULL);
    INSERT INTO `sys_order` VALUES (2, '电器001', 'saler', 'buyer', '发货地址1', '买家收货地址', '213424123', 1621875316693, 1621875384120, NULL, 2, 1621875316693, 1621875316693, 'buyer', b'1', NULL, NULL, NULL);
    INSERT INTO `sys_order` VALUES (3, '电器001', 'saler', 'buyer2', NULL, '2号买家地址', NULL, 1621875509932, NULL, NULL, 1, 1621875509932, 1621875509932, 'buyer2', b'1', NULL, NULL, NULL);
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

    INSERT INTO `sys_role` VALUES ('1', '管理员', 'admin', '管理员角色，拥有最高权限', 1621074167413, 1621074167413, 'Xb18620208', b'1', NULL, NULL, NULL);
    INSERT INTO `sys_role` VALUES ('2', '承租方', 'buyer', '承租商品角色', 1621074167413, 1621074167413, 'Xb18620208', b'1', NULL, NULL, NULL);
    INSERT INTO `sys_role` VALUES ('3', '出租方', 'saler', '出租商品角色', 1621074167413, 1621074167413, 'Xb18620208', b'1', NULL, NULL, NULL);
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

    INSERT INTO `sys_user` VALUES ('admin', 'admin', 'admin', '男', '13506839371', '845923059@qq.com', '您的大学叫什么？', '科艺', 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1621873483819.jpg', 1621875522164, 1621700765210, 1621873487075, 'admin', b'1', NULL, NULL, NULL);
    INSERT INTO `sys_user` VALUES ('buyer', 'admin', '承租方', '女', '13565120077', 'hxy1999@gmail.com', '您最好的朋友叫什么？', '贾泽楷', NULL, 1621875393876, 1621873543898, 1621873543898, 'admin', b'1', NULL, NULL, NULL);
    INSERT INTO `sys_user` VALUES ('buyer2', 'admin', '承租方2', '女', '13459834838', '2@qq.com', '您的大学叫什么？', '科艺', NULL, 1621875471676, 1621873937734, 1621875584846, 'admin', b'1', NULL, NULL, NULL);
    INSERT INTO `sys_user` VALUES ('saler', 'admin', '出租方', '男', '13506839372', '888888888@qq.com', '您的大学叫什么？', '科艺', 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1621873980422.png', 1621875369107, 1621873454905, 1621873982071, 'saler', b'1', NULL, NULL, NULL);
    INSERT INTO `sys_user` VALUES ('saler2', 'admin', '出租方2', '男', '13311111111', '121212@11.com', '您的大学叫什么？', '科艺', 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1621874549792.jpeg', 1621875329870, 1621873918374, 1621875604877, 'admin', b'1', NULL, NULL, NULL);
    INSERT INTO `sys_user` VALUES ('test', 'admin', '测试用户', '男', '13509090909', 'oxoxoxoxoxo@163.com', '您的电子邮箱是？', 'oxoxoxoxoxo@163.com', NULL, NULL, 1621873643774, 1621873643774, 'admin', b'1', NULL, NULL, NULL);
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
    ) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统用户地址表';

    -- ----------------------------
-- Records of sys_user_address
-- ----------------------------

    INSERT INTO `sys_user_address` VALUES (1, 'admin', 'admin测试地址', 1621873376500, 1621873376500, 'admin', b'1', NULL, NULL, NULL);
    INSERT INTO `sys_user_address` VALUES (2, 'admin', 'admin承租方地址', 1621873384606, 1621873384606, 'admin', b'1', NULL, NULL, NULL);
    INSERT INTO `sys_user_address` VALUES (3, 'admin', 'admin出租房地址', 1621873391202, 1621873391202, 'admin', b'1', NULL, NULL, NULL);
    INSERT INTO `sys_user_address` VALUES (4, 'saler', '出租方地址', 1621874003044, 1621874003044, 'saler', b'1', NULL, NULL, NULL);
    INSERT INTO `sys_user_address` VALUES (5, 'saler', '发货地址1', 1621874008811, 1621874008811, 'saler', b'1', NULL, NULL, NULL);
    INSERT INTO `sys_user_address` VALUES (6, 'saler2', '2号出租方地址', 1621874564556, 1621874564556, 'saler2', b'1', NULL, NULL, NULL);
    INSERT INTO `sys_user_address` VALUES (7, 'saler2', '测试发货地址2', 1621874572479, 1621874572479, 'saler2', b'1', NULL, NULL, NULL);
    INSERT INTO `sys_user_address` VALUES (8, 'buyer', '买家收货地址', 1621874791682, 1621874791682, 'buyer', b'1', NULL, NULL, NULL);
    INSERT INTO `sys_user_address` VALUES (9, 'buyer', '浙江理工大学科技与艺术学院', 1621874804457, 1621874804457, 'buyer', b'1', NULL, NULL, NULL);
    INSERT INTO `sys_user_address` VALUES (10, 'buyer2', '2号买家地址', 1621875488119, 1621875488119, 'buyer2', b'1', NULL, NULL, NULL);
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
        EVERY '1' DAY STARTS '2021-05-25 00:00:05'
    ON COMPLETION PRESERVE
    DISABLE
    DO CALL resetSQL()
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
