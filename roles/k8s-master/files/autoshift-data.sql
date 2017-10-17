CREATE DATABASE  IF NOT EXISTS `autoshift` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `autoshift`;

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

LOCK TABLES app WRITE;
/*!40000 ALTER TABLE app DISABLE KEYS */;
INSERT INTO app VALUES (1,'acmeair','http://kubernetes.io/images/flower.png',1,1,NULL,'2016-10-22 07:12:34'),(2,'vmall','http://res.vmallres.com/images/echannel/newLogo.png',2,1,NULL,'2016-10-22 07:44:15');
/*!40000 ALTER TABLE app ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES app_blueprint WRITE;
/*!40000 ALTER TABLE app_blueprint DISABLE KEYS */;
/*!40000 ALTER TABLE app_blueprint ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES app_metrics WRITE;
/*!40000 ALTER TABLE app_metrics DISABLE KEYS */;
/*!40000 ALTER TABLE app_metrics ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES app_sla WRITE;
/*!40000 ALTER TABLE app_sla DISABLE KEYS */;
INSERT INTO app_sla VALUES (1,1,20,200,1500,'Dollar'),(2,2,10,200,1500,'Dollar');
/*!40000 ALTER TABLE app_sla ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES app_status WRITE;
/*!40000 ALTER TABLE app_status DISABLE KEYS */;
INSERT INTO app_status VALUES (1,'creating',NULL,NULL,NULL),(2,'planning',2,2,4),(5,'creating',3,5,5),(6,'creating',1,0,0),(7,'creating',7,8,8),(8,'creating',3,5,5),(9,'creating',3,5,5),(10,'creating',0,0,0),(11,'creating',3,5,5),(12,'creating',4,5,5),(13,'creating',4,5,5),(14,'creating',3,4,4),(15,'creating',0,1,1),(16,'creating',0,1,1),(17,'creating',3,5,5),(18,'creating',3,5,5);
/*!40000 ALTER TABLE app_status ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES autoshift_application_mode WRITE;
/*!40000 ALTER TABLE autoshift_application_mode DISABLE KEYS */;
INSERT INTO autoshift_application_mode VALUES (1,1,75),(2,2,75);
/*!40000 ALTER TABLE autoshift_application_mode ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES capacity_plan WRITE;
/*!40000 ALTER TABLE capacity_plan DISABLE KEYS */;
INSERT INTO capacity_plan VALUES (1,'acmeair test',1,1,1,1,NULL,'CREATED',NULL,NULL,NULL,'2017-04-06 05:22:19'),(2,'vmall test',2,2,1,2,NULL,'CREATED',NULL,NULL,NULL,'2017-04-06 05:22:52');
/*!40000 ALTER TABLE capacity_plan ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES capacity_plan_result WRITE;
/*!40000 ALTER TABLE capacity_plan_result DISABLE KEYS */;
INSERT INTO capacity_plan_result VALUES (1,1,1,1,1,300,NULL,NULL,'CREATED','2017-04-06 05:23:34'),(2,2,2,2,2,300,NULL,NULL,'CREATED','2017-04-06 05:23:34');
/*!40000 ALTER TABLE capacity_plan_result ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES demand_profile WRITE;
/*!40000 ALTER TABLE demand_profile DISABLE KEYS */;
INSERT INTO demand_profile VALUES (1,'summer','summer demand',NULL,NULL,NULL,300,1,1,'0000-00-00 00:00:00'),(2,'winter','winter demand (vmall)',NULL,NULL,NULL,300,2,2,'2017-04-06 05:21:42');
/*!40000 ALTER TABLE demand_profile ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES deployment_plan WRITE;
/*!40000 ALTER TABLE deployment_plan DISABLE KEYS */;
/*!40000 ALTER TABLE deployment_plan ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES image_repos WRITE;
/*!40000 ALTER TABLE image_repos DISABLE KEYS */;
INSERT INTO image_repos VALUES (0,1,'117.78.33.214','ew0KCSJhdXRocyI6IHsNCgkJIjExNy43OC4zMy4yMTQiOiB7DQoJCQkiYXV0aCI6ICJYMkYxZEdoZmRHOXJaVzQ2WXpJek9HWmlNelF3T0dFNU5EQTNOamcxWWpBMk9XWXpPRGN5WXpBeE9XWXRRMDFHVHpoUlNrcE9VMWswVnpGRVFsbEtXVkV0TWpBeE56RXdNakV3TWpNeU5EWXRZemhqTkRWbU16RmlaVGN4TTJFMU1XSTFOR1UzWkRObFpqY3laRGhoTVdKa016UmlZMk0xTkRJMU5ERTRaR1U0WVRNMVpqZ3dOMkV3TURVd1lqUmhOUT09Ig0KCQl9DQoJfQ0KfQ==','2016-10-25 00:39:45');
/*!40000 ALTER TABLE image_repos ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `k8s_endpoint` WRITE;
/*!40000 ALTER TABLE `k8s_endpoint` DISABLE KEYS */;
INSERT INTO `k8s_endpoint` VALUES (1,'https://192.168.16.11:6443/','','','','paas-cloud1',4,'2017-05-19 22:13:45');
/*!40000 ALTER TABLE `k8s_endpoint` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES location WRITE;
/*!40000 ALTER TABLE location DISABLE KEYS */;
INSERT INTO location VALUES (1,'Huabei-2 HwCloud',39.54,116.68,'region=cn-north-2,provider=hwcloud','2','2016-10-22 07:49:35'),(2,'Huabei-1 HwCloud',39.54,116.68,'region=cn-north-1,provider=hwcloud','2','2016-10-22 07:49:35'),(3,'Huabei-1 Aliyun',36.06,120.38,'region=cn-north-1,provider=aliyun','2','2016-10-22 07:49:35'),(4,'US WEST AWS',43.8041,120.5542,'region=us-west,provider=aws','2','2016-10-22 06:44:27'),(5,'EU Frankfurt AWS',50.1109,8.6821,'region=eu-central-frankfurt,provider=aws','2','2016-10-22 06:44:27'),(6,'Sydney AWS',-33.883056,151.2166667,'region=ap-southeast-sydney,provider=aws','2','2016-10-22 06:44:27'),(7,'SINGAPORE AWS',1.29027,103.851959,'region=ap-southeast-singapore,provider=aws','2','2016-10-22 06:44:27'),(8,'ShenZhen Aliyun',22.54,114.05,'region=cn-north-1,provider=aliyun','2','2016-10-22 07:49:35');
/*!40000 ALTER TABLE location ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES remediation_action WRITE;
/*!40000 ALTER TABLE remediation_action DISABLE KEYS */;
INSERT INTO remediation_action VALUES (1, 2, "CPU", "+20%", NULL, "RECOMMENDED", 1, 0.05, NULL, NULL, "2017-04-07 04:00:00", NULL, "RECOMMENDED", NULL),(2, 2, "MEMORY", "-20%", NULL, "CUSTOMIZED", 1, 0.05, NULL, NULL, "2017-04-07 08:00:00", NULL, "RECOMMENDED", NULL),(3, 2, "SCALE", "+2", NULL, "USER_APPROVED", 1, 0.05, NULL, NULL, "2017-04-07 16:00:00", NULL, "RECOMMENDED", NULL),(4, 2, "SCALE", "-1", NULL, "AUTO_APPLIED", 1, 0.05, NULL, NULL, "2017-04-07 20:00:00", NULL, "RECOMMENDED", NULL);
/*!40000 ALTER TABLE remediation_action ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES services_config WRITE;
/*!40000 ALTER TABLE services_config DISABLE KEYS */;
INSERT INTO services_config VALUES (1,'mysql','db',2048000000,200000,1,'2016-10-22 06:44:27'),(2,'_default','_default',1024000000,100000,1,'2016-10-22 06:44:27'),(3,'nginx','loadbalancer',1024000000,100000,1,'2016-10-22 06:44:27'),(4,'redis','db',1024000000,100000,1,'2016-10-22 06:44:27');
/*!40000 ALTER TABLE services_config ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES user WRITE;
/*!40000 ALTER TABLE user DISABLE KEYS */;
INSERT INTO user VALUES (1,'Xiaoyun.Zhu@huawei.com','autoshift16@hw','xiaoyun','zhu',NULL,'2016-10-22 06:44:27');
/*!40000 ALTER TABLE user ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
