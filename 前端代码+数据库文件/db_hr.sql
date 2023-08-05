/*
 Navicat Premium Data Transfer

 Source Server         : 本机MySQL
 Source Server Type    : MySQL
 Source Server Version : 50719
 Source Host           : localhost:3306
 Source Schema         : db_hr

 Target Server Type    : MySQL
 Target Server Version : 50719
 File Encoding         : 65001

 Date: 05/08/2023 11:36:08
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for clock
-- ----------------------------
DROP TABLE IF EXISTS `clock`;
CREATE TABLE `clock`  (
  `clock_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '打卡签到表id',
  `user_id` bigint(16) NOT NULL COMMENT '用户编号',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `sex` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别',
  `work_id` bigint(16) NULL DEFAULT NULL COMMENT '工号',
  `clock_time` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '打卡日期',
  `is_deleted` tinyint(3) NULL DEFAULT NULL COMMENT '逻辑删除字段(0表示未删除，1表示已删除)',
  PRIMARY KEY (`clock_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of clock
-- ----------------------------
INSERT INTO `clock` VALUES ('1654872940114554881', 1, '测试', '男', 20230101, '2023-05-02', 0);
INSERT INTO `clock` VALUES ('1654872944170446849', 1, '测试', '男', 20230101, '2023-05-03', 0);
INSERT INTO `clock` VALUES ('1654872948486385665', 1, '测试', '男', 20230101, '2023-05-04', 0);
INSERT INTO `clock` VALUES ('1654872952814907393', 1, '测试', '男', 20230101, '2023-05-05', 0);
INSERT INTO `clock` VALUES ('1654872959693565953', 1, '测试', '男', 20230101, '2023-05-06', 0);
INSERT INTO `clock` VALUES ('1655202329360527361', 1, '测试', '男', 20230101, '2023-05-07', 0);
INSERT INTO `clock` VALUES ('1655888161931223041', 1, '测试', '男', 20230101, '2023-05-09', 0);
INSERT INTO `clock` VALUES ('1656440784761634818', 1, '测试人员', '女', 20230101, '2023-05-11', 1);
INSERT INTO `clock` VALUES ('1656442552774017025', 1, '测试人员', '女', 20230101, '2023-05-11', 1);
INSERT INTO `clock` VALUES ('1656451619428909058', 1, '测试人员', '女', 20230101, '2023-05-11', 1);
INSERT INTO `clock` VALUES ('1656452958326243329', 1, '测试人员', '女', 20230101, '2023-05-11', 1);
INSERT INTO `clock` VALUES ('1656455172797145090', 1, '测试人员', '女', 20230101, '2023-05-11', 0);
INSERT INTO `clock` VALUES ('1657004171916660737', 1, '测试', '男', 20230101, '2023-05-12', 0);
INSERT INTO `clock` VALUES ('1657005405092388866', 16, '李四', '男', 20230615, '2023-05-12', 0);
INSERT INTO `clock` VALUES ('1657005938121244674', 16, '李四', '男', 20230615, '2023-05-12', 1);
INSERT INTO `clock` VALUES ('1659488848111939585', 1, '测试', '男', 20230101, '2023-05-19', 0);
INSERT INTO `clock` VALUES ('1659594845463719937', 1, '测试', '男', 20230101, '2023-05-20', 0);

-- ----------------------------
-- Table structure for dept
-- ----------------------------
DROP TABLE IF EXISTS `dept`;
CREATE TABLE `dept`  (
  `dept_id` bigint(16) NOT NULL AUTO_INCREMENT COMMENT '部门编号',
  `dept_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '部门名称',
  `dept_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门编码',
  `status` tinyint(3) NULL DEFAULT 1 COMMENT '状态字段(1表示可用，0表示停用)',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_deleted` tinyint(3) NOT NULL DEFAULT 0 COMMENT '逻辑删除字段(0表示未删除，1表示已删除)',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dept
-- ----------------------------
INSERT INTO `dept` VALUES (1, '行政部', 'Administration', 1, '2023-04-23 15:26:24', '2023-04-23 15:27:57', 0);
INSERT INTO `dept` VALUES (2, '财务部', 'Finance', 1, '2023-04-23 15:26:30', '2023-04-23 15:28:13', 0);
INSERT INTO `dept` VALUES (3, '商务部', 'Business', 1, '2023-04-23 15:26:36', '2023-04-23 15:28:24', 0);
INSERT INTO `dept` VALUES (4, '销售部', 'Market', 1, '2023-04-23 15:26:42', '2023-04-23 15:28:35', 0);
INSERT INTO `dept` VALUES (5, '生产部', 'Production', 1, '2023-04-23 15:26:47', '2023-04-23 15:28:47', 0);
INSERT INTO `dept` VALUES (6, '平台项目运营部', 'Operation', 1, '2023-04-23 15:26:59', '2023-04-23 15:28:58', 0);

-- ----------------------------
-- Table structure for leave
-- ----------------------------
DROP TABLE IF EXISTS `leave`;
CREATE TABLE `leave`  (
  `leave_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '请假单号',
  `leave_days` int(16) NULL DEFAULT NULL COMMENT '请假天数',
  `leave_time` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请假时间',
  `leave_reason` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '请假理由',
  `user_id` bigint(16) NULL DEFAULT NULL COMMENT '用户编号',
  `passed` tinyint(3) NULL DEFAULT 2 COMMENT '是否通过(1表示通过，0表示不通过，2表示待审批)',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_deleted` tinyint(3) NOT NULL DEFAULT 0 COMMENT '逻辑删除字段(0表示未删除，1表示已删除)',
  PRIMARY KEY (`leave_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of leave
-- ----------------------------
INSERT INTO `leave` VALUES ('1655438275565789186', 1, '2023-05-10', '请假测试3', 1, 0, '2023-05-08 13:03:36', '2023-05-11 05:01:42', 0);
INSERT INTO `leave` VALUES ('1655447018852524034', 2, '2023-05-16', '请假测试2', 1, 1, '2023-05-08 13:38:20', '2023-05-11 05:01:44', 0);
INSERT INTO `leave` VALUES ('1655621368390041602', 3, '2023-05-23', '添加测试', 2, 1, '2023-05-09 01:11:08', '2023-05-09 23:40:47', 0);
INSERT INTO `leave` VALUES ('1655889301116772353', 30, '2023-05-16', '请假测试1', 1, 0, '2023-05-09 18:55:48', '2023-05-11 05:01:12', 0);
INSERT INTO `leave` VALUES ('1656453215516770305', 2, '2023-05-18', '请假测试请假测试请假测试', 1, 1, '2023-05-11 08:16:36', '2023-05-11 08:17:52', 1);
INSERT INTO `leave` VALUES ('1656454439305650177', 2, '2023-05-18', '1', 1, 1, '2023-05-11 08:21:28', '2023-05-11 08:21:39', 1);
INSERT INTO `leave` VALUES ('1656455323808866306', 2, '2023-05-18', '请假测试请假测试请假测试', 1, 1, '2023-05-11 08:24:59', '2023-05-11 08:27:08', 1);
INSERT INTO `leave` VALUES ('1657007002476216322', 6, '2023-05-25', '请假', 1, 2, '2023-05-12 20:57:09', '2023-05-12 20:57:17', 1);
INSERT INTO `leave` VALUES ('1657007190083239937', 6, '2023-05-26', '请假理由', 1, 2, '2023-05-12 20:57:54', '2023-05-12 20:57:54', 0);
INSERT INTO `leave` VALUES ('1657009607776534529', 2, '2023-05-15', '1', 16, 2, '2023-05-12 21:07:30', '2023-05-12 21:07:30', 0);
INSERT INTO `leave` VALUES ('1659595140918882306', 1, '2023-05-24', '123', 1, 2, '2023-05-20 00:21:30', '2023-05-20 00:21:39', 1);
INSERT INTO `leave` VALUES ('1659599792951472130', 2, '2023-05-30', '请假测试', 1, 1, '2023-05-20 00:39:59', '2023-05-20 00:39:59', 0);

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu`  (
  `menu_id` bigint(16) NOT NULL AUTO_INCREMENT COMMENT '菜单编号',
  `parent_id` bigint(16) NOT NULL DEFAULT 0 COMMENT '上级菜单',
  `menu_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '菜单名称',
  `type` tinyint(3) NOT NULL DEFAULT 0 COMMENT '类型(0:目录,1:菜单,2:按钮)',
  `path` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '路由地址',
  `component` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组件路径',
  `perms` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图标',
  `status` tinyint(3) NULL DEFAULT 1 COMMENT '状态字段(1表示可用，0表示停用)',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_deleted` tinyint(3) NOT NULL DEFAULT 0 COMMENT '逻辑删除字段(0表示未删除，1表示已删除)',
  PRIMARY KEY (`menu_id`) USING BTREE,
  INDEX `idx_parent_id`(`parent_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 57 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES (1, 0, '系统管理', 0, 'system', 'Layout', NULL, 'el-icon-s-tools', 1, '2023-04-15 13:47:36', '2023-04-23 16:18:06', 0);
INSERT INTO `menu` VALUES (2, 1, '角色管理', 1, 'role', 'system/role/list', NULL, 'el-icon-user-solid', 1, '2023-04-15 13:47:37', '2023-04-23 16:18:14', 0);
INSERT INTO `menu` VALUES (3, 1, '菜单管理', 1, 'menu', 'system/menu/list', NULL, 'el-icon-menu', 1, '2023-04-15 13:51:52', '2023-04-23 16:18:15', 0);
INSERT INTO `menu` VALUES (4, 3, '角色授权', 2, 'assignAuth', 'system/role/assignAuth', 'btn.role.assignAuth', 'el-icon-s-check', 1, '2023-04-15 13:53:35', '2023-04-23 16:18:16', 0);
INSERT INTO `menu` VALUES (5, 2, '添加', 2, '', '', 'btn.role.add', '', 1, '2023-04-15 15:49:02', '2023-04-23 16:18:17', 0);
INSERT INTO `menu` VALUES (6, 2, '删除', 2, '', '', 'btn.role.remove', '', 1, '2023-04-15 15:49:23', '2023-04-23 16:18:18', 0);
INSERT INTO `menu` VALUES (7, 2, '修改', 2, '', '', 'btn.role.update', '', 1, '2023-04-15 15:49:40', '2023-04-23 16:18:18', 0);
INSERT INTO `menu` VALUES (8, 2, '查询', 2, '', '', 'btn.role.list', '', 1, '2023-04-15 15:50:36', '2023-04-23 18:56:05', 1);
INSERT INTO `menu` VALUES (9, 0, '人事管理', 0, 'personnel', 'Layout', '', 'el-icon-s-platform', 1, '2023-04-19 14:57:26', '2023-04-19 15:00:46', 0);
INSERT INTO `menu` VALUES (10, 9, '部门管理', 1, 'dept', 'system/dept/list', '', 'el-icon-s-help', 1, '2023-04-19 14:58:11', '2023-04-19 14:59:46', 0);
INSERT INTO `menu` VALUES (11, 9, '职位管理', 1, 'post', 'system/post/list', '', 'el-icon-help', 1, '2023-04-19 15:24:30', '2023-04-19 15:24:30', 0);
INSERT INTO `menu` VALUES (12, 9, '用户管理', 1, 'user', 'system/user/list', '', 'el-icon-user', 1, '2023-04-19 15:25:01', '2023-04-23 18:38:13', 0);
INSERT INTO `menu` VALUES (13, 12, '添加', 2, '', '', 'btn.user.add', '', 1, '2023-04-19 15:33:08', '2023-04-23 18:38:15', 0);
INSERT INTO `menu` VALUES (14, 12, '删除', 2, '', '', 'btn.user.remove', '', 1, '2023-04-19 15:33:40', '2023-04-23 18:38:16', 0);
INSERT INTO `menu` VALUES (15, 12, '修改', 2, '', '', 'btn.user.update', '', 1, '2023-04-19 15:54:44', '2023-04-23 18:38:17', 0);
INSERT INTO `menu` VALUES (16, 12, '查询', 2, '', '', 'btn.user.list', '', 1, '2023-04-19 15:54:53', '2023-04-23 18:56:25', 1);
INSERT INTO `menu` VALUES (17, 0, '考勤管理', 0, 'attendance', 'Layout', '', 'el-icon-s-claim', 1, '2023-04-19 16:55:10', '2023-04-19 16:55:10', 0);
INSERT INTO `menu` VALUES (18, 0, '请假审批', 0, '', 'Layout', '', 'el-icon-finished', 1, '2023-04-19 16:58:52', '2023-04-19 16:59:04', 1);
INSERT INTO `menu` VALUES (19, 17, '请假审批', 1, 'leaveApproval', 'system/leaveApproval/list', '', 'el-icon-finished', 1, '2023-04-19 17:01:35', '2023-04-19 17:01:35', 0);
INSERT INTO `menu` VALUES (20, 17, '请假申请', 1, 'leaveApply', 'system/leaveApply/list', '', 'el-icon-s-comment', 1, '2023-04-19 17:02:50', '2023-04-19 17:02:50', 0);
INSERT INTO `menu` VALUES (21, 17, '打卡签到', 1, 'clock', 'system/clock/list', '', 'el-icon-date', 1, '2023-04-19 17:04:50', '2023-04-19 17:04:50', 0);
INSERT INTO `menu` VALUES (22, 0, '薪酬管理', 0, 'salary', 'Layout', '', 'el-icon-wallet', 1, '2023-04-19 17:27:36', '2023-04-19 17:27:36', 0);
INSERT INTO `menu` VALUES (23, 22, '工资发放', 1, 'payoff', 'system/payoff/list', '', 'el-icon-bank-card', 1, '2023-04-19 17:28:40', '2023-04-19 17:28:40', 0);
INSERT INTO `menu` VALUES (24, 22, '发放记录', 1, 'payInfo', 'system/payInfo/list', '', 'el-icon-tickets', 1, '2023-04-19 17:29:34', '2023-04-19 17:29:34', 0);
INSERT INTO `menu` VALUES (25, 0, '个人中心', 0, 'person', 'Layout', '', 'el-icon-house', 1, '2023-04-19 17:32:41', '2023-04-19 17:32:41', 0);
INSERT INTO `menu` VALUES (26, 25, '个人信息', 1, 'info', 'system/info/list', '', 'el-icon-document', 1, '2023-04-19 17:33:06', '2023-04-19 17:33:06', 0);
INSERT INTO `menu` VALUES (27, 2, '批量删除', 2, '', '', 'btn.role.batchRemove', '', 1, '2023-04-23 16:16:19', '2023-04-23 16:16:19', 0);
INSERT INTO `menu` VALUES (28, 10, '添加', 2, '', '', 'btn.dept.add', '', 1, '2023-04-23 16:21:33', '2023-04-23 16:21:33', 0);
INSERT INTO `menu` VALUES (29, 10, '删除', 2, '', '', 'btn.dept.remove', '', 1, '2023-04-23 16:21:58', '2023-04-23 16:21:58', 0);
INSERT INTO `menu` VALUES (30, 10, '修改', 2, '', '', 'btn.dept.update', '', 1, '2023-04-23 16:22:13', '2023-04-23 16:22:13', 0);
INSERT INTO `menu` VALUES (31, 10, '查询', 2, '', '', 'btn.dept.list', '', 1, '2023-04-23 16:22:51', '2023-04-23 18:56:17', 1);
INSERT INTO `menu` VALUES (32, 10, '批量删除', 2, '', '', 'btn.dept.batchRemove', '', 1, '2023-04-23 16:23:37', '2023-04-23 16:23:37', 0);
INSERT INTO `menu` VALUES (33, 10, '状态修改', 2, '', '', 'ns.dept.status', '', 1, '2023-04-23 18:12:45', '2023-04-23 18:12:45', 0);
INSERT INTO `menu` VALUES (34, 12, '状态修改', 2, '', '', 'ns.user.status', '', 1, '2023-04-23 18:28:34', '2023-04-23 18:28:34', 0);
INSERT INTO `menu` VALUES (35, 12, '角色分配', 2, '', '', 'btn.user.assignAuth', '', 1, '2023-04-23 18:32:34', '2023-04-23 18:32:34', 0);
INSERT INTO `menu` VALUES (36, 11, '添加', 2, '', '', 'btn.post.add', '', 1, '2023-04-23 18:54:38', '2023-04-23 18:54:38', 0);
INSERT INTO `menu` VALUES (37, 11, '删除', 2, '', '', 'btn.post.remove', '', 1, '2023-04-23 18:55:00', '2023-04-23 18:55:00', 0);
INSERT INTO `menu` VALUES (38, 11, '修改', 2, '', '', 'btn.post.update', '', 1, '2023-04-23 18:55:17', '2023-04-23 18:55:17', 0);
INSERT INTO `menu` VALUES (39, 11, '批量删除', 2, '', '', 'btn.post.batchRemove', '', 1, '2023-04-23 18:56:55', '2023-04-23 18:56:55', 0);
INSERT INTO `menu` VALUES (40, 11, '状态修改', 2, '', '', 'ns.post.status', '', 1, '2023-04-23 18:57:12', '2023-04-23 18:57:12', 0);
INSERT INTO `menu` VALUES (41, 12, '密码重置', 2, '', '', 'btn.user.reset', '', 1, '2023-04-24 15:23:54', '2023-04-24 15:23:54', 0);
INSERT INTO `menu` VALUES (42, 17, '打卡记录', 1, 'clockInfo', 'system/clockinfo/list', '', 'el-icon-notebook-2', 1, '2023-05-06 19:43:30', '2023-05-06 19:43:30', 0);
INSERT INTO `menu` VALUES (43, 42, '批量删除', 2, '', '', 'btn.clock.batchRemove', '', 1, '2023-05-06 23:28:36', '2023-05-06 23:28:36', 0);
INSERT INTO `menu` VALUES (44, 20, '添加', 2, '', '', 'btn.leave.add', '', 1, '2023-05-08 00:47:49', '2023-05-08 00:47:49', 0);
INSERT INTO `menu` VALUES (45, 20, '修改', 2, '', '', 'btn.leave.update', '', 1, '2023-05-08 00:48:06', '2023-05-08 00:48:06', 0);
INSERT INTO `menu` VALUES (46, 20, '删除', 2, '', '', 'btn.leave.remove', '', 1, '2023-05-08 00:48:48', '2023-05-08 00:48:48', 0);
INSERT INTO `menu` VALUES (47, 19, '通过', 2, '', '', 'btn.leave.pass', '', 1, '2023-05-09 14:55:00', '2023-05-09 14:55:00', 0);
INSERT INTO `menu` VALUES (48, 19, '驳回', 2, '', '', 'btn.leave.reject', '', 1, '2023-05-09 14:55:12', '2023-05-09 14:55:12', 0);
INSERT INTO `menu` VALUES (49, 22, '工资账套', 1, 'salary', 'system/salary/list', '', 'el-icon-money', 1, '2023-05-10 02:07:25', '2023-05-10 02:07:25', 0);
INSERT INTO `menu` VALUES (50, 49, '添加', 2, '', '', 'btn.salary.add', '', 1, '2023-05-10 02:31:50', '2023-05-10 02:31:50', 0);
INSERT INTO `menu` VALUES (51, 49, '修改', 2, '', '', 'btn.salary.update', '', 1, '2023-05-10 02:32:41', '2023-05-10 02:32:41', 0);
INSERT INTO `menu` VALUES (52, 49, '删除', 2, '', '', 'btn.salary.remove', '', 1, '2023-05-10 02:32:55', '2023-05-10 02:32:55', 0);
INSERT INTO `menu` VALUES (53, 49, '批量删除', 2, '', '', 'btn.salary.batchRemove', '', 1, '2023-05-10 02:33:37', '2023-05-10 02:33:37', 0);
INSERT INTO `menu` VALUES (54, 22, '工资查询', 1, 'income', 'system/income/list', '', 'el-icon-coin', 1, '2023-05-11 03:39:32', '2023-05-11 03:43:05', 0);
INSERT INTO `menu` VALUES (55, 23, '账套修改', 2, '', '', 'btn.payoff.update', '', 1, '2023-05-11 05:22:19', '2023-05-11 05:22:19', 0);
INSERT INTO `menu` VALUES (56, 23, '工资发放', 2, '', '', 'btn.payoff.pay', '', 1, '2023-05-11 05:22:45', '2023-05-11 05:22:45', 0);

-- ----------------------------
-- Table structure for payoff
-- ----------------------------
DROP TABLE IF EXISTS `payoff`;
CREATE TABLE `payoff`  (
  `user_id` bigint(16) NULL DEFAULT NULL COMMENT '用户id',
  `salary_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '工资账套id',
  `create_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_deleted` tinyint(3) NULL DEFAULT 0 COMMENT '逻辑删除字段(0表示未删除，1表示已删除)'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of payoff
-- ----------------------------
INSERT INTO `payoff` VALUES (1, '1656022530205405185', '2023-05-11 01:49:07', '2023-05-11 01:49:07', 0);
INSERT INTO `payoff` VALUES (2, '1656022530205405185', '2023-05-11 01:49:09', '2023-05-11 01:49:09', 0);
INSERT INTO `payoff` VALUES (16, '1656456386494504962', '2023-05-11 08:29:33', '2023-05-11 08:29:33', 0);
INSERT INTO `payoff` VALUES (18, '1659596540725899266', '2023-05-20 00:27:24', '2023-05-20 00:27:24', 0);
INSERT INTO `payoff` VALUES (35, '1659600112247058433', '2023-05-20 00:41:31', '2023-05-20 00:41:31', 0);

-- ----------------------------
-- Table structure for post
-- ----------------------------
DROP TABLE IF EXISTS `post`;
CREATE TABLE `post`  (
  `post_id` bigint(16) NOT NULL AUTO_INCREMENT COMMENT '职位编号',
  `post_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '职位名称',
  `post_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '职位编码',
  `dept_id` bigint(16) NULL DEFAULT NULL COMMENT '部门编号',
  `status` tinyint(3) NULL DEFAULT 1 COMMENT '状态字段(1表示可用，0表示停用)',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_deleted` tinyint(3) NOT NULL DEFAULT 0 COMMENT '逻辑删除字段(0表示未删除，1表示已删除)',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of post
-- ----------------------------
INSERT INTO `post` VALUES (1, '行政内勤', 'AIndoor', 1, 1, '2023-04-23 15:29:30', '2023-04-23 15:30:37', 0);
INSERT INTO `post` VALUES (2, '商务内勤', 'BIndoor', 1, 1, '2023-04-23 15:30:34', '2023-04-23 15:30:48', 0);
INSERT INTO `post` VALUES (3, '会计', 'Accountant', 2, 1, '2023-04-23 15:38:09', '2023-04-23 16:10:11', 0);
INSERT INTO `post` VALUES (4, '采购', 'Purchase', 3, 1, '2023-04-23 16:02:19', '2023-04-23 16:10:20', 0);
INSERT INTO `post` VALUES (5, '销售内勤', 'SIndoor', 3, 1, '2023-04-23 16:06:48', '2023-05-20 10:23:24', 1);
INSERT INTO `post` VALUES (6, '物流配送', 'Logistics', 3, 1, '2023-04-23 16:06:57', '2023-04-24 17:49:32', 0);
INSERT INTO `post` VALUES (7, '销售', 'Sell', 4, 1, '2023-04-23 16:07:14', '2023-04-23 16:11:28', 0);
INSERT INTO `post` VALUES (8, '产品研发', 'Development', 5, 1, '2023-04-23 16:07:39', '2023-04-23 16:11:41', 0);
INSERT INTO `post` VALUES (9, '质检员', 'QC', 5, 1, '2023-04-23 16:07:46', '2023-04-23 16:11:53', 0);
INSERT INTO `post` VALUES (10, '生产工人', 'Promote', 5, 1, '2023-04-23 16:07:56', '2023-04-23 16:12:35', 0);
INSERT INTO `post` VALUES (11, '仓管', 'Storekeeper', 5, 1, '2023-04-23 16:08:08', '2023-04-24 17:49:36', 0);
INSERT INTO `post` VALUES (12, '采购', 'Purchase', 6, 1, '2023-04-23 16:08:37', '2023-04-24 17:50:03', 1);
INSERT INTO `post` VALUES (13, '仓管', 'OStorekeeper', 6, 1, '2023-04-23 16:08:51', '2023-04-24 17:49:58', 1);
INSERT INTO `post` VALUES (14, '技术支持', 'Academic', 6, 1, '2023-04-23 16:08:58', '2023-04-24 17:49:53', 0);
INSERT INTO `post` VALUES (15, '售后服务', 'Aftermarket', 6, 1, '2023-04-23 16:09:07', '2023-04-23 16:13:12', 0);
INSERT INTO `post` VALUES (16, '物流配送', 'OLogistics', 6, 1, '2023-04-23 16:09:14', '2023-04-24 17:49:56', 1);

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `role_id` bigint(16) NOT NULL AUTO_INCREMENT COMMENT '角色编号',
  `role_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '角色名称',
  `role_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色编码',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_deleted` tinyint(3) NOT NULL DEFAULT 0 COMMENT '逻辑删除字段(0表示未删除，1表示已删除)',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, '超级管理员', 'SuperAdmin', '2023-04-17 11:25:09', '2023-04-17 11:25:09', 0);
INSERT INTO `role` VALUES (2, '管理员', 'Admin', '2023-04-17 11:25:17', '2023-04-17 11:25:17', 0);
INSERT INTO `role` VALUES (3, '普通员工', 'Worker', '2023-04-17 11:25:35', '2023-04-17 11:25:35', 0);

-- ----------------------------
-- Table structure for role_menu
-- ----------------------------
DROP TABLE IF EXISTS `role_menu`;
CREATE TABLE `role_menu`  (
  `rm_id` bigint(16) NOT NULL AUTO_INCREMENT COMMENT '角色菜单关系编号',
  `role_id` bigint(16) NOT NULL DEFAULT 0 COMMENT '角色编号',
  `menu_id` bigint(16) NOT NULL DEFAULT 0 COMMENT '菜单编号',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_deleted` tinyint(3) NOT NULL DEFAULT 0 COMMENT '逻辑删除字段(0表示未删除，1表示已删除)',
  PRIMARY KEY (`rm_id`) USING BTREE,
  INDEX `idx_role_id`(`role_id`) USING BTREE,
  INDEX `idx_menu_id`(`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 472 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role_menu
-- ----------------------------
INSERT INTO `role_menu` VALUES (1, 1, 1, '2023-04-15 17:15:05', '2023-05-12 19:40:22', 1);
INSERT INTO `role_menu` VALUES (2, 1, 2, '2023-04-15 17:15:05', '2023-05-12 19:40:22', 1);
INSERT INTO `role_menu` VALUES (3, 1, 5, '2023-04-15 17:15:05', '2023-05-12 19:40:22', 1);
INSERT INTO `role_menu` VALUES (4, 1, 6, '2023-04-15 17:15:05', '2023-05-12 19:40:22', 1);
INSERT INTO `role_menu` VALUES (5, 1, 7, '2023-04-15 17:15:05', '2023-05-12 19:40:22', 1);
INSERT INTO `role_menu` VALUES (6, 1, 8, '2023-04-15 17:15:05', '2023-05-12 19:40:22', 1);
INSERT INTO `role_menu` VALUES (7, 1, 3, '2023-04-15 17:15:05', '2023-05-12 19:40:22', 1);
INSERT INTO `role_menu` VALUES (8, 1, 4, '2023-04-15 17:15:05', '2023-05-12 19:40:22', 1);
INSERT INTO `role_menu` VALUES (9, 2, 1, '2023-04-23 16:27:51', '2023-04-23 17:39:57', 1);
INSERT INTO `role_menu` VALUES (10, 2, 2, '2023-04-23 16:27:51', '2023-04-23 17:39:57', 1);
INSERT INTO `role_menu` VALUES (11, 2, 6, '2023-04-23 16:27:51', '2023-04-23 17:39:57', 1);
INSERT INTO `role_menu` VALUES (12, 2, 7, '2023-04-23 16:27:51', '2023-04-23 17:39:57', 1);
INSERT INTO `role_menu` VALUES (13, 2, 8, '2023-04-23 16:27:51', '2023-04-23 17:39:57', 1);
INSERT INTO `role_menu` VALUES (14, 2, 3, '2023-04-23 16:27:51', '2023-04-23 17:39:57', 1);
INSERT INTO `role_menu` VALUES (15, 2, 4, '2023-04-23 16:27:51', '2023-04-23 17:39:57', 1);
INSERT INTO `role_menu` VALUES (16, 2, 1, '2023-04-23 17:39:57', '2023-04-23 17:44:51', 1);
INSERT INTO `role_menu` VALUES (17, 2, 2, '2023-04-23 17:39:57', '2023-04-23 17:44:51', 1);
INSERT INTO `role_menu` VALUES (18, 2, 5, '2023-04-23 17:39:57', '2023-04-23 17:44:51', 1);
INSERT INTO `role_menu` VALUES (19, 2, 1, '2023-04-23 17:44:51', '2023-05-02 21:52:44', 1);
INSERT INTO `role_menu` VALUES (20, 2, 2, '2023-04-23 17:44:51', '2023-05-02 21:52:44', 1);
INSERT INTO `role_menu` VALUES (21, 2, 5, '2023-04-23 17:44:51', '2023-05-02 21:52:44', 1);
INSERT INTO `role_menu` VALUES (22, 2, 9, '2023-04-23 17:44:51', '2023-05-02 21:52:44', 1);
INSERT INTO `role_menu` VALUES (23, 2, 10, '2023-04-23 17:44:51', '2023-05-02 21:52:44', 1);
INSERT INTO `role_menu` VALUES (24, 2, 28, '2023-04-23 17:44:51', '2023-05-02 21:52:44', 1);
INSERT INTO `role_menu` VALUES (25, 3, 17, '2023-04-25 21:07:02', '2023-05-02 21:52:20', 1);
INSERT INTO `role_menu` VALUES (26, 3, 20, '2023-04-25 21:07:02', '2023-05-02 21:52:20', 1);
INSERT INTO `role_menu` VALUES (27, 3, 21, '2023-04-25 21:07:02', '2023-05-02 21:52:20', 1);
INSERT INTO `role_menu` VALUES (28, 3, 22, '2023-04-25 21:07:02', '2023-05-02 21:52:20', 1);
INSERT INTO `role_menu` VALUES (29, 3, 23, '2023-04-25 21:07:02', '2023-05-02 21:52:20', 1);
INSERT INTO `role_menu` VALUES (30, 3, 24, '2023-04-25 21:07:02', '2023-05-02 21:52:20', 1);
INSERT INTO `role_menu` VALUES (31, 3, 25, '2023-04-25 21:07:02', '2023-05-02 21:52:20', 1);
INSERT INTO `role_menu` VALUES (32, 3, 26, '2023-04-25 21:07:02', '2023-05-02 21:52:20', 1);
INSERT INTO `role_menu` VALUES (33, 3, 17, '2023-05-02 21:52:20', '2023-05-11 05:39:56', 1);
INSERT INTO `role_menu` VALUES (34, 3, 20, '2023-05-02 21:52:20', '2023-05-11 05:39:56', 1);
INSERT INTO `role_menu` VALUES (35, 3, 21, '2023-05-02 21:52:20', '2023-05-11 05:39:56', 1);
INSERT INTO `role_menu` VALUES (36, 3, 22, '2023-05-02 21:52:20', '2023-05-11 05:39:56', 1);
INSERT INTO `role_menu` VALUES (37, 3, 23, '2023-05-02 21:52:20', '2023-05-11 05:39:56', 1);
INSERT INTO `role_menu` VALUES (38, 3, 24, '2023-05-02 21:52:20', '2023-05-11 05:39:56', 1);
INSERT INTO `role_menu` VALUES (39, 3, 25, '2023-05-02 21:52:20', '2023-05-11 05:39:56', 1);
INSERT INTO `role_menu` VALUES (40, 3, 26, '2023-05-02 21:52:20', '2023-05-11 05:39:56', 1);
INSERT INTO `role_menu` VALUES (41, 2, 1, '2023-05-02 21:52:44', '2023-05-06 23:20:42', 1);
INSERT INTO `role_menu` VALUES (42, 2, 2, '2023-05-02 21:52:44', '2023-05-06 23:20:42', 1);
INSERT INTO `role_menu` VALUES (43, 2, 5, '2023-05-02 21:52:44', '2023-05-06 23:20:42', 1);
INSERT INTO `role_menu` VALUES (44, 2, 6, '2023-05-02 21:52:44', '2023-05-06 23:20:42', 1);
INSERT INTO `role_menu` VALUES (45, 2, 7, '2023-05-02 21:52:44', '2023-05-06 23:20:42', 1);
INSERT INTO `role_menu` VALUES (46, 2, 27, '2023-05-02 21:52:44', '2023-05-06 23:20:42', 1);
INSERT INTO `role_menu` VALUES (47, 2, 3, '2023-05-02 21:52:44', '2023-05-06 23:20:42', 1);
INSERT INTO `role_menu` VALUES (48, 2, 4, '2023-05-02 21:52:44', '2023-05-06 23:20:42', 1);
INSERT INTO `role_menu` VALUES (49, 2, 9, '2023-05-02 21:52:44', '2023-05-06 23:20:42', 1);
INSERT INTO `role_menu` VALUES (50, 2, 10, '2023-05-02 21:52:44', '2023-05-06 23:20:42', 1);
INSERT INTO `role_menu` VALUES (51, 2, 28, '2023-05-02 21:52:44', '2023-05-06 23:20:42', 1);
INSERT INTO `role_menu` VALUES (52, 2, 29, '2023-05-02 21:52:44', '2023-05-06 23:20:42', 1);
INSERT INTO `role_menu` VALUES (53, 2, 30, '2023-05-02 21:52:44', '2023-05-06 23:20:42', 1);
INSERT INTO `role_menu` VALUES (54, 2, 32, '2023-05-02 21:52:44', '2023-05-06 23:20:42', 1);
INSERT INTO `role_menu` VALUES (55, 2, 33, '2023-05-02 21:52:44', '2023-05-06 23:20:42', 1);
INSERT INTO `role_menu` VALUES (56, 2, 11, '2023-05-02 21:52:44', '2023-05-06 23:20:42', 1);
INSERT INTO `role_menu` VALUES (57, 2, 36, '2023-05-02 21:52:44', '2023-05-06 23:20:42', 1);
INSERT INTO `role_menu` VALUES (58, 2, 37, '2023-05-02 21:52:44', '2023-05-06 23:20:42', 1);
INSERT INTO `role_menu` VALUES (59, 2, 38, '2023-05-02 21:52:44', '2023-05-06 23:20:42', 1);
INSERT INTO `role_menu` VALUES (60, 2, 39, '2023-05-02 21:52:44', '2023-05-06 23:20:42', 1);
INSERT INTO `role_menu` VALUES (61, 2, 40, '2023-05-02 21:52:44', '2023-05-06 23:20:42', 1);
INSERT INTO `role_menu` VALUES (62, 2, 12, '2023-05-02 21:52:44', '2023-05-06 23:20:42', 1);
INSERT INTO `role_menu` VALUES (63, 2, 13, '2023-05-02 21:52:44', '2023-05-06 23:20:42', 1);
INSERT INTO `role_menu` VALUES (64, 2, 14, '2023-05-02 21:52:44', '2023-05-06 23:20:42', 1);
INSERT INTO `role_menu` VALUES (65, 2, 15, '2023-05-02 21:52:44', '2023-05-06 23:20:42', 1);
INSERT INTO `role_menu` VALUES (66, 2, 34, '2023-05-02 21:52:44', '2023-05-06 23:20:42', 1);
INSERT INTO `role_menu` VALUES (67, 2, 35, '2023-05-02 21:52:44', '2023-05-06 23:20:42', 1);
INSERT INTO `role_menu` VALUES (68, 2, 41, '2023-05-02 21:52:44', '2023-05-06 23:20:42', 1);
INSERT INTO `role_menu` VALUES (69, 2, 17, '2023-05-02 21:52:44', '2023-05-06 23:20:42', 1);
INSERT INTO `role_menu` VALUES (70, 2, 19, '2023-05-02 21:52:44', '2023-05-06 23:20:42', 1);
INSERT INTO `role_menu` VALUES (71, 2, 20, '2023-05-02 21:52:44', '2023-05-06 23:20:42', 1);
INSERT INTO `role_menu` VALUES (72, 2, 21, '2023-05-02 21:52:44', '2023-05-06 23:20:42', 1);
INSERT INTO `role_menu` VALUES (73, 2, 22, '2023-05-02 21:52:44', '2023-05-06 23:20:42', 1);
INSERT INTO `role_menu` VALUES (74, 2, 23, '2023-05-02 21:52:44', '2023-05-06 23:20:42', 1);
INSERT INTO `role_menu` VALUES (75, 2, 24, '2023-05-02 21:52:44', '2023-05-06 23:20:42', 1);
INSERT INTO `role_menu` VALUES (76, 2, 25, '2023-05-02 21:52:44', '2023-05-06 23:20:42', 1);
INSERT INTO `role_menu` VALUES (77, 2, 26, '2023-05-02 21:52:44', '2023-05-06 23:20:42', 1);
INSERT INTO `role_menu` VALUES (78, 2, 1, '2023-05-06 23:20:42', '2023-05-09 00:24:59', 1);
INSERT INTO `role_menu` VALUES (79, 2, 2, '2023-05-06 23:20:42', '2023-05-09 00:24:59', 1);
INSERT INTO `role_menu` VALUES (80, 2, 5, '2023-05-06 23:20:42', '2023-05-09 00:24:59', 1);
INSERT INTO `role_menu` VALUES (81, 2, 6, '2023-05-06 23:20:42', '2023-05-09 00:24:59', 1);
INSERT INTO `role_menu` VALUES (82, 2, 7, '2023-05-06 23:20:42', '2023-05-09 00:24:59', 1);
INSERT INTO `role_menu` VALUES (83, 2, 27, '2023-05-06 23:20:42', '2023-05-09 00:24:59', 1);
INSERT INTO `role_menu` VALUES (84, 2, 3, '2023-05-06 23:20:42', '2023-05-09 00:24:59', 1);
INSERT INTO `role_menu` VALUES (85, 2, 4, '2023-05-06 23:20:42', '2023-05-09 00:24:59', 1);
INSERT INTO `role_menu` VALUES (86, 2, 9, '2023-05-06 23:20:42', '2023-05-09 00:24:59', 1);
INSERT INTO `role_menu` VALUES (87, 2, 10, '2023-05-06 23:20:42', '2023-05-09 00:24:59', 1);
INSERT INTO `role_menu` VALUES (88, 2, 28, '2023-05-06 23:20:42', '2023-05-09 00:24:59', 1);
INSERT INTO `role_menu` VALUES (89, 2, 29, '2023-05-06 23:20:42', '2023-05-09 00:24:59', 1);
INSERT INTO `role_menu` VALUES (90, 2, 30, '2023-05-06 23:20:42', '2023-05-09 00:24:59', 1);
INSERT INTO `role_menu` VALUES (91, 2, 32, '2023-05-06 23:20:42', '2023-05-09 00:24:59', 1);
INSERT INTO `role_menu` VALUES (92, 2, 33, '2023-05-06 23:20:42', '2023-05-09 00:24:59', 1);
INSERT INTO `role_menu` VALUES (93, 2, 11, '2023-05-06 23:20:42', '2023-05-09 00:24:59', 1);
INSERT INTO `role_menu` VALUES (94, 2, 36, '2023-05-06 23:20:42', '2023-05-09 00:24:59', 1);
INSERT INTO `role_menu` VALUES (95, 2, 37, '2023-05-06 23:20:42', '2023-05-09 00:24:59', 1);
INSERT INTO `role_menu` VALUES (96, 2, 38, '2023-05-06 23:20:42', '2023-05-09 00:24:59', 1);
INSERT INTO `role_menu` VALUES (97, 2, 39, '2023-05-06 23:20:42', '2023-05-09 00:24:59', 1);
INSERT INTO `role_menu` VALUES (98, 2, 40, '2023-05-06 23:20:42', '2023-05-09 00:24:59', 1);
INSERT INTO `role_menu` VALUES (99, 2, 12, '2023-05-06 23:20:42', '2023-05-09 00:24:59', 1);
INSERT INTO `role_menu` VALUES (100, 2, 13, '2023-05-06 23:20:42', '2023-05-09 00:24:59', 1);
INSERT INTO `role_menu` VALUES (101, 2, 14, '2023-05-06 23:20:42', '2023-05-09 00:24:59', 1);
INSERT INTO `role_menu` VALUES (102, 2, 15, '2023-05-06 23:20:42', '2023-05-09 00:24:59', 1);
INSERT INTO `role_menu` VALUES (103, 2, 34, '2023-05-06 23:20:42', '2023-05-09 00:24:59', 1);
INSERT INTO `role_menu` VALUES (104, 2, 35, '2023-05-06 23:20:42', '2023-05-09 00:24:59', 1);
INSERT INTO `role_menu` VALUES (105, 2, 41, '2023-05-06 23:20:42', '2023-05-09 00:24:59', 1);
INSERT INTO `role_menu` VALUES (106, 2, 17, '2023-05-06 23:20:42', '2023-05-09 00:24:59', 1);
INSERT INTO `role_menu` VALUES (107, 2, 19, '2023-05-06 23:20:42', '2023-05-09 00:24:59', 1);
INSERT INTO `role_menu` VALUES (108, 2, 20, '2023-05-06 23:20:42', '2023-05-09 00:24:59', 1);
INSERT INTO `role_menu` VALUES (109, 2, 21, '2023-05-06 23:20:42', '2023-05-09 00:24:59', 1);
INSERT INTO `role_menu` VALUES (110, 2, 42, '2023-05-06 23:20:42', '2023-05-09 00:24:59', 1);
INSERT INTO `role_menu` VALUES (111, 2, 22, '2023-05-06 23:20:42', '2023-05-09 00:24:59', 1);
INSERT INTO `role_menu` VALUES (112, 2, 23, '2023-05-06 23:20:42', '2023-05-09 00:24:59', 1);
INSERT INTO `role_menu` VALUES (113, 2, 24, '2023-05-06 23:20:42', '2023-05-09 00:24:59', 1);
INSERT INTO `role_menu` VALUES (114, 2, 25, '2023-05-06 23:20:42', '2023-05-09 00:24:59', 1);
INSERT INTO `role_menu` VALUES (115, 2, 26, '2023-05-06 23:20:42', '2023-05-09 00:24:59', 1);
INSERT INTO `role_menu` VALUES (116, 2, 1, '2023-05-09 00:24:59', '2023-05-11 04:33:31', 1);
INSERT INTO `role_menu` VALUES (117, 2, 2, '2023-05-09 00:25:00', '2023-05-11 04:33:31', 1);
INSERT INTO `role_menu` VALUES (118, 2, 5, '2023-05-09 00:25:00', '2023-05-11 04:33:31', 1);
INSERT INTO `role_menu` VALUES (119, 2, 6, '2023-05-09 00:25:00', '2023-05-11 04:33:31', 1);
INSERT INTO `role_menu` VALUES (120, 2, 7, '2023-05-09 00:25:00', '2023-05-11 04:33:31', 1);
INSERT INTO `role_menu` VALUES (121, 2, 27, '2023-05-09 00:25:00', '2023-05-11 04:33:31', 1);
INSERT INTO `role_menu` VALUES (122, 2, 9, '2023-05-09 00:25:00', '2023-05-11 04:33:31', 1);
INSERT INTO `role_menu` VALUES (123, 2, 10, '2023-05-09 00:25:00', '2023-05-11 04:33:31', 1);
INSERT INTO `role_menu` VALUES (124, 2, 28, '2023-05-09 00:25:00', '2023-05-11 04:33:31', 1);
INSERT INTO `role_menu` VALUES (125, 2, 29, '2023-05-09 00:25:00', '2023-05-11 04:33:31', 1);
INSERT INTO `role_menu` VALUES (126, 2, 30, '2023-05-09 00:25:00', '2023-05-11 04:33:31', 1);
INSERT INTO `role_menu` VALUES (127, 2, 32, '2023-05-09 00:25:00', '2023-05-11 04:33:31', 1);
INSERT INTO `role_menu` VALUES (128, 2, 33, '2023-05-09 00:25:00', '2023-05-11 04:33:31', 1);
INSERT INTO `role_menu` VALUES (129, 2, 11, '2023-05-09 00:25:00', '2023-05-11 04:33:31', 1);
INSERT INTO `role_menu` VALUES (130, 2, 36, '2023-05-09 00:25:00', '2023-05-11 04:33:31', 1);
INSERT INTO `role_menu` VALUES (131, 2, 37, '2023-05-09 00:25:00', '2023-05-11 04:33:31', 1);
INSERT INTO `role_menu` VALUES (132, 2, 38, '2023-05-09 00:25:00', '2023-05-11 04:33:31', 1);
INSERT INTO `role_menu` VALUES (133, 2, 39, '2023-05-09 00:25:00', '2023-05-11 04:33:31', 1);
INSERT INTO `role_menu` VALUES (134, 2, 40, '2023-05-09 00:25:00', '2023-05-11 04:33:31', 1);
INSERT INTO `role_menu` VALUES (135, 2, 12, '2023-05-09 00:25:00', '2023-05-11 04:33:31', 1);
INSERT INTO `role_menu` VALUES (136, 2, 13, '2023-05-09 00:25:00', '2023-05-11 04:33:31', 1);
INSERT INTO `role_menu` VALUES (137, 2, 14, '2023-05-09 00:25:00', '2023-05-11 04:33:31', 1);
INSERT INTO `role_menu` VALUES (138, 2, 15, '2023-05-09 00:25:00', '2023-05-11 04:33:31', 1);
INSERT INTO `role_menu` VALUES (139, 2, 34, '2023-05-09 00:25:00', '2023-05-11 04:33:31', 1);
INSERT INTO `role_menu` VALUES (140, 2, 35, '2023-05-09 00:25:00', '2023-05-11 04:33:31', 1);
INSERT INTO `role_menu` VALUES (141, 2, 41, '2023-05-09 00:25:00', '2023-05-11 04:33:31', 1);
INSERT INTO `role_menu` VALUES (142, 2, 17, '2023-05-09 00:25:00', '2023-05-11 04:33:31', 1);
INSERT INTO `role_menu` VALUES (143, 2, 19, '2023-05-09 00:25:00', '2023-05-11 04:33:31', 1);
INSERT INTO `role_menu` VALUES (144, 2, 20, '2023-05-09 00:25:00', '2023-05-11 04:33:31', 1);
INSERT INTO `role_menu` VALUES (145, 2, 44, '2023-05-09 00:25:00', '2023-05-11 04:33:31', 1);
INSERT INTO `role_menu` VALUES (146, 2, 45, '2023-05-09 00:25:00', '2023-05-11 04:33:31', 1);
INSERT INTO `role_menu` VALUES (147, 2, 46, '2023-05-09 00:25:00', '2023-05-11 04:33:31', 1);
INSERT INTO `role_menu` VALUES (148, 2, 21, '2023-05-09 00:25:00', '2023-05-11 04:33:31', 1);
INSERT INTO `role_menu` VALUES (149, 2, 42, '2023-05-09 00:25:00', '2023-05-11 04:33:31', 1);
INSERT INTO `role_menu` VALUES (150, 2, 43, '2023-05-09 00:25:00', '2023-05-11 04:33:31', 1);
INSERT INTO `role_menu` VALUES (151, 2, 22, '2023-05-09 00:25:00', '2023-05-11 04:33:31', 1);
INSERT INTO `role_menu` VALUES (152, 2, 23, '2023-05-09 00:25:00', '2023-05-11 04:33:31', 1);
INSERT INTO `role_menu` VALUES (153, 2, 24, '2023-05-09 00:25:00', '2023-05-11 04:33:31', 1);
INSERT INTO `role_menu` VALUES (154, 2, 25, '2023-05-09 00:25:00', '2023-05-11 04:33:31', 1);
INSERT INTO `role_menu` VALUES (155, 2, 26, '2023-05-09 00:25:00', '2023-05-11 04:33:31', 1);
INSERT INTO `role_menu` VALUES (156, 2, 1, '2023-05-11 04:33:31', '2023-05-11 04:34:52', 1);
INSERT INTO `role_menu` VALUES (157, 2, 2, '2023-05-11 04:33:31', '2023-05-11 04:34:52', 1);
INSERT INTO `role_menu` VALUES (158, 2, 5, '2023-05-11 04:33:31', '2023-05-11 04:34:52', 1);
INSERT INTO `role_menu` VALUES (159, 2, 6, '2023-05-11 04:33:31', '2023-05-11 04:34:52', 1);
INSERT INTO `role_menu` VALUES (160, 2, 7, '2023-05-11 04:33:31', '2023-05-11 04:34:52', 1);
INSERT INTO `role_menu` VALUES (161, 2, 27, '2023-05-11 04:33:31', '2023-05-11 04:34:52', 1);
INSERT INTO `role_menu` VALUES (162, 2, 9, '2023-05-11 04:33:31', '2023-05-11 04:34:52', 1);
INSERT INTO `role_menu` VALUES (163, 2, 10, '2023-05-11 04:33:31', '2023-05-11 04:34:52', 1);
INSERT INTO `role_menu` VALUES (164, 2, 28, '2023-05-11 04:33:31', '2023-05-11 04:34:52', 1);
INSERT INTO `role_menu` VALUES (165, 2, 29, '2023-05-11 04:33:31', '2023-05-11 04:34:52', 1);
INSERT INTO `role_menu` VALUES (166, 2, 30, '2023-05-11 04:33:31', '2023-05-11 04:34:52', 1);
INSERT INTO `role_menu` VALUES (167, 2, 32, '2023-05-11 04:33:31', '2023-05-11 04:34:52', 1);
INSERT INTO `role_menu` VALUES (168, 2, 33, '2023-05-11 04:33:31', '2023-05-11 04:34:52', 1);
INSERT INTO `role_menu` VALUES (169, 2, 11, '2023-05-11 04:33:31', '2023-05-11 04:34:52', 1);
INSERT INTO `role_menu` VALUES (170, 2, 36, '2023-05-11 04:33:31', '2023-05-11 04:34:52', 1);
INSERT INTO `role_menu` VALUES (171, 2, 37, '2023-05-11 04:33:31', '2023-05-11 04:34:52', 1);
INSERT INTO `role_menu` VALUES (172, 2, 38, '2023-05-11 04:33:31', '2023-05-11 04:34:52', 1);
INSERT INTO `role_menu` VALUES (173, 2, 39, '2023-05-11 04:33:31', '2023-05-11 04:34:52', 1);
INSERT INTO `role_menu` VALUES (174, 2, 40, '2023-05-11 04:33:31', '2023-05-11 04:34:52', 1);
INSERT INTO `role_menu` VALUES (175, 2, 12, '2023-05-11 04:33:31', '2023-05-11 04:34:52', 1);
INSERT INTO `role_menu` VALUES (176, 2, 13, '2023-05-11 04:33:31', '2023-05-11 04:34:52', 1);
INSERT INTO `role_menu` VALUES (177, 2, 14, '2023-05-11 04:33:31', '2023-05-11 04:34:52', 1);
INSERT INTO `role_menu` VALUES (178, 2, 15, '2023-05-11 04:33:31', '2023-05-11 04:34:52', 1);
INSERT INTO `role_menu` VALUES (179, 2, 34, '2023-05-11 04:33:31', '2023-05-11 04:34:52', 1);
INSERT INTO `role_menu` VALUES (180, 2, 35, '2023-05-11 04:33:31', '2023-05-11 04:34:52', 1);
INSERT INTO `role_menu` VALUES (181, 2, 41, '2023-05-11 04:33:31', '2023-05-11 04:34:52', 1);
INSERT INTO `role_menu` VALUES (182, 2, 17, '2023-05-11 04:33:31', '2023-05-11 04:34:52', 1);
INSERT INTO `role_menu` VALUES (183, 2, 19, '2023-05-11 04:33:31', '2023-05-11 04:34:52', 1);
INSERT INTO `role_menu` VALUES (184, 2, 47, '2023-05-11 04:33:31', '2023-05-11 04:34:52', 1);
INSERT INTO `role_menu` VALUES (185, 2, 48, '2023-05-11 04:33:31', '2023-05-11 04:34:52', 1);
INSERT INTO `role_menu` VALUES (186, 2, 20, '2023-05-11 04:33:31', '2023-05-11 04:34:52', 1);
INSERT INTO `role_menu` VALUES (187, 2, 44, '2023-05-11 04:33:31', '2023-05-11 04:34:52', 1);
INSERT INTO `role_menu` VALUES (188, 2, 45, '2023-05-11 04:33:31', '2023-05-11 04:34:52', 1);
INSERT INTO `role_menu` VALUES (189, 2, 46, '2023-05-11 04:33:31', '2023-05-11 04:34:52', 1);
INSERT INTO `role_menu` VALUES (190, 2, 21, '2023-05-11 04:33:31', '2023-05-11 04:34:52', 1);
INSERT INTO `role_menu` VALUES (191, 2, 42, '2023-05-11 04:33:31', '2023-05-11 04:34:52', 1);
INSERT INTO `role_menu` VALUES (192, 2, 43, '2023-05-11 04:33:31', '2023-05-11 04:34:52', 1);
INSERT INTO `role_menu` VALUES (193, 2, 22, '2023-05-11 04:33:31', '2023-05-11 04:34:52', 1);
INSERT INTO `role_menu` VALUES (194, 2, 23, '2023-05-11 04:33:31', '2023-05-11 04:34:52', 1);
INSERT INTO `role_menu` VALUES (195, 2, 24, '2023-05-11 04:33:31', '2023-05-11 04:34:52', 1);
INSERT INTO `role_menu` VALUES (196, 2, 49, '2023-05-11 04:33:31', '2023-05-11 04:34:52', 1);
INSERT INTO `role_menu` VALUES (197, 2, 50, '2023-05-11 04:33:31', '2023-05-11 04:34:52', 1);
INSERT INTO `role_menu` VALUES (198, 2, 51, '2023-05-11 04:33:31', '2023-05-11 04:34:52', 1);
INSERT INTO `role_menu` VALUES (199, 2, 52, '2023-05-11 04:33:31', '2023-05-11 04:34:52', 1);
INSERT INTO `role_menu` VALUES (200, 2, 53, '2023-05-11 04:33:31', '2023-05-11 04:34:52', 1);
INSERT INTO `role_menu` VALUES (201, 2, 54, '2023-05-11 04:33:31', '2023-05-11 04:34:52', 1);
INSERT INTO `role_menu` VALUES (202, 2, 25, '2023-05-11 04:33:31', '2023-05-11 04:34:52', 1);
INSERT INTO `role_menu` VALUES (203, 2, 26, '2023-05-11 04:33:31', '2023-05-11 04:34:52', 1);
INSERT INTO `role_menu` VALUES (204, 2, 9, '2023-05-11 04:34:52', '2023-05-19 17:04:37', 1);
INSERT INTO `role_menu` VALUES (205, 2, 10, '2023-05-11 04:34:52', '2023-05-19 17:04:37', 1);
INSERT INTO `role_menu` VALUES (206, 2, 28, '2023-05-11 04:34:52', '2023-05-19 17:04:37', 1);
INSERT INTO `role_menu` VALUES (207, 2, 29, '2023-05-11 04:34:52', '2023-05-19 17:04:37', 1);
INSERT INTO `role_menu` VALUES (208, 2, 30, '2023-05-11 04:34:52', '2023-05-19 17:04:37', 1);
INSERT INTO `role_menu` VALUES (209, 2, 32, '2023-05-11 04:34:52', '2023-05-19 17:04:37', 1);
INSERT INTO `role_menu` VALUES (210, 2, 33, '2023-05-11 04:34:52', '2023-05-19 17:04:37', 1);
INSERT INTO `role_menu` VALUES (211, 2, 11, '2023-05-11 04:34:52', '2023-05-19 17:04:37', 1);
INSERT INTO `role_menu` VALUES (212, 2, 36, '2023-05-11 04:34:52', '2023-05-19 17:04:37', 1);
INSERT INTO `role_menu` VALUES (213, 2, 37, '2023-05-11 04:34:52', '2023-05-19 17:04:37', 1);
INSERT INTO `role_menu` VALUES (214, 2, 38, '2023-05-11 04:34:52', '2023-05-19 17:04:37', 1);
INSERT INTO `role_menu` VALUES (215, 2, 39, '2023-05-11 04:34:52', '2023-05-19 17:04:37', 1);
INSERT INTO `role_menu` VALUES (216, 2, 40, '2023-05-11 04:34:52', '2023-05-19 17:04:37', 1);
INSERT INTO `role_menu` VALUES (217, 2, 12, '2023-05-11 04:34:52', '2023-05-19 17:04:37', 1);
INSERT INTO `role_menu` VALUES (218, 2, 13, '2023-05-11 04:34:52', '2023-05-19 17:04:37', 1);
INSERT INTO `role_menu` VALUES (219, 2, 14, '2023-05-11 04:34:52', '2023-05-19 17:04:37', 1);
INSERT INTO `role_menu` VALUES (220, 2, 15, '2023-05-11 04:34:52', '2023-05-19 17:04:37', 1);
INSERT INTO `role_menu` VALUES (221, 2, 34, '2023-05-11 04:34:52', '2023-05-19 17:04:37', 1);
INSERT INTO `role_menu` VALUES (222, 2, 35, '2023-05-11 04:34:52', '2023-05-19 17:04:37', 1);
INSERT INTO `role_menu` VALUES (223, 2, 41, '2023-05-11 04:34:52', '2023-05-19 17:04:37', 1);
INSERT INTO `role_menu` VALUES (224, 2, 17, '2023-05-11 04:34:52', '2023-05-19 17:04:37', 1);
INSERT INTO `role_menu` VALUES (225, 2, 19, '2023-05-11 04:34:52', '2023-05-19 17:04:37', 1);
INSERT INTO `role_menu` VALUES (226, 2, 47, '2023-05-11 04:34:52', '2023-05-19 17:04:37', 1);
INSERT INTO `role_menu` VALUES (227, 2, 48, '2023-05-11 04:34:52', '2023-05-19 17:04:37', 1);
INSERT INTO `role_menu` VALUES (228, 2, 20, '2023-05-11 04:34:52', '2023-05-19 17:04:37', 1);
INSERT INTO `role_menu` VALUES (229, 2, 44, '2023-05-11 04:34:52', '2023-05-19 17:04:37', 1);
INSERT INTO `role_menu` VALUES (230, 2, 45, '2023-05-11 04:34:52', '2023-05-19 17:04:37', 1);
INSERT INTO `role_menu` VALUES (231, 2, 46, '2023-05-11 04:34:52', '2023-05-19 17:04:37', 1);
INSERT INTO `role_menu` VALUES (232, 2, 21, '2023-05-11 04:34:52', '2023-05-19 17:04:37', 1);
INSERT INTO `role_menu` VALUES (233, 2, 42, '2023-05-11 04:34:52', '2023-05-19 17:04:37', 1);
INSERT INTO `role_menu` VALUES (234, 2, 43, '2023-05-11 04:34:52', '2023-05-19 17:04:37', 1);
INSERT INTO `role_menu` VALUES (235, 2, 22, '2023-05-11 04:34:52', '2023-05-19 17:04:37', 1);
INSERT INTO `role_menu` VALUES (236, 2, 23, '2023-05-11 04:34:52', '2023-05-19 17:04:37', 1);
INSERT INTO `role_menu` VALUES (237, 2, 24, '2023-05-11 04:34:52', '2023-05-19 17:04:37', 1);
INSERT INTO `role_menu` VALUES (238, 2, 49, '2023-05-11 04:34:52', '2023-05-19 17:04:37', 1);
INSERT INTO `role_menu` VALUES (239, 2, 50, '2023-05-11 04:34:52', '2023-05-19 17:04:37', 1);
INSERT INTO `role_menu` VALUES (240, 2, 51, '2023-05-11 04:34:52', '2023-05-19 17:04:37', 1);
INSERT INTO `role_menu` VALUES (241, 2, 52, '2023-05-11 04:34:52', '2023-05-19 17:04:37', 1);
INSERT INTO `role_menu` VALUES (242, 2, 53, '2023-05-11 04:34:52', '2023-05-19 17:04:37', 1);
INSERT INTO `role_menu` VALUES (243, 2, 54, '2023-05-11 04:34:52', '2023-05-19 17:04:37', 1);
INSERT INTO `role_menu` VALUES (244, 2, 25, '2023-05-11 04:34:52', '2023-05-19 17:04:37', 1);
INSERT INTO `role_menu` VALUES (245, 2, 26, '2023-05-11 04:34:52', '2023-05-19 17:04:37', 1);
INSERT INTO `role_menu` VALUES (246, 3, 1, '2023-05-11 05:39:56', '2023-05-11 05:40:36', 1);
INSERT INTO `role_menu` VALUES (247, 3, 2, '2023-05-11 05:39:56', '2023-05-11 05:40:36', 1);
INSERT INTO `role_menu` VALUES (248, 3, 5, '2023-05-11 05:39:56', '2023-05-11 05:40:36', 1);
INSERT INTO `role_menu` VALUES (249, 3, 6, '2023-05-11 05:39:56', '2023-05-11 05:40:36', 1);
INSERT INTO `role_menu` VALUES (250, 3, 7, '2023-05-11 05:39:56', '2023-05-11 05:40:36', 1);
INSERT INTO `role_menu` VALUES (251, 3, 27, '2023-05-11 05:39:56', '2023-05-11 05:40:36', 1);
INSERT INTO `role_menu` VALUES (252, 3, 3, '2023-05-11 05:39:56', '2023-05-11 05:40:36', 1);
INSERT INTO `role_menu` VALUES (253, 3, 4, '2023-05-11 05:39:56', '2023-05-11 05:40:36', 1);
INSERT INTO `role_menu` VALUES (254, 3, 9, '2023-05-11 05:39:56', '2023-05-11 05:40:36', 1);
INSERT INTO `role_menu` VALUES (255, 3, 10, '2023-05-11 05:39:56', '2023-05-11 05:40:36', 1);
INSERT INTO `role_menu` VALUES (256, 3, 28, '2023-05-11 05:39:56', '2023-05-11 05:40:36', 1);
INSERT INTO `role_menu` VALUES (257, 3, 29, '2023-05-11 05:39:56', '2023-05-11 05:40:36', 1);
INSERT INTO `role_menu` VALUES (258, 3, 30, '2023-05-11 05:39:56', '2023-05-11 05:40:36', 1);
INSERT INTO `role_menu` VALUES (259, 3, 32, '2023-05-11 05:39:56', '2023-05-11 05:40:36', 1);
INSERT INTO `role_menu` VALUES (260, 3, 33, '2023-05-11 05:39:56', '2023-05-11 05:40:36', 1);
INSERT INTO `role_menu` VALUES (261, 3, 11, '2023-05-11 05:39:56', '2023-05-11 05:40:36', 1);
INSERT INTO `role_menu` VALUES (262, 3, 36, '2023-05-11 05:39:56', '2023-05-11 05:40:36', 1);
INSERT INTO `role_menu` VALUES (263, 3, 37, '2023-05-11 05:39:56', '2023-05-11 05:40:36', 1);
INSERT INTO `role_menu` VALUES (264, 3, 38, '2023-05-11 05:39:56', '2023-05-11 05:40:36', 1);
INSERT INTO `role_menu` VALUES (265, 3, 39, '2023-05-11 05:39:56', '2023-05-11 05:40:36', 1);
INSERT INTO `role_menu` VALUES (266, 3, 40, '2023-05-11 05:39:56', '2023-05-11 05:40:36', 1);
INSERT INTO `role_menu` VALUES (267, 3, 12, '2023-05-11 05:39:56', '2023-05-11 05:40:36', 1);
INSERT INTO `role_menu` VALUES (268, 3, 13, '2023-05-11 05:39:56', '2023-05-11 05:40:36', 1);
INSERT INTO `role_menu` VALUES (269, 3, 14, '2023-05-11 05:39:56', '2023-05-11 05:40:36', 1);
INSERT INTO `role_menu` VALUES (270, 3, 15, '2023-05-11 05:39:56', '2023-05-11 05:40:36', 1);
INSERT INTO `role_menu` VALUES (271, 3, 34, '2023-05-11 05:39:56', '2023-05-11 05:40:36', 1);
INSERT INTO `role_menu` VALUES (272, 3, 35, '2023-05-11 05:39:56', '2023-05-11 05:40:36', 1);
INSERT INTO `role_menu` VALUES (273, 3, 41, '2023-05-11 05:39:56', '2023-05-11 05:40:36', 1);
INSERT INTO `role_menu` VALUES (274, 3, 17, '2023-05-11 05:39:56', '2023-05-11 05:40:36', 1);
INSERT INTO `role_menu` VALUES (275, 3, 19, '2023-05-11 05:39:56', '2023-05-11 05:40:36', 1);
INSERT INTO `role_menu` VALUES (276, 3, 47, '2023-05-11 05:39:56', '2023-05-11 05:40:36', 1);
INSERT INTO `role_menu` VALUES (277, 3, 48, '2023-05-11 05:39:56', '2023-05-11 05:40:36', 1);
INSERT INTO `role_menu` VALUES (278, 3, 20, '2023-05-11 05:39:56', '2023-05-11 05:40:36', 1);
INSERT INTO `role_menu` VALUES (279, 3, 44, '2023-05-11 05:39:56', '2023-05-11 05:40:36', 1);
INSERT INTO `role_menu` VALUES (280, 3, 45, '2023-05-11 05:39:56', '2023-05-11 05:40:36', 1);
INSERT INTO `role_menu` VALUES (281, 3, 46, '2023-05-11 05:39:56', '2023-05-11 05:40:36', 1);
INSERT INTO `role_menu` VALUES (282, 3, 21, '2023-05-11 05:39:56', '2023-05-11 05:40:36', 1);
INSERT INTO `role_menu` VALUES (283, 3, 42, '2023-05-11 05:39:56', '2023-05-11 05:40:36', 1);
INSERT INTO `role_menu` VALUES (284, 3, 43, '2023-05-11 05:39:56', '2023-05-11 05:40:36', 1);
INSERT INTO `role_menu` VALUES (285, 3, 22, '2023-05-11 05:39:56', '2023-05-11 05:40:36', 1);
INSERT INTO `role_menu` VALUES (286, 3, 23, '2023-05-11 05:39:56', '2023-05-11 05:40:36', 1);
INSERT INTO `role_menu` VALUES (287, 3, 55, '2023-05-11 05:39:56', '2023-05-11 05:40:36', 1);
INSERT INTO `role_menu` VALUES (288, 3, 56, '2023-05-11 05:39:56', '2023-05-11 05:40:36', 1);
INSERT INTO `role_menu` VALUES (289, 3, 24, '2023-05-11 05:39:56', '2023-05-11 05:40:36', 1);
INSERT INTO `role_menu` VALUES (290, 3, 49, '2023-05-11 05:39:56', '2023-05-11 05:40:36', 1);
INSERT INTO `role_menu` VALUES (291, 3, 50, '2023-05-11 05:39:56', '2023-05-11 05:40:36', 1);
INSERT INTO `role_menu` VALUES (292, 3, 51, '2023-05-11 05:39:56', '2023-05-11 05:40:36', 1);
INSERT INTO `role_menu` VALUES (293, 3, 52, '2023-05-11 05:39:56', '2023-05-11 05:40:36', 1);
INSERT INTO `role_menu` VALUES (294, 3, 53, '2023-05-11 05:39:56', '2023-05-11 05:40:36', 1);
INSERT INTO `role_menu` VALUES (295, 3, 54, '2023-05-11 05:39:56', '2023-05-11 05:40:36', 1);
INSERT INTO `role_menu` VALUES (296, 3, 25, '2023-05-11 05:39:56', '2023-05-11 05:40:36', 1);
INSERT INTO `role_menu` VALUES (297, 3, 26, '2023-05-11 05:39:56', '2023-05-11 05:40:36', 1);
INSERT INTO `role_menu` VALUES (298, 3, 1, '2023-05-11 06:29:33', '2023-05-11 06:30:13', 1);
INSERT INTO `role_menu` VALUES (299, 3, 2, '2023-05-11 06:29:33', '2023-05-11 06:30:13', 1);
INSERT INTO `role_menu` VALUES (300, 3, 5, '2023-05-11 06:29:33', '2023-05-11 06:30:13', 1);
INSERT INTO `role_menu` VALUES (301, 3, 6, '2023-05-11 06:29:33', '2023-05-11 06:30:13', 1);
INSERT INTO `role_menu` VALUES (302, 3, 7, '2023-05-11 06:29:33', '2023-05-11 06:30:13', 1);
INSERT INTO `role_menu` VALUES (303, 3, 27, '2023-05-11 06:29:33', '2023-05-11 06:30:13', 1);
INSERT INTO `role_menu` VALUES (304, 3, 3, '2023-05-11 06:29:33', '2023-05-11 06:30:13', 1);
INSERT INTO `role_menu` VALUES (305, 3, 4, '2023-05-11 06:29:33', '2023-05-11 06:30:13', 1);
INSERT INTO `role_menu` VALUES (306, 3, 9, '2023-05-11 06:29:33', '2023-05-11 06:30:13', 1);
INSERT INTO `role_menu` VALUES (307, 3, 10, '2023-05-11 06:29:33', '2023-05-11 06:30:13', 1);
INSERT INTO `role_menu` VALUES (308, 3, 28, '2023-05-11 06:29:33', '2023-05-11 06:30:13', 1);
INSERT INTO `role_menu` VALUES (309, 3, 29, '2023-05-11 06:29:33', '2023-05-11 06:30:13', 1);
INSERT INTO `role_menu` VALUES (310, 3, 30, '2023-05-11 06:29:33', '2023-05-11 06:30:13', 1);
INSERT INTO `role_menu` VALUES (311, 3, 32, '2023-05-11 06:29:33', '2023-05-11 06:30:13', 1);
INSERT INTO `role_menu` VALUES (312, 3, 33, '2023-05-11 06:29:33', '2023-05-11 06:30:13', 1);
INSERT INTO `role_menu` VALUES (313, 3, 11, '2023-05-11 06:29:33', '2023-05-11 06:30:13', 1);
INSERT INTO `role_menu` VALUES (314, 3, 36, '2023-05-11 06:29:33', '2023-05-11 06:30:13', 1);
INSERT INTO `role_menu` VALUES (315, 3, 37, '2023-05-11 06:29:33', '2023-05-11 06:30:13', 1);
INSERT INTO `role_menu` VALUES (316, 3, 38, '2023-05-11 06:29:33', '2023-05-11 06:30:13', 1);
INSERT INTO `role_menu` VALUES (317, 3, 39, '2023-05-11 06:29:33', '2023-05-11 06:30:13', 1);
INSERT INTO `role_menu` VALUES (318, 3, 40, '2023-05-11 06:29:33', '2023-05-11 06:30:13', 1);
INSERT INTO `role_menu` VALUES (319, 3, 12, '2023-05-11 06:29:33', '2023-05-11 06:30:13', 1);
INSERT INTO `role_menu` VALUES (320, 3, 13, '2023-05-11 06:29:33', '2023-05-11 06:30:13', 1);
INSERT INTO `role_menu` VALUES (321, 3, 14, '2023-05-11 06:29:33', '2023-05-11 06:30:13', 1);
INSERT INTO `role_menu` VALUES (322, 3, 15, '2023-05-11 06:29:33', '2023-05-11 06:30:13', 1);
INSERT INTO `role_menu` VALUES (323, 3, 34, '2023-05-11 06:29:33', '2023-05-11 06:30:13', 1);
INSERT INTO `role_menu` VALUES (324, 3, 35, '2023-05-11 06:29:33', '2023-05-11 06:30:13', 1);
INSERT INTO `role_menu` VALUES (325, 3, 41, '2023-05-11 06:29:33', '2023-05-11 06:30:13', 1);
INSERT INTO `role_menu` VALUES (326, 3, 17, '2023-05-12 14:52:20', '2023-05-12 14:52:20', 0);
INSERT INTO `role_menu` VALUES (327, 3, 20, '2023-05-12 14:52:20', '2023-05-12 14:52:20', 0);
INSERT INTO `role_menu` VALUES (328, 3, 44, '2023-05-12 14:52:20', '2023-05-12 14:52:20', 0);
INSERT INTO `role_menu` VALUES (329, 3, 45, '2023-05-12 14:52:20', '2023-05-12 14:52:20', 0);
INSERT INTO `role_menu` VALUES (330, 3, 46, '2023-05-12 14:52:20', '2023-05-12 14:52:20', 0);
INSERT INTO `role_menu` VALUES (331, 3, 21, '2023-05-12 14:52:20', '2023-05-12 14:52:20', 0);
INSERT INTO `role_menu` VALUES (332, 3, 22, '2023-05-12 14:52:20', '2023-05-12 14:52:20', 0);
INSERT INTO `role_menu` VALUES (333, 3, 54, '2023-05-12 14:52:20', '2023-05-12 14:52:20', 0);
INSERT INTO `role_menu` VALUES (334, 3, 25, '2023-05-12 14:52:20', '2023-05-12 14:52:20', 0);
INSERT INTO `role_menu` VALUES (335, 3, 26, '2023-05-12 14:52:20', '2023-05-12 14:52:20', 0);
INSERT INTO `role_menu` VALUES (336, 1, 1, '2023-05-12 19:40:22', '2023-05-12 19:40:22', 0);
INSERT INTO `role_menu` VALUES (337, 1, 2, '2023-05-12 19:40:22', '2023-05-12 19:40:22', 0);
INSERT INTO `role_menu` VALUES (338, 1, 5, '2023-05-12 19:40:22', '2023-05-12 19:40:22', 0);
INSERT INTO `role_menu` VALUES (339, 1, 6, '2023-05-12 19:40:22', '2023-05-12 19:40:22', 0);
INSERT INTO `role_menu` VALUES (340, 1, 7, '2023-05-12 19:40:22', '2023-05-12 19:40:22', 0);
INSERT INTO `role_menu` VALUES (341, 1, 27, '2023-05-12 19:40:22', '2023-05-12 19:40:22', 0);
INSERT INTO `role_menu` VALUES (342, 1, 3, '2023-05-12 19:40:22', '2023-05-12 19:40:22', 0);
INSERT INTO `role_menu` VALUES (343, 1, 4, '2023-05-12 19:40:22', '2023-05-12 19:40:22', 0);
INSERT INTO `role_menu` VALUES (344, 1, 9, '2023-05-12 19:40:22', '2023-05-12 19:40:22', 0);
INSERT INTO `role_menu` VALUES (345, 1, 10, '2023-05-12 19:40:22', '2023-05-12 19:40:22', 0);
INSERT INTO `role_menu` VALUES (346, 1, 28, '2023-05-12 19:40:22', '2023-05-12 19:40:22', 0);
INSERT INTO `role_menu` VALUES (347, 1, 29, '2023-05-12 19:40:22', '2023-05-12 19:40:22', 0);
INSERT INTO `role_menu` VALUES (348, 1, 30, '2023-05-12 19:40:22', '2023-05-12 19:40:22', 0);
INSERT INTO `role_menu` VALUES (349, 1, 32, '2023-05-12 19:40:22', '2023-05-12 19:40:22', 0);
INSERT INTO `role_menu` VALUES (350, 1, 33, '2023-05-12 19:40:22', '2023-05-12 19:40:22', 0);
INSERT INTO `role_menu` VALUES (351, 1, 11, '2023-05-12 19:40:22', '2023-05-12 19:40:22', 0);
INSERT INTO `role_menu` VALUES (352, 1, 36, '2023-05-12 19:40:22', '2023-05-12 19:40:22', 0);
INSERT INTO `role_menu` VALUES (353, 1, 37, '2023-05-12 19:40:22', '2023-05-12 19:40:22', 0);
INSERT INTO `role_menu` VALUES (354, 1, 38, '2023-05-12 19:40:22', '2023-05-12 19:40:22', 0);
INSERT INTO `role_menu` VALUES (355, 1, 39, '2023-05-12 19:40:22', '2023-05-12 19:40:22', 0);
INSERT INTO `role_menu` VALUES (356, 1, 40, '2023-05-12 19:40:22', '2023-05-12 19:40:22', 0);
INSERT INTO `role_menu` VALUES (357, 1, 12, '2023-05-12 19:40:22', '2023-05-12 19:40:22', 0);
INSERT INTO `role_menu` VALUES (358, 1, 13, '2023-05-12 19:40:22', '2023-05-12 19:40:22', 0);
INSERT INTO `role_menu` VALUES (359, 1, 14, '2023-05-12 19:40:22', '2023-05-12 19:40:22', 0);
INSERT INTO `role_menu` VALUES (360, 1, 15, '2023-05-12 19:40:22', '2023-05-12 19:40:22', 0);
INSERT INTO `role_menu` VALUES (361, 1, 34, '2023-05-12 19:40:22', '2023-05-12 19:40:22', 0);
INSERT INTO `role_menu` VALUES (362, 1, 35, '2023-05-12 19:40:22', '2023-05-12 19:40:22', 0);
INSERT INTO `role_menu` VALUES (363, 1, 41, '2023-05-12 19:40:22', '2023-05-12 19:40:22', 0);
INSERT INTO `role_menu` VALUES (364, 1, 17, '2023-05-12 19:40:22', '2023-05-12 19:40:22', 0);
INSERT INTO `role_menu` VALUES (365, 1, 19, '2023-05-12 19:40:22', '2023-05-12 19:40:22', 0);
INSERT INTO `role_menu` VALUES (366, 1, 47, '2023-05-12 19:40:22', '2023-05-12 19:40:22', 0);
INSERT INTO `role_menu` VALUES (367, 1, 48, '2023-05-12 19:40:22', '2023-05-12 19:40:22', 0);
INSERT INTO `role_menu` VALUES (368, 1, 20, '2023-05-12 19:40:22', '2023-05-12 19:40:22', 0);
INSERT INTO `role_menu` VALUES (369, 1, 44, '2023-05-12 19:40:22', '2023-05-12 19:40:22', 0);
INSERT INTO `role_menu` VALUES (370, 1, 45, '2023-05-12 19:40:22', '2023-05-12 19:40:22', 0);
INSERT INTO `role_menu` VALUES (371, 1, 46, '2023-05-12 19:40:22', '2023-05-12 19:40:22', 0);
INSERT INTO `role_menu` VALUES (372, 1, 21, '2023-05-12 19:40:22', '2023-05-12 19:40:22', 0);
INSERT INTO `role_menu` VALUES (373, 1, 42, '2023-05-12 19:40:22', '2023-05-12 19:40:22', 0);
INSERT INTO `role_menu` VALUES (374, 1, 43, '2023-05-12 19:40:22', '2023-05-12 19:40:22', 0);
INSERT INTO `role_menu` VALUES (375, 1, 22, '2023-05-12 19:40:22', '2023-05-12 19:40:22', 0);
INSERT INTO `role_menu` VALUES (376, 1, 23, '2023-05-12 19:40:22', '2023-05-12 19:40:22', 0);
INSERT INTO `role_menu` VALUES (377, 1, 55, '2023-05-12 19:40:22', '2023-05-12 19:40:22', 0);
INSERT INTO `role_menu` VALUES (378, 1, 56, '2023-05-12 19:40:22', '2023-05-12 19:40:22', 0);
INSERT INTO `role_menu` VALUES (379, 1, 24, '2023-05-12 19:40:22', '2023-05-12 19:40:22', 0);
INSERT INTO `role_menu` VALUES (380, 1, 49, '2023-05-12 19:40:22', '2023-05-12 19:40:22', 0);
INSERT INTO `role_menu` VALUES (381, 1, 50, '2023-05-12 19:40:22', '2023-05-12 19:40:22', 0);
INSERT INTO `role_menu` VALUES (382, 1, 51, '2023-05-12 19:40:22', '2023-05-12 19:40:22', 0);
INSERT INTO `role_menu` VALUES (383, 1, 52, '2023-05-12 19:40:22', '2023-05-12 19:40:22', 0);
INSERT INTO `role_menu` VALUES (384, 1, 53, '2023-05-12 19:40:22', '2023-05-12 19:40:22', 0);
INSERT INTO `role_menu` VALUES (385, 1, 54, '2023-05-12 19:40:22', '2023-05-12 19:40:22', 0);
INSERT INTO `role_menu` VALUES (386, 1, 25, '2023-05-12 19:40:22', '2023-05-12 19:40:22', 0);
INSERT INTO `role_menu` VALUES (387, 1, 26, '2023-05-12 19:40:22', '2023-05-12 19:40:22', 0);
INSERT INTO `role_menu` VALUES (388, 2, 9, '2023-05-19 17:04:37', '2023-05-19 17:04:37', 0);
INSERT INTO `role_menu` VALUES (389, 2, 10, '2023-05-19 17:04:37', '2023-05-19 17:04:37', 0);
INSERT INTO `role_menu` VALUES (390, 2, 28, '2023-05-19 17:04:37', '2023-05-19 17:04:37', 0);
INSERT INTO `role_menu` VALUES (391, 2, 29, '2023-05-19 17:04:37', '2023-05-19 17:04:37', 0);
INSERT INTO `role_menu` VALUES (392, 2, 30, '2023-05-19 17:04:37', '2023-05-19 17:04:37', 0);
INSERT INTO `role_menu` VALUES (393, 2, 32, '2023-05-19 17:04:37', '2023-05-19 17:04:37', 0);
INSERT INTO `role_menu` VALUES (394, 2, 33, '2023-05-19 17:04:37', '2023-05-19 17:04:37', 0);
INSERT INTO `role_menu` VALUES (395, 2, 11, '2023-05-19 17:04:37', '2023-05-19 17:04:37', 0);
INSERT INTO `role_menu` VALUES (396, 2, 36, '2023-05-19 17:04:37', '2023-05-19 17:04:37', 0);
INSERT INTO `role_menu` VALUES (397, 2, 37, '2023-05-19 17:04:37', '2023-05-19 17:04:37', 0);
INSERT INTO `role_menu` VALUES (398, 2, 38, '2023-05-19 17:04:37', '2023-05-19 17:04:37', 0);
INSERT INTO `role_menu` VALUES (399, 2, 39, '2023-05-19 17:04:37', '2023-05-19 17:04:37', 0);
INSERT INTO `role_menu` VALUES (400, 2, 40, '2023-05-19 17:04:37', '2023-05-19 17:04:37', 0);
INSERT INTO `role_menu` VALUES (401, 2, 12, '2023-05-19 17:04:37', '2023-05-19 17:04:37', 0);
INSERT INTO `role_menu` VALUES (402, 2, 13, '2023-05-19 17:04:37', '2023-05-19 17:04:37', 0);
INSERT INTO `role_menu` VALUES (403, 2, 14, '2023-05-19 17:04:37', '2023-05-19 17:04:37', 0);
INSERT INTO `role_menu` VALUES (404, 2, 15, '2023-05-19 17:04:37', '2023-05-19 17:04:37', 0);
INSERT INTO `role_menu` VALUES (405, 2, 34, '2023-05-19 17:04:37', '2023-05-19 17:04:37', 0);
INSERT INTO `role_menu` VALUES (406, 2, 35, '2023-05-19 17:04:37', '2023-05-19 17:04:37', 0);
INSERT INTO `role_menu` VALUES (407, 2, 41, '2023-05-19 17:04:37', '2023-05-19 17:04:37', 0);
INSERT INTO `role_menu` VALUES (408, 2, 17, '2023-05-19 17:04:37', '2023-05-19 17:04:37', 0);
INSERT INTO `role_menu` VALUES (409, 2, 19, '2023-05-19 17:04:37', '2023-05-19 17:04:37', 0);
INSERT INTO `role_menu` VALUES (410, 2, 47, '2023-05-19 17:04:37', '2023-05-19 17:04:37', 0);
INSERT INTO `role_menu` VALUES (411, 2, 48, '2023-05-19 17:04:37', '2023-05-19 17:04:37', 0);
INSERT INTO `role_menu` VALUES (412, 2, 20, '2023-05-19 17:04:37', '2023-05-19 17:04:37', 0);
INSERT INTO `role_menu` VALUES (413, 2, 44, '2023-05-19 17:04:37', '2023-05-19 17:04:37', 0);
INSERT INTO `role_menu` VALUES (414, 2, 45, '2023-05-19 17:04:37', '2023-05-19 17:04:37', 0);
INSERT INTO `role_menu` VALUES (415, 2, 46, '2023-05-19 17:04:37', '2023-05-19 17:04:37', 0);
INSERT INTO `role_menu` VALUES (416, 2, 21, '2023-05-19 17:04:37', '2023-05-19 17:04:37', 0);
INSERT INTO `role_menu` VALUES (417, 2, 42, '2023-05-19 17:04:37', '2023-05-19 17:04:37', 0);
INSERT INTO `role_menu` VALUES (418, 2, 43, '2023-05-19 17:04:37', '2023-05-19 17:04:37', 0);
INSERT INTO `role_menu` VALUES (419, 2, 22, '2023-05-19 17:04:37', '2023-05-19 17:04:37', 0);
INSERT INTO `role_menu` VALUES (420, 2, 23, '2023-05-19 17:04:37', '2023-05-19 17:04:37', 0);
INSERT INTO `role_menu` VALUES (421, 2, 55, '2023-05-19 17:04:37', '2023-05-19 17:04:37', 0);
INSERT INTO `role_menu` VALUES (422, 2, 56, '2023-05-19 17:04:37', '2023-05-19 17:04:37', 0);
INSERT INTO `role_menu` VALUES (423, 2, 24, '2023-05-19 17:04:37', '2023-05-19 17:04:37', 0);
INSERT INTO `role_menu` VALUES (424, 2, 49, '2023-05-19 17:04:37', '2023-05-19 17:04:37', 0);
INSERT INTO `role_menu` VALUES (425, 2, 50, '2023-05-19 17:04:37', '2023-05-19 17:04:37', 0);
INSERT INTO `role_menu` VALUES (426, 2, 51, '2023-05-19 17:04:37', '2023-05-19 17:04:37', 0);
INSERT INTO `role_menu` VALUES (427, 2, 52, '2023-05-19 17:04:37', '2023-05-19 17:04:37', 0);
INSERT INTO `role_menu` VALUES (428, 2, 53, '2023-05-19 17:04:37', '2023-05-19 17:04:37', 0);
INSERT INTO `role_menu` VALUES (429, 2, 54, '2023-05-19 17:04:37', '2023-05-19 17:04:37', 0);
INSERT INTO `role_menu` VALUES (430, 2, 25, '2023-05-19 17:04:37', '2023-05-19 17:04:37', 0);
INSERT INTO `role_menu` VALUES (431, 2, 26, '2023-05-19 17:04:37', '2023-05-19 17:04:37', 0);
INSERT INTO `role_menu` VALUES (432, 12, 9, '2023-05-20 00:14:43', '2023-05-20 00:14:43', 0);
INSERT INTO `role_menu` VALUES (433, 12, 10, '2023-05-20 00:14:43', '2023-05-20 00:14:43', 0);
INSERT INTO `role_menu` VALUES (434, 12, 28, '2023-05-20 00:14:43', '2023-05-20 00:14:43', 0);
INSERT INTO `role_menu` VALUES (435, 12, 29, '2023-05-20 00:14:43', '2023-05-20 00:14:43', 0);
INSERT INTO `role_menu` VALUES (436, 12, 30, '2023-05-20 00:14:43', '2023-05-20 00:14:43', 0);
INSERT INTO `role_menu` VALUES (437, 12, 32, '2023-05-20 00:14:43', '2023-05-20 00:14:43', 0);
INSERT INTO `role_menu` VALUES (438, 12, 33, '2023-05-20 00:14:43', '2023-05-20 00:14:43', 0);
INSERT INTO `role_menu` VALUES (439, 12, 11, '2023-05-20 00:14:43', '2023-05-20 00:14:43', 0);
INSERT INTO `role_menu` VALUES (440, 12, 36, '2023-05-20 00:14:43', '2023-05-20 00:14:43', 0);
INSERT INTO `role_menu` VALUES (441, 12, 37, '2023-05-20 00:14:43', '2023-05-20 00:14:43', 0);
INSERT INTO `role_menu` VALUES (442, 12, 38, '2023-05-20 00:14:43', '2023-05-20 00:14:43', 0);
INSERT INTO `role_menu` VALUES (443, 12, 39, '2023-05-20 00:14:43', '2023-05-20 00:14:43', 0);
INSERT INTO `role_menu` VALUES (444, 12, 40, '2023-05-20 00:14:43', '2023-05-20 00:14:43', 0);
INSERT INTO `role_menu` VALUES (445, 12, 12, '2023-05-20 00:14:43', '2023-05-20 00:14:43', 0);
INSERT INTO `role_menu` VALUES (446, 12, 13, '2023-05-20 00:14:43', '2023-05-20 00:14:43', 0);
INSERT INTO `role_menu` VALUES (447, 12, 14, '2023-05-20 00:14:43', '2023-05-20 00:14:43', 0);
INSERT INTO `role_menu` VALUES (448, 12, 15, '2023-05-20 00:14:43', '2023-05-20 00:14:43', 0);
INSERT INTO `role_menu` VALUES (449, 12, 34, '2023-05-20 00:14:43', '2023-05-20 00:14:43', 0);
INSERT INTO `role_menu` VALUES (450, 12, 35, '2023-05-20 00:14:43', '2023-05-20 00:14:43', 0);
INSERT INTO `role_menu` VALUES (451, 12, 41, '2023-05-20 00:14:43', '2023-05-20 00:14:43', 0);
INSERT INTO `role_menu` VALUES (452, 13, 9, '2023-05-20 00:36:32', '2023-05-20 00:36:32', 0);
INSERT INTO `role_menu` VALUES (453, 13, 10, '2023-05-20 00:36:32', '2023-05-20 00:36:32', 0);
INSERT INTO `role_menu` VALUES (454, 13, 28, '2023-05-20 00:36:32', '2023-05-20 00:36:32', 0);
INSERT INTO `role_menu` VALUES (455, 13, 29, '2023-05-20 00:36:32', '2023-05-20 00:36:32', 0);
INSERT INTO `role_menu` VALUES (456, 13, 30, '2023-05-20 00:36:32', '2023-05-20 00:36:32', 0);
INSERT INTO `role_menu` VALUES (457, 13, 32, '2023-05-20 00:36:32', '2023-05-20 00:36:32', 0);
INSERT INTO `role_menu` VALUES (458, 13, 33, '2023-05-20 00:36:32', '2023-05-20 00:36:32', 0);
INSERT INTO `role_menu` VALUES (459, 13, 11, '2023-05-20 00:36:32', '2023-05-20 00:36:32', 0);
INSERT INTO `role_menu` VALUES (460, 13, 36, '2023-05-20 00:36:32', '2023-05-20 00:36:32', 0);
INSERT INTO `role_menu` VALUES (461, 13, 37, '2023-05-20 00:36:32', '2023-05-20 00:36:32', 0);
INSERT INTO `role_menu` VALUES (462, 13, 38, '2023-05-20 00:36:32', '2023-05-20 00:36:32', 0);
INSERT INTO `role_menu` VALUES (463, 13, 39, '2023-05-20 00:36:32', '2023-05-20 00:36:32', 0);
INSERT INTO `role_menu` VALUES (464, 13, 40, '2023-05-20 00:36:32', '2023-05-20 00:36:32', 0);
INSERT INTO `role_menu` VALUES (465, 13, 12, '2023-05-20 00:36:32', '2023-05-20 00:36:32', 0);
INSERT INTO `role_menu` VALUES (466, 13, 13, '2023-05-20 00:36:32', '2023-05-20 00:36:32', 0);
INSERT INTO `role_menu` VALUES (467, 13, 14, '2023-05-20 00:36:32', '2023-05-20 00:36:32', 0);
INSERT INTO `role_menu` VALUES (468, 13, 15, '2023-05-20 00:36:32', '2023-05-20 00:36:32', 0);
INSERT INTO `role_menu` VALUES (469, 13, 34, '2023-05-20 00:36:32', '2023-05-20 00:36:32', 0);
INSERT INTO `role_menu` VALUES (470, 13, 35, '2023-05-20 00:36:32', '2023-05-20 00:36:32', 0);
INSERT INTO `role_menu` VALUES (471, 13, 41, '2023-05-20 00:36:32', '2023-05-20 00:36:32', 0);

-- ----------------------------
-- Table structure for salary
-- ----------------------------
DROP TABLE IF EXISTS `salary`;
CREATE TABLE `salary`  (
  `salary_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '工资账套编号',
  `salary_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '工资账套名称',
  `basic_salary` bigint(16) NULL DEFAULT NULL COMMENT '基本工资',
  `merit_pay` bigint(16) NULL DEFAULT NULL COMMENT '绩效工资',
  `allowance` bigint(16) NULL DEFAULT NULL COMMENT '补助补贴',
  `bonus` bigint(16) NULL DEFAULT NULL COMMENT '奖金',
  `finsurances` bigint(16) NULL DEFAULT NULL COMMENT '五险一金',
  `dept_id` bigint(16) NULL DEFAULT NULL COMMENT '部门编号',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_deleted` tinyint(3) NOT NULL DEFAULT 0 COMMENT '逻辑删除字段(0表示未删除，1表示已删除)',
  PRIMARY KEY (`salary_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of salary
-- ----------------------------
INSERT INTO `salary` VALUES ('1656020929000468482', '销售部账套', 3000, 2000, 300, 300, 1000, 4, '2023-05-10 03:38:51', '2023-05-10 15:01:06', 0);
INSERT INTO `salary` VALUES ('1656022530205405185', '行政部账套', 5000, 1000, 500, 500, 1000, 1, '2023-05-10 03:45:13', '2023-05-10 15:01:07', 0);
INSERT INTO `salary` VALUES ('1656456386494504962', '平台项目运营部', 1000, 1000, 1000, 1000, 1000, 6, '2023-05-11 08:29:12', '2023-05-20 00:24:39', 1);
INSERT INTO `salary` VALUES ('1659596160558379010', '平台项目运营部账套', 1000, 1000, 1000, 1000, 1000, 6, '2023-05-20 00:25:33', '2023-05-20 00:25:33', 0);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `user_id` bigint(16) NOT NULL AUTO_INCREMENT COMMENT '用户编号',
  `user_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码(默认密码为“工号”+“姓名首字母缩写”)',
  `work_id` bigint(16) NULL DEFAULT NULL COMMENT '工号(格式为“入职年份”+“部门编号”+“用户编号”)',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '真实姓名',
  `sex` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别',
  `birthday` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '出生日期',
  `address` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '家庭住址',
  `phone` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话号码',
  `email` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电子邮箱',
  `identification` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '身份证号',
  `entry_date` date NULL DEFAULT NULL COMMENT '入职日期',
  `work_time` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '出勤时间表',
  `leave_time` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '请假时间表',
  `head_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像地址',
  `dept_id` bigint(16) NULL DEFAULT NULL COMMENT '部门编号',
  `post_id` bigint(16) NULL DEFAULT NULL COMMENT '职位编号',
  `salary_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '工资账套id',
  `status` tinyint(3) NULL DEFAULT 1 COMMENT '状态字段(1表示可用，0表示停用)',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_deleted` tinyint(3) NOT NULL DEFAULT 0 COMMENT '逻辑删除字段(0表示未删除，1表示已删除)',
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE INDEX `user_name`(`user_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'test', 'fcea920f7412b5da7be0cf42b8c93759', 20230101, '测试', '男', '2000-01-01', '广东省广州市白云区', '19922223333', 'test@qq.com', '441234200001011234', '2023-01-01', '2023-05-02,2023-05-03,2023-05-04,2023-05-05,2023-05-06,2023-05-07,2023-05-09,2023-05-11,2023-05-12,2023-05-19,2023-05-20', '2023-01-03,2023-05-16,2023-05-17,2023-05-30,2023-05-31', NULL, 1, 1, '1656020929000468482', 1, '2023-04-16 14:39:40', '2023-05-20 00:42:42', 0);
INSERT INTO `user` VALUES (2, 'user', 'c33367701511b4f6020ec61ded352059', 20230102, '用户', '女', '2001-01-01', '广东省广州市', '13544445555', 'user@qq.com', '554321200101014321', '2023-02-01', '2023-05-06', '2023-05-23,2023-05-24,2023-05-25', NULL, 1, 2, '1656022530205405185', 1, '2023-04-16 14:41:15', '2023-05-09 23:41:07', 0);
INSERT INTO `user` VALUES (14, 'xmq', '976260ea67109b59063da48a7ee4536b', 20230414, '张三', '女', '1999-08-31', '广东省深圳市宝安区', '19955556666', 'xmq@qq.com', '442222199909016666', '2022-05-05', NULL, NULL, NULL, 4, 7, NULL, 1, '2023-04-24 19:28:11', '2023-05-19 17:27:58', 0);
INSERT INTO `user` VALUES (16, 'xml', 'c5ea12c13c4a58be961a5fc466192583', 20230615, '李四', '女', '2001-12-20', '广东省广州市天河区', '19911112222', 'xml@qq.com', '442001200112202001', '2023-04-24', '2023-05-12', NULL, NULL, 6, 15, '1656456386494504962', 1, '2023-04-25 21:03:06', '2023-05-12 20:52:43', 0);

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role`  (
  `ur_id` bigint(16) NOT NULL AUTO_INCREMENT COMMENT '用户角色关系编号',
  `user_id` bigint(16) NOT NULL DEFAULT 0 COMMENT '用户编号',
  `role_id` bigint(16) NOT NULL DEFAULT 0 COMMENT '角色编号',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_deleted` tinyint(3) NOT NULL DEFAULT 0 COMMENT '逻辑删除字段(0表示未删除，1表示已删除)',
  PRIMARY KEY (`ur_id`) USING BTREE,
  INDEX `idx_role_id`(`role_id`) USING BTREE,
  INDEX `idx_user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1659599560238903298 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES (1647872396372119553, 1, 1, '2023-04-17 15:59:29', '2023-04-17 15:59:29', 0);
INSERT INTO `user_role` VALUES (1647872396372119554, 1, 2, '2023-04-17 15:59:29', '2023-04-17 15:59:29', 0);
INSERT INTO `user_role` VALUES (1647872396372119555, 1, 3, '2023-04-17 15:59:29', '2023-04-17 15:59:29', 0);
INSERT INTO `user_role` VALUES (1650055711707578369, 2, 2, '2023-04-23 16:35:12', '2023-05-02 21:52:32', 1);
INSERT INTO `user_role` VALUES (1650848775158087682, 14, 3, '2023-04-25 21:06:33', '2023-05-11 06:10:24', 1);
INSERT INTO `user_role` VALUES (1650848787124436994, 16, 3, '2023-04-25 21:06:36', '2023-04-25 21:06:36', 0);
INSERT INTO `user_role` VALUES (1653397059730882562, 2, 2, '2023-05-02 21:52:32', '2023-05-02 21:52:32', 0);
INSERT INTO `user_role` VALUES (1656421454846013441, 14, 3, '2023-05-11 06:10:24', '2023-05-11 06:10:27', 1);
INSERT INTO `user_role` VALUES (1656421455286415361, 14, 2, '2023-05-11 06:10:24', '2023-05-11 06:10:27', 1);
INSERT INTO `user_role` VALUES (1656421467152101377, 14, 3, '2023-05-11 06:10:27', '2023-05-11 06:10:27', 0);
INSERT INTO `user_role` VALUES (1656428127081902082, 17, 8, '2023-05-11 06:36:55', '2023-05-11 06:36:55', 0);
INSERT INTO `user_role` VALUES (1659594454365843458, 18, 12, '2023-05-20 00:18:46', '2023-05-20 00:18:46', 0);
INSERT INTO `user_role` VALUES (1659599560238903297, 35, 13, '2023-05-20 00:39:03', '2023-05-20 00:39:03', 0);

SET FOREIGN_KEY_CHECKS = 1;
