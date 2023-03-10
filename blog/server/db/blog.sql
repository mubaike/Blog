/*
Navicat MySQL Data Transfer

Source Server         : test
Source Server Version : 50720
Source Host           : 127.0.0.1:3306
Source Database       : blog

Target Server Type    : MYSQL
Target Server Version : 50720
File Encoding         : 65001

Date: 2023-03-03 23:04:19
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` bigint(20) NOT NULL,
  `account` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `token` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('1', 'admin', '123456', 'cb36b407-3443-40c2-974d-c4d0ee75efad');

-- ----------------------------
-- Table structure for `blog`
-- ----------------------------
DROP TABLE IF EXISTS `blog`;
CREATE TABLE `blog` (
  `id` bigint(20) NOT NULL,
  `category_id` bigint(20) DEFAULT NULL,
  `title` varchar(200) DEFAULT NULL,
  `content` text,
  `create_time` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of blog
-- ----------------------------
INSERT INTO `blog` VALUES ('409643903807557', '409629426831429', '测试标题01', '叽叽叽叽叽叽叽', '1677847518703');
INSERT INTO `blog` VALUES ('409643922866245', '409629340905541', '测试标题02', '斤斤计较急急急急急急急急急急急急急急急', '1677847523356');
INSERT INTO `blog` VALUES ('409643938132037', '409629340905541', '测试标题03', '斤斤计较急急急急急急急急急急急急急急急', '1677847527083');
INSERT INTO `blog` VALUES ('409643980103749', '409629426831429', '测试标题04', 'hello world', '1677847537330');
INSERT INTO `blog` VALUES ('409649993543749', null, 'hhhhh', 'sdsddsds', '1677849005455');
INSERT INTO `blog` VALUES ('409650078302277', '409629340905541', 'hhhhh', 'sdsddsds', '1677849026148');
INSERT INTO `blog` VALUES ('409650146766917', '409629340905541', 'hhhhh', 'sdsddsds', '1677849042863');

-- ----------------------------
-- Table structure for `category`
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` bigint(20) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES ('409626485514309', '后端');
INSERT INTO `category` VALUES ('409629340905541', '前端已死');
INSERT INTO `category` VALUES ('409629393174597', '前端已绝');
INSERT INTO `category` VALUES ('409629426831429', '前端绝境重生');
INSERT INTO `category` VALUES ('409662561775685', '小米');
