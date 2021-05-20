-- MySQL dump 10.13  Distrib 8.0.21, for Win64 (x86_64)
--
-- Host: localhost    Database: javaweb
-- ------------------------------------------------------
-- Server version	8.0.21

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `rel_role_permission`
--

DROP TABLE IF EXISTS `rel_role_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rel_role_permission`
--

LOCK TABLES `rel_role_permission` WRITE;
/*!40000 ALTER TABLE `rel_role_permission` DISABLE KEYS */;
/*!40000 ALTER TABLE `rel_role_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rel_user_commodity`
--

DROP TABLE IF EXISTS `rel_user_commodity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rel_user_commodity`
--

LOCK TABLES `rel_user_commodity` WRITE;
/*!40000 ALTER TABLE `rel_user_commodity` DISABLE KEYS */;
INSERT INTO `rel_user_commodity` VALUES (2,'SH002','Xb18620208'),(3,'SH003','Xb18620208'),(15,'SH004','Xb18620208'),(32,'SH001','Xb18620208'),(42,'12','Xb18620208');
/*!40000 ALTER TABLE `rel_user_commodity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rel_user_role`
--

DROP TABLE IF EXISTS `rel_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rel_user_role`
--

LOCK TABLES `rel_user_role` WRITE;
/*!40000 ALTER TABLE `rel_user_role` DISABLE KEYS */;
INSERT INTO `rel_user_role` VALUES (38,'Xb18620230','2'),(41,'LiuHX','1'),(52,'Xb18620208','1');
/*!40000 ALTER TABLE `rel_user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_commodity`
--

DROP TABLE IF EXISTS `sys_commodity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
  `modifyBy` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '修改人',
  `valid` bit(1) NOT NULL COMMENT '是否有效',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  `customa` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '自定义字段a',
  `customb` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '自定义字段b',
  PRIMARY KEY (`comId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='系统商品表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_commodity`
--

LOCK TABLES `sys_commodity` WRITE;
/*!40000 ALTER TABLE `sys_commodity` DISABLE KEYS */;
INSERT INTO `sys_commodity` VALUES ('12','12',1,1,1,'12',0,0,'',1621354212502,1621354212530,'Xb18620208',_binary '\0',NULL,NULL,NULL),('SH001','扫把',1,1,10,'一把破旧的扫把',1,1,'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1620647426805.png',1621074167413,1621074167413,'Xb18620208',_binary '',NULL,NULL,NULL),('SH002','拖把',2,2,20,'一把破旧的拖把',1,3,'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1620647602176.png',1621074167413,1621074167413,'Xb18620208',_binary '',NULL,NULL,NULL),('SH003','帽子',3,3,30,'一顶破旧的帽子',1,4,'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1620654043454.png',1621074167413,1621074167413,'Xb18620208',_binary '',NULL,NULL,NULL),('SH004','靴子',4,3,40,'一双破旧的靴子',4,3.75,'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1620654880844.png',1621074167413,1621354212607,'Xb18620208',_binary '',NULL,NULL,NULL);
/*!40000 ALTER TABLE `sys_commodity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_order`
--

DROP TABLE IF EXISTS `sys_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
  `modifyBy` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '修改人',
  `valid` bit(1) NOT NULL COMMENT '是否有效',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  `customa` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '自定义字段a',
  `customb` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '自定义字段b',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='系统订单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_order`
--

LOCK TABLES `sys_order` WRITE;
/*!40000 ALTER TABLE `sys_order` DISABLE KEYS */;
INSERT INTO `sys_order` VALUES (12,'SH004','12','Xb18620208','Xb18620208',1621354212588,NULL,NULL,1,1621354212588,1621354212588,'Xb18620208',_binary '',NULL,NULL,NULL);
/*!40000 ALTER TABLE `sys_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_permission`
--

DROP TABLE IF EXISTS `sys_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_permission` (
  `perId` int NOT NULL AUTO_INCREMENT COMMENT '序号',
  `perName` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '权限名',
  `perCode` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '代码',
  `perUrl` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '请求路径',
  `utcCreate` bigint NOT NULL COMMENT '创建时间',
  `utcModify` bigint NOT NULL COMMENT '修改时间',
  `modifyBy` bigint NOT NULL COMMENT '修改人',
  `valid` bit(1) NOT NULL COMMENT '是否有效',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  `customa` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '自定义字段a',
  `customb` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '自定义字段b',
  PRIMARY KEY (`perId`,`perCode`) USING BTREE,
  KEY `perCode` (`perCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='系统权限表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_permission`
--

LOCK TABLES `sys_permission` WRITE;
/*!40000 ALTER TABLE `sys_permission` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role`
--

DROP TABLE IF EXISTS `sys_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role` (
  `roleId` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '角色号',
  `roleNameCn` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '中文名',
  `roleNameEn` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '英文名',
  `roleDescription` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '描述',
  `utcCreate` bigint NOT NULL COMMENT '创建时间',
  `utcModify` bigint NOT NULL COMMENT '修改时间',
  `modifyBy` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '修改人',
  `valid` bit(1) NOT NULL COMMENT '是否有效',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  `customa` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '自定义字段a',
  `customb` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '自定义字段b',
  PRIMARY KEY (`roleId`,`roleNameEn`) USING BTREE,
  KEY `roleId` (`roleId`),
  KEY `roleNameEn` (`roleNameEn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='系统角色表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role`
--

LOCK TABLES `sys_role` WRITE;
/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;
INSERT INTO `sys_role` VALUES ('1','管理员','admin','系统管理员，拥有最高权限',1621074167413,1621074167413,'Xb18620208',_binary '',NULL,NULL,NULL),('2','买方','buyer','购买二手商品方',1621074167413,1621074167413,'Xb18620208',_binary '',NULL,NULL,NULL),('3','卖方','saler','出售二手商品方',1621074167413,1621074167413,'Xb18620208',_binary '',NULL,NULL,NULL);
/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user`
--

DROP TABLE IF EXISTS `sys_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user` (
  `userName` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '用户名',
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
  `modifyBy` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '修改人',
  `valid` bit(1) NOT NULL COMMENT '是否有效',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  `customa` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '自定义字段a',
  `customb` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '自定义字段b',
  PRIMARY KEY (`userName`) USING BTREE,
  KEY `userName` (`userName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='系统用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user`
--

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
INSERT INTO `sys_user` VALUES ('LiuHX','123456','刘海霞','女',NULL,NULL,'您的大学叫什么？','科艺',NULL,NULL,1621074167413,1621074167413,'Xb18620208',_binary '',NULL,NULL,NULL),('Xb18620208','123456','贾泽楷','男','13506839371','jiazekai1003@gmail.com','您的大学叫什么？','科艺','https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1620647285178.jpg',1621494125551,1621074167413,1621355622574,'Xb18620208',_binary '',NULL,NULL,NULL),('Xb18620230','123456','胡馨月','女',NULL,NULL,'您的大学叫什么？','科艺','https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1620653759436.jpeg',NULL,1621074167413,1621074167413,'Xb18620208',_binary '',NULL,NULL,NULL);
/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_address`
--

DROP TABLE IF EXISTS `sys_user_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user_address` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '序号',
  `userName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '地址',
  `utcCreate` bigint NOT NULL COMMENT '创建时间',
  `utcModify` bigint NOT NULL COMMENT '修改时间',
  `modifyBy` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '修改人',
  `valid` bit(1) NOT NULL COMMENT '是否有效',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  `customa` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '自定义字段a',
  `customb` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '自定义字段b',
  PRIMARY KEY (`id`,`userName`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='系统用户地址表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_address`
--

LOCK TABLES `sys_user_address` WRITE;
/*!40000 ALTER TABLE `sys_user_address` DISABLE KEYS */;
INSERT INTO `sys_user_address` VALUES (19,'Xb18620208','浙江理工大学科技与艺术学院',1621500653289,1621500653289,'Xb18620208',_binary '',NULL,NULL,NULL),(24,'Xb18620208','收到',1621501058091,1621501058091,'Xb18620208',_binary '',NULL,NULL,NULL),(25,'Xb18620208','请按回车或点击鼠标选择地址',1621501115035,1621501115035,'Xb18620208',_binary '',NULL,NULL,NULL);
/*!40000 ALTER TABLE `sys_user_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'javaweb'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-05-20 19:33:26
