CREATE TABLE `tradelog`
(
    `id`         INT(11) NOT NULL,
    `tradeid`    VARCHAR(32) DEFAULT NULL,
    `operator`   INT(11)     DEFAULT NULL,
    `t_modified` DATETIME    DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `tradeid` (`tradeid`),
    KEY `t_modified` (`t_modified`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

CREATE TABLE `trade_detail` (
  `id` int(11) NOT NULL,
  `tradeid` varchar(32) DEFAULT NULL,
  `trade_step` int(11) DEFAULT NULL, /*操作步骤*/
  `step_info` varchar(32) DEFAULT NULL, /*步骤信息*/
  PRIMARY KEY (`id`),
  KEY `tradeid` (`tradeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

