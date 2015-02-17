/*==============================================================*/
/* DBMS name:      ORACLE Version 10g                           */
/* Created on:     2009-11-14 13:57:46                          */
/*==============================================================*/


drop view V_AIM_CLIENT;

drop table T_CLIENT cascade constraints;

drop table T_DATA_DICT cascade constraints;

drop table T_FISCAL_YEAR_PERIOD cascade constraints;

drop table T_FLOW_CARD_DETAIL cascade constraints;

drop table T_FLOW_CARD_MASTER cascade constraints;

drop table T_INVENTORY cascade constraints;

drop table T_ITEMS cascade constraints;

drop table T_TABLE_ID cascade constraints;

drop table T_TEMI_CLIENT cascade constraints;

drop table T_USER cascade constraints;

/*==============================================================*/
/* Table: T_CLIENT                                              */
/*==============================================================*/
create table T_CLIENT  (
   ID                   number(10)                      not null,
   PID                  number(10),
   CLIENT_LEVEL         char(3),
   NAME                 varchar2(40),
   CLIENT_ID            varchar2(10),
   BANK_ACCT_NO         varchar2(30),
   CONTACT_TEL          varchar2(30),
   ADDRESS              varchar2(50),
   ZIP_CODE             varchar2(15),
   IS_LEAF              char(1)                         not null,
   IS_CLIENT            char(1)                         not null,
   constraint PK_T_CLIENT primary key (ID)
);

comment on table T_CLIENT is
'��������Ϣ';

comment on column T_CLIENT.IS_LEAF is
'Y��Ҷ��
N����Ҷ��';

comment on column T_CLIENT.IS_CLIENT is
'Y���Ƿ�����
N�����Ƿ�����';

/*==============================================================*/
/* Table: T_DATA_DICT                                           */
/*==============================================================*/
create table T_DATA_DICT  (
   ID                   char(3)                         not null,
   NAME                 varchar2(30)                    not null,
   CATEGORY             char(1)                         not null,
   constraint PK_T_DATA_DICT primary key (ID)
);

comment on table T_DATA_DICT is
'�����ֵ�';

comment on column T_DATA_DICT.CATEGORY is
'A�������̼���
B���ն˿ͻ�����
C���������
D��������λ';

/*==============================================================*/
/* Table: T_FISCAL_YEAR_PERIOD                                  */
/*==============================================================*/
create table T_FISCAL_YEAR_PERIOD  (
   ID                   number(10)                      not null,
   FISCAL_YEAR          number(4)                       not null,
   FISCAL_PERIOD        number(2)                       not null,
   BEGIN_DATE           date                            not null,
   END_DATE             date                            not null,
   PERIOD_STS           char(1)                         not null,
   constraint PK_T_FISCAL_YEAR_PERIOD primary key (ID)
);

comment on table T_FISCAL_YEAR_PERIOD is
'��ƺ�����';

comment on column T_FISCAL_YEAR_PERIOD.PERIOD_STS is
'Y������ʹ��
N������ʹ��';

/*==============================================================*/
/* Table: T_FLOW_CARD_DETAIL                                    */
/*==============================================================*/
create table T_FLOW_CARD_DETAIL  (
   FLOW_CARD_DETAIL_ID  number(10)                      not null,
   AIM_CLIENT_ID        number(10)                      not null,
   ITEM_NO              varchar2(20)                    not null,
   FLOW_CARD_NO         varchar2(20),
   OPT_QTY              number(12,2)                   default 0 not null,
   ADJUST_QTY           number(12,2)                   default 0,
   ADJUST_REASON        varchar2(30),
   ADJUST_FLAG          char(1)                         not null,
   constraint PK_T_FLOW_CARD_DETAIL primary key (FLOW_CARD_DETAIL_ID)
);

comment on table T_FLOW_CARD_DETAIL is
'������ϸ��Ϣ';

comment on column T_FLOW_CARD_DETAIL.ADJUST_FLAG is
'Y������
N��δ����';

/*==============================================================*/
/* Table: T_FLOW_CARD_MASTER                                    */
/*==============================================================*/
create table T_FLOW_CARD_MASTER  (
   FLOW_CARD_NO         varchar2(20)                    not null,
   FISCAL_YEAR_PERIOD   number(10)                      not null,
   OPT_TYPE             char(1)                         not null,
   CLIENT_ID            number(10)                      not null,
   RECORDER_ID          varchar2(10)                    not null,
   OPT_DATE             date                            not null,
   VOU_STS              char(1)                         not null,
   ADJUSTER_ID          varchar2(10),
   ADJUST_DATE          date,
   SPOTTER_ID           varchar2(10),
   SPOT_DATE            date,
   SPOT_DESC            varchar2(40),
   CONFIRMER_ID         varchar2(10),
   CONF_DATE            date,
   constraint PK_T_FLOW_CARD_MASTER primary key (FLOW_CARD_NO)
);

