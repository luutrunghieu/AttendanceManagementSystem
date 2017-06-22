/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50505
Source Host           : localhost:3306
Source Database       : attendancemanagementsystem

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2017-06-22 15:06:14
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `account`
-- ----------------------------
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `type` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20143579 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of account
-- ----------------------------
INSERT INTO account VALUES ('100001', 'oanhnt@soict.hust.edu.vn', '123', '1');
INSERT INTO account VALUES ('20140128', 'vuanh@gmail.com', '123', '0');
INSERT INTO account VALUES ('20140320', 'giabao@gmail.com', '123', '0');
INSERT INTO account VALUES ('20141515', 'trunghieu@gmail.com', '123', '0');
INSERT INTO account VALUES ('20141943', 'vanhuy@gmail.com', '123', '0');
INSERT INTO account VALUES ('20142078', 'manhhung@gmail.com', '123', '0');
INSERT INTO account VALUES ('20143578', 'vanquang@gmail.com', '123', '0');

-- ----------------------------
-- Table structure for `attendancelist`
-- ----------------------------
DROP TABLE IF EXISTS `attendancelist`;
CREATE TABLE `attendancelist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `student_id` int(11) DEFAULT NULL,
  `class_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lecture_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of attendancelist
-- ----------------------------
INSERT INTO attendancelist VALUES ('43', '20140128', 'IT4091', '1');
INSERT INTO attendancelist VALUES ('44', '20141515', 'IT4091', '1');
INSERT INTO attendancelist VALUES ('45', '20140320', 'IT4091', '1');
INSERT INTO attendancelist VALUES ('46', '20143578', 'IT4091', '1');
INSERT INTO attendancelist VALUES ('47', '20142078', 'IT4091', '1');
INSERT INTO attendancelist VALUES ('48', '20141943', 'IT4091', '1');

-- ----------------------------
-- Table structure for `class`
-- ----------------------------
DROP TABLE IF EXISTS `class`;
CREATE TABLE `class` (
  `id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `prof_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `prof_id` (`prof_id`),
  CONSTRAINT `class_ibfk_1` FOREIGN KEY (`prof_id`) REFERENCES `professor` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of class
-- ----------------------------
INSERT INTO class VALUES ('IT4091', '100001', 'Image Processing');

-- ----------------------------
-- Table structure for `lecture`
-- ----------------------------
DROP TABLE IF EXISTS `lecture`;
CREATE TABLE `lecture` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `class_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `class_id` (`class_id`),
  CONSTRAINT `lecture_ibfk_1` FOREIGN KEY (`class_id`) REFERENCES `class` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of lecture
-- ----------------------------
INSERT INTO lecture VALUES ('1', '2017-01-01', 'IT4091');
INSERT INTO lecture VALUES ('2', '2017-01-02', 'IT4091');
INSERT INTO lecture VALUES ('3', '2017-01-03', 'IT4091');

-- ----------------------------
-- Table structure for `lectureimage`
-- ----------------------------
DROP TABLE IF EXISTS `lectureimage`;
CREATE TABLE `lectureimage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `link` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lecture_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lecture_id` (`lecture_id`),
  CONSTRAINT `lectureimage_ibfk_1` FOREIGN KEY (`lecture_id`) REFERENCES `lecture` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of lectureimage
-- ----------------------------
INSERT INTO lectureimage VALUES ('4', 'https://9d4b6cec.ngrok.io/static/img/class1_1_predicted.jpg', '1');

-- ----------------------------
-- Table structure for `lectureimagebystudent`
-- ----------------------------
DROP TABLE IF EXISTS `lectureimagebystudent`;
CREATE TABLE `lectureimagebystudent` (
  `lectureimage_id` int(11) DEFAULT NULL,
  `student_id` int(11) DEFAULT NULL,
  KEY `lecture_id` (`lectureimage_id`),
  KEY `student_id` (`student_id`),
  CONSTRAINT `lectureimagebystudent_ibfk_1` FOREIGN KEY (`lectureimage_id`) REFERENCES `lectureimage` (`id`),
  CONSTRAINT `lectureimagebystudent_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `student` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of lectureimagebystudent
-- ----------------------------
INSERT INTO lectureimagebystudent VALUES ('4', '20140128');
INSERT INTO lectureimagebystudent VALUES ('4', '20141515');
INSERT INTO lectureimagebystudent VALUES ('4', '20140320');
INSERT INTO lectureimagebystudent VALUES ('4', '20143578');
INSERT INTO lectureimagebystudent VALUES ('4', '20142078');
INSERT INTO lectureimagebystudent VALUES ('4', '20141943');

-- ----------------------------
-- Table structure for `professor`
-- ----------------------------
DROP TABLE IF EXISTS `professor`;
CREATE TABLE `professor` (
  `id` int(11) NOT NULL,
  `name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `professor_ibfk_1` FOREIGN KEY (`id`) REFERENCES `account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of professor
-- ----------------------------
INSERT INTO professor VALUES ('100001', 'Nguyễn Thị Oanh', null, null);

-- ----------------------------
-- Table structure for `request`
-- ----------------------------
DROP TABLE IF EXISTS `request`;
CREATE TABLE `request` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `send_from_student` int(11) DEFAULT NULL,
  `send_to_prof` int(11) DEFAULT NULL,
  `student_tagged` int(11) DEFAULT NULL,
  `image_used` int(11) DEFAULT NULL,
  `responde` binary(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `send_from_student` (`send_from_student`),
  KEY `send_to_prof` (`send_to_prof`),
  KEY `student_tagged` (`student_tagged`),
  KEY `image_used` (`image_used`),
  CONSTRAINT `request_ibfk_1` FOREIGN KEY (`send_from_student`) REFERENCES `student` (`id`),
  CONSTRAINT `request_ibfk_2` FOREIGN KEY (`send_to_prof`) REFERENCES `professor` (`id`),
  CONSTRAINT `request_ibfk_3` FOREIGN KEY (`student_tagged`) REFERENCES `student` (`id`),
  CONSTRAINT `request_ibfk_4` FOREIGN KEY (`image_used`) REFERENCES `lectureimage` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of request
-- ----------------------------

-- ----------------------------
-- Table structure for `student`
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
  `id` int(11) NOT NULL,
  `name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `student_ibfk_1` FOREIGN KEY (`id`) REFERENCES `account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO student VALUES ('20140128', 'Nguyễn Hoàng Vũ Anh', null, null);
INSERT INTO student VALUES ('20140320', 'Hồ Gia Bảo', null, null);
INSERT INTO student VALUES ('20141515', 'Lưu Trung Hiếu', null, null);
INSERT INTO student VALUES ('20141943', 'Lê Văn Huy', null, null);
INSERT INTO student VALUES ('20142078', 'Lữ Mạnh Hùng', null, null);
INSERT INTO student VALUES ('20143578', 'Hà Văn Quang', null, null);

-- ----------------------------
-- Table structure for `studentimage`
-- ----------------------------
DROP TABLE IF EXISTS `studentimage`;
CREATE TABLE `studentimage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `link` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `student_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `student_id` (`student_id`),
  CONSTRAINT `studentimage_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `student` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of studentimage
-- ----------------------------
