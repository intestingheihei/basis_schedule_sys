/*
任务信息表
 */
drop table IF EXISTS T_TASK;
create table IF NOT EXISTS T_TASK
(
  TASK_ID SERIAL8  PRIMARY KEY ,
  NAME VARCHAR(20),
  DES VARCHAR(500),
  TASKCLASSNAME VARCHAR(500),
  TYPE INT,
  ST INT,
  PARA VARCHAR(500),
  PRIOR NUMERIC(10),
  DAY NUMERIC(3),
  COST NUMERIC(19,6),
  AVG_COST NUMERIC(19,6)
)
;
COMMENT ON TABLE T_TASK IS '任务信息表';
COMMENT ON COLUMN T_TASK.TASK_ID IS '任务ID';
COMMENT ON COLUMN T_TASK.NAME IS '任务名称';
COMMENT ON COLUMN T_TASK.DES IS '任务描述';
COMMENT ON COLUMN T_TASK.TASKCLASSNAME IS '任务类名';
COMMENT ON COLUMN T_TASK.TYPE IS '任务类型';
COMMENT ON COLUMN T_TASK.ST IS '任务状态';
COMMENT ON COLUMN T_TASK.PARA IS '任务参数';
COMMENT ON COLUMN T_TASK.PRIOR IS '优先级';
COMMENT ON COLUMN T_TASK.DAY IS '每月执行/每周执行';
COMMENT ON COLUMN T_TASK.COST IS '任务代价';
COMMENT ON COLUMN T_TASK.AVG_COST IS '任务平均代价';



drop table IF EXISTS T_TASK_LIST;
create table IF NOT EXISTS T_TASK_LIST
(
  TASK_ID INTEGER,
  ST INT,
  T_DATE VARCHAR(8),
  BEG_TIME timestamp(0) without time zone,
  END_TIME timestamp(0) without time zone
);
COMMENT ON TABLE T_TASK_LIST IS '任务运行表';
COMMENT ON COLUMN T_TASK_LIST.TASK_ID IS '任务ID';
COMMENT ON COLUMN T_TASK_LIST.ST IS '任务状态';
COMMENT ON COLUMN T_TASK_LIST.T_DATE IS '任务日期（8位）';
COMMENT ON COLUMN T_TASK_LIST.BEG_TIME IS '任务开始时间';
COMMENT ON COLUMN T_TASK_LIST.END_TIME IS '任务结束时间';

alter table t_task_list add primary key (task_id,t_date);


drop table IF EXISTS T_DEP;
create table IF NOT EXISTS T_DEP
(
  TASK_ID INTEGER,
  PARENT_ID INTEGER
);
COMMENT ON TABLE T_DEP IS '任务依赖表';
COMMENT ON COLUMN T_DEP.TASK_ID IS '任务ID';
COMMENT ON COLUMN T_DEP.PARENT_ID IS '前置任务ID';

drop table IF EXISTS T_LOG;
create table IF NOT EXISTS T_LOG
(
  LOG_TIME timestamp(0) without time zone,
  TASK_ID INTEGER,
  LOG_LEVEL INT,
  LOG_TYPE INT,
  LOG_MSG TEXT
);

COMMENT ON TABLE T_LOG IS '任务日志表';
COMMENT ON COLUMN T_LOG.LOG_TIME IS '日志记录时间';
COMMENT ON COLUMN T_LOG.TASK_ID IS '任务ID';
COMMENT ON COLUMN T_LOG.LOG_LEVEL IS '日志级别';
COMMENT ON COLUMN T_LOG.LOG_TYPE IS '日志类型';
COMMENT ON COLUMN T_LOG.LOG_MSG IS '日志内容';

drop table IF EXISTS T_SESSION;
create table IF NOT EXISTS T_SESSION
(
  SESSION_ID VARCHAR(500),
  TASKS INTEGER,
  TOTAL_COST  NUMERIC(19,6),
  SESSION_DATE VARCHAR(8)
);

COMMENT ON TABLE T_SESSION IS '并发线程表';
COMMENT ON COLUMN T_SESSION.SESSION_ID IS '线程ID';
COMMENT ON COLUMN T_SESSION.TASKS IS '线程任务数';
COMMENT ON COLUMN T_SESSION.TOTAL_COST IS '线程总代价';
COMMENT ON COLUMN T_SESSION.SESSION_DATE IS '会话日期（8位）';

drop table IF EXISTS T_TASK_ST;
create table IF NOT EXISTS T_TASK_ST
(
  ST INT,
  DES VARCHAR(50)
);
COMMENT ON TABLE T_TASK_ST IS '任务状态表';
COMMENT ON COLUMN T_TASK_ST.ST IS '状态ID';
COMMENT ON COLUMN T_TASK_ST.DES IS '状态说明';

INSERT INTO T_TASK_ST VALUES
  (0,'必须执行'),
  (1,'可忽略，后续任务续行'),
  (2,'可忽略，后续任务不续行'),
  (3,'忽略，后续任务续行'),
  (4,'忽略，后续任务不续行')
;



drop table IF EXISTS T_TASK_TYPE;
create table IF NOT EXISTS T_TASK_TYPE
(
  TYPE INT,
  DES VARCHAR(50)
);
COMMENT ON TABLE T_TASK_TYPE IS '任务类型表';
COMMENT ON COLUMN T_TASK_TYPE.TYPE IS '类型ID';
COMMENT ON COLUMN T_TASK_TYPE.DES IS '类型说明';

INSERT INTO T_TASK_TYPE VALUES
(0,'每日执行'),
(1,'每周执行'),
(2,'每月执行'),
(3,'每年执行')
;







drop table IF EXISTS T_PARAM;
create table IF NOT EXISTS T_PARAM
(
  NAME VARCHAR(50),
  VALUE VARCHAR(50)
);
COMMENT ON TABLE T_PARAM IS '参数表';
COMMENT ON COLUMN T_PARAM.NAME IS '参数名';
COMMENT ON COLUMN T_PARAM.VALUE IS '参数值';
/*参数表参数：
  finish_date 20170724 调度日期，若上一日期未完成，则为上一日期
*/



