comment on table T_FLOW_CARD_MASTER is
'��������Ϣ';

comment on column T_FLOW_CARD_MASTER.OPT_TYPE is
'D������
A���������̵㣩';

comment on column T_FLOW_CARD_MASTER.VOU_STS is
'S������
N��¼��';

/*==============================================================*/
/* Table: T_INVENTORY                                           */
/*==============================================================*/
create table T_INVENTORY  (
   CLIENT_ID            number(10)                      not null,
   FISCAL_YEAR_PERIOD_ID number(10)                      not null,
   ITEM_NO              varchar2(20)                    not null,
   INIT_QTY             number(12,2)                   default 0,
   IN_QTY               number(12,2)                   default 0,
   OUT_QTY              number(12,2)                   default 0,
   constraint PK_T_INVENTORY primary key (CLIENT_ID, FISCAL_YEAR_PERIOD_ID, ITEM_NO)
);

comment on table T_INVENTORY is
'�����Ϣ��̨����Ϣ��';

/*==============================================================*/
/* Table: T_ITEMS                                               */
/*==============================================================*/
create table T_ITEMS  (
   ITEM_NO              varchar2(20)                    not null,
   CATEGORY             char(3),
   UNIT                 char(3),
   ITEM_NAME            varchar2(30)                    not null,
   SPEC                 varchar2(30),
   PATTERN              varchar2(30),
   UPLOAD_FILE_NAME     varchar2(40),
   constraint PK_T_ITEMS primary key (ITEM_NO)
);

comment on table T_ITEMS is
'������Ϣ';

/*==============================================================*/
/* Table: T_TABLE_ID                                            */
/*==============================================================*/
create table T_TABLE_ID  (
   TABLE_NAME           varchar2(30)                    not null,
   VALUE                varchar2(20)                    not null,
   constraint PK_T_TABLE_ID primary key (TABLE_NAME)
);

comment on table T_TABLE_ID is
'����ά����';

/*==============================================================*/
/* Table: T_TEMI_CLIENT                                         */
/*==============================================================*/
create table T_TEMI_CLIENT  (
   ID                   number(10)                      not null,
   PID                  number(10),
   TEMI_CLIENT_CATEGORY char(3),
   NAME                 varchar2(40)                    not null,
   TEMI_CLIENT_ID       varchar2(10),
   CONTACTOR            varchar2(30),
   CONTATEL_TEL         varchar2(30),
   ADDRESS              varchar2(50),
   ZIP_CODE             varchar2(15),
   IS_LEAF              char(1)                         not null,
   IS_TEMI_CLIENT       char(1)                         not null,
   constraint PK_T_TEMI_CLIENT primary key (ID)
);

comment on table T_TEMI_CLIENT is
'�ն˿ͻ���Ϣ';

comment on column T_TEMI_CLIENT.IS_LEAF is
'Y��Ҷ��
N����Ҷ��';

comment on column T_TEMI_CLIENT.IS_TEMI_CLIENT is
'Y���ն�
N�������ն�';

/*==============================================================*/
/* Table: T_USER                                                */
/*==============================================================*/
create table T_USER  (
   USER_ID              varchar2(10)                    not null,
   USER_NAME            varchar2(40)                    not null,
   PASSWORD             varchar2(20)                    not null,
   CONTACT_TEL          varchar2(40),
   EMAIL                varchar2(30),
   CREATE_DATE          date,
   constraint PK_T_USER primary key (USER_ID)
);

comment on table T_USER is
'�û���Ϣ';

/*==============================================================*/
/* View: V_AIM_CLIENT                                           */
/*==============================================================*/
create or replace view V_AIM_CLIENT as
select c.id, c.name, c.client_id as client_temi_id, c.client_level as client_temi_category_id, d.name as client_temi_category_name from t_client c join t_data_dict d on c.client_level=d.id where is_client='Y'
union 
select t.id, t.name, t.temi_client_id as client_temi_id, t.temi_client_category as client_temi_category_id, d.name as client_temi_category_name from t_temi_client t join t_data_dict d on t.temi_client_category=d.id where is_temi_client='Y'
with read only;

 comment on table V_AIM_CLIENT is
'�跽�ͻ������������̺��ն˿ͻ�';

