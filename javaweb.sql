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

 Date: 11/05/2021 23:18:56
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for rel_user_commodity
-- ----------------------------
DROP TABLE IF EXISTS `rel_user_commodity`;
CREATE TABLE `rel_user_commodity` (
  `id` int NOT NULL AUTO_INCREMENT,
  `comId` varchar(255) COLLATE utf8_bin NOT NULL,
  `userName` varchar(255) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`userName`),
  KEY `id` (`comId`),
  CONSTRAINT `id` FOREIGN KEY (`comId`) REFERENCES `sys_commodity` (`comId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `name` FOREIGN KEY (`userName`) REFERENCES `sys_user` (`userName`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of rel_user_commodity
-- ----------------------------
BEGIN;
INSERT INTO `rel_user_commodity` VALUES (2, 'SH002', 'Xb18620208');
INSERT INTO `rel_user_commodity` VALUES (3, 'SH003', 'Xb18620208');
INSERT INTO `rel_user_commodity` VALUES (15, 'SH004', 'Xb18620208');
INSERT INTO `rel_user_commodity` VALUES (32, 'SH001', 'Xb18620208');
COMMIT;

-- ----------------------------
-- Table structure for rel_user_role
-- ----------------------------
DROP TABLE IF EXISTS `rel_user_role`;
CREATE TABLE `rel_user_role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userName` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `roleId` varchar(255) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `userName` (`userName`),
  KEY `roleId` (`roleId`),
  CONSTRAINT `roleId` FOREIGN KEY (`roleId`) REFERENCES `sys_role` (`roleId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `userName` FOREIGN KEY (`userName`) REFERENCES `sys_user` (`userName`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of rel_user_role
-- ----------------------------
BEGIN;
INSERT INTO `rel_user_role` VALUES (12, '测试', '2');
INSERT INTO `rel_user_role` VALUES (14, 'LiuHX', '3');
INSERT INTO `rel_user_role` VALUES (28, 'Xb18620208', '1');
INSERT INTO `rel_user_role` VALUES (29, 'Xb18620230', '2');
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
  PRIMARY KEY (`comId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of sys_commodity
-- ----------------------------
BEGIN;
INSERT INTO `sys_commodity` VALUES ('SH001', '扫把', 1, 1, 10, '一把破旧的扫把', 1, 1, 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1620647426805.png');
INSERT INTO `sys_commodity` VALUES ('SH002', '拖把', 2, 2, 20, '一把破旧的拖把', 1, 3, 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1620647602176.png');
INSERT INTO `sys_commodity` VALUES ('SH003', '帽子', 3, 3, 30, '一顶破旧的帽子', 1, 4, 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1620654043454.png');
INSERT INTO `sys_commodity` VALUES ('SH004', '靴子', 4, 3, 40, '一双破旧的靴子', 4, 3.75, 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1620654880844.png');
COMMIT;

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `roleId` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '角色号',
  `roleNameCn` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '中文名',
  `roleNameEn` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '英文名',
  `roleDescription` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '描述',
  PRIMARY KEY (`roleId`) USING BTREE,
  KEY `roleId` (`roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
BEGIN;
INSERT INTO `sys_role` VALUES ('1', '管理员', 'admin', '系统管理员，拥有最高权限');
INSERT INTO `sys_role` VALUES ('2', '买方', 'buyer', '购买二手商品方');
INSERT INTO `sys_role` VALUES ('3', '卖方', 'saler', '出售二手商品方');
COMMIT;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `userName` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '用户名',
  `userPassword` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '密码',
  `userNick` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '姓名',
  `userGender` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '性别',
  `userPhone` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '电话',
  `userEmail` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '邮箱',
  `userQuest` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '密保问题',
  `userAnswer` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '密保答案',
  `userAvatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '头像',
  PRIMARY KEY (`userName`) USING BTREE,
  KEY `userName` (`userName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
BEGIN;
INSERT INTO `sys_user` VALUES ('LiuHX', '999', '刘海霞', '女', NULL, NULL, '您的姓名', '刘海霞', NULL);
INSERT INTO `sys_user` VALUES ('Xb18620208', '123456', '贾泽楷', '男', '13506839371', 'jiazekai1003@gmail.com', '您的姓名', '贾泽楷', 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1620647285178.jpg');
INSERT INTO `sys_user` VALUES ('Xb18620230', '123456', '胡馨月', '女', NULL, NULL, '您的姓名', '胡馨月', 'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1620653759436.jpeg');
INSERT INTO `sys_user` VALUES ('测试', '123', '泽楷贾', '男', '13506839371', '845923059@qq.com', '您的大学叫什么？', '科艺', NULL);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
