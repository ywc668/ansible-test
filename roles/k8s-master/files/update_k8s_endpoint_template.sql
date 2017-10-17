CREATE DATABASE  IF NOT EXISTS `autoshift` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `autoshift`;

LOCK TABLES `k8s_endpoint` WRITE;
/*!40000 ALTER TABLE `k8s_endpoint` DISABLE KEYS */;

UPDATE k8s_endpoint set server_certificate="SERVER_CERTIFICATE" where id=1;
UPDATE k8s_endpoint set `key`="CLIENT_KEY" where id=1;
UPDATE k8s_endpoint set client_certificate="CLIENT_CERTIFICATE" where id=1;

/*!40000 ALTER TABLE `k8s_endpoint` ENABLE KEYS */;
UNLOCK TABLES;
