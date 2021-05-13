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
-- Table structure for table `rel_user_commodity`
--

DROP TABLE IF EXISTS `rel_user_commodity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rel_user_commodity` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '序号',
  `comId` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '商品号',
  `userName` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '用户名',
  PRIMARY KEY (`id`),
  KEY `name` (`userName`),
  KEY `id` (`comId`),
  CONSTRAINT `id` FOREIGN KEY (`comId`) REFERENCES `sys_commodity` (`comId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `name` FOREIGN KEY (`userName`) REFERENCES `sys_user` (`userName`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='用户商品关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rel_user_commodity`
--

LOCK TABLES `rel_user_commodity` WRITE;
/*!40000 ALTER TABLE `rel_user_commodity` DISABLE KEYS */;
INSERT INTO `rel_user_commodity` VALUES (2,'SH002','Xb18620208'),(3,'SH003','Xb18620208'),(15,'SH004','Xb18620208'),(32,'SH001','Xb18620208');
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
  `userName` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '用户名',
  `roleId` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '角色号',
  PRIMARY KEY (`id`),
  KEY `userName` (`userName`),
  KEY `roleId` (`roleId`),
  CONSTRAINT `roleId` FOREIGN KEY (`roleId`) REFERENCES `sys_role` (`roleId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `userName` FOREIGN KEY (`userName`) REFERENCES `sys_user` (`userName`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='用户角色关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rel_user_role`
--

LOCK TABLES `rel_user_role` WRITE;
/*!40000 ALTER TABLE `rel_user_role` DISABLE KEYS */;
INSERT INTO `rel_user_role` VALUES (12,'测试','2'),(14,'LiuHX','3'),(28,'Xb18620208','1'),(29,'Xb18620230','2');
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
  PRIMARY KEY (`comId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='系统商品表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_commodity`
--

LOCK TABLES `sys_commodity` WRITE;
/*!40000 ALTER TABLE `sys_commodity` DISABLE KEYS */;
INSERT INTO `sys_commodity` VALUES ('SH001','扫把',1,1,10,'一把破旧的扫把',1,1,'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1620647426805.png'),('SH002','拖把',2,2,20,'一把破旧的拖把',1,3,'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1620647602176.png'),('SH003','帽子',3,3,30,'一顶破旧的帽子',1,4,'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1620654043454.png'),('SH004','靴子',4,3,40,'一双破旧的靴子',4,3.75,'https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1620654880844.png');
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
  `orderSalerName` varchar(255) NOT NULL COMMENT '卖家账号',
  `orderBuyerName` varchar(255) NOT NULL COMMENT '买家账号',
  `orderCreateTime` bigint NOT NULL COMMENT '创建时间',
  `orderTransportTime` bigint DEFAULT NULL COMMENT '发货时间',
  `orderRecieveTime` bigint DEFAULT NULL COMMENT '收货时间',
  `orderStatus` int NOT NULL COMMENT '订单状态\n1：已下单\n2：已发货\n3：已收货',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='系统订单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_order`
--

LOCK TABLES `sys_order` WRITE;
/*!40000 ALTER TABLE `sys_order` DISABLE KEYS */;
INSERT INTO `sys_order` VALUES (1,'Xb18620208','Xb18620230',0,0,0,1);
/*!40000 ALTER TABLE `sys_order` ENABLE KEYS */;
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
  PRIMARY KEY (`roleId`) USING BTREE,
  KEY `roleId` (`roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='系统角色表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role`
--

LOCK TABLES `sys_role` WRITE;
/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;
INSERT INTO `sys_role` VALUES ('1','管理员','admin','系统管理员，拥有最高权限'),('2','买方','buyer','购买二手商品方'),('3','卖方','saler','出售二手商品方');
/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user`
--

DROP TABLE IF EXISTS `sys_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
  PRIMARY KEY (`userName`) USING BTREE,
  KEY `userName` (`userName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='系统用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user`
--

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
INSERT INTO `sys_user` VALUES ('LiuHX','999','刘海霞','女',NULL,NULL,'您的姓名','刘海霞',NULL),('Xb18620208','123456','贾泽楷','男','13506839371','jiazekai1003@gmail.com','您的姓名','贾泽楷','https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1620647285178.jpg'),('Xb18620230','123456','胡馨月','女',NULL,NULL,'您的姓名','胡馨月','https://gitee.com/Robot_Kevin/TypeChoImg/raw/master/cct/1620653759436.jpeg'),('测试','123','泽楷贾','男','13506839371','845923059@qq.com','您的大学叫什么？','科艺',NULL);
/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;
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

-- Dump completed on 2021-05-13 10:59:50
