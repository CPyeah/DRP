delete from t_user;

delete from t_data_dict;

delete from t_client;

delete from t_temi_client;

delete from t_table_id;

--��ʼ��ϵͳ����Ա
insert into t_user(user_id, user_name, password) values('root', 'ϵͳ����Ա', 'root123');

--��ʼ���������
insert into t_data_dict(id, name, category) values('a01', 'ҽ����е', 'C');
insert into t_data_dict(id, name, category) values('a02', '�г�ҩ', 'C');
insert into t_data_dict(id, name, category) values('a03', '��ҩ', 'C');

--��ʼ�����ϵ�λ
insert into t_data_dict(id, name, category) values('b01', '��', 'D');
insert into t_data_dict(id, name, category) values('b02', 'Ƭ', 'D');
insert into t_data_dict(id, name, category) values('b03', '��', 'D');

--��ʼ������������
insert into t_data_dict(id, name, category) values('c01', 'һ��������', 'A');
insert into t_data_dict(id, name, category) values('c02', '����������', 'A');
insert into t_data_dict(id, name, category) values('c03', '����������', 'A');
insert into t_data_dict(id, name, category) values('c04', '�ܲ�', 'A');

--��ʼ���ն˿ͻ�����
insert into t_data_dict(id, name, category) values('d01', '�׼�ҽԺ', 'B');
insert into t_data_dict(id, name, category) values('d02', '�Ҽ�ҽԺ', 'B');
insert into t_data_dict(id, name, category) values('d03', '����ҽԺ', 'B');
insert into t_data_dict(id, name, category) values('d04', 'ҩ��', 'B');
insert into t_data_dict(id, name, category) values('d05', '����', 'B');

--��ʼ��������
insert into t_client(id, pid, name, is_leaf, is_client) values(10000, 0, '���з�����', 'N', 'N');
insert into t_client(id, pid, name, is_leaf, is_client) values(10001, 10000, '������', 'N', 'N');
insert into t_client(id, pid, name, is_leaf, is_client) values(10002, 10001, '������', 'N', 'N');
insert into t_client(id, pid, name, is_leaf, is_client, client_level) values(10003, 10002, '����ҽҩ�ɷ����޹�˾', 'Y', 'Y', 'c01');

insert into t_client(id, pid, name, is_leaf, is_client) values(10004, 10000, '������', 'Y', 'N');
insert into t_client(id, pid, name, is_leaf, is_client) values(10005, 10000, '������', 'Y', 'N');

--��ʼ���ն˿ͻ�
insert into t_temi_client(id, pid, name, is_leaf, is_temi_client) values(20000, 0, '�����ն˿ͻ�', 'N', 'N');
insert into t_temi_client(id, pid, name, is_leaf, is_temi_client) values(20001, 20000, '������', 'N', 'N');
insert into t_temi_client(id, pid, name, is_leaf, is_temi_client) values(20002, 20001, '������', 'N', 'N');
insert into t_temi_client(id, pid, name, temi_client_id, is_leaf, is_temi_client, temi_client_category) values(20003, 20002, '������ҽҽԺ', 't0001','Y', 'Y', 'd01');

insert into t_temi_client(id, pid, name, is_leaf, is_temi_client) values(20004, 20000, '������', 'N', 'N');
insert into t_temi_client(id, pid, name, is_leaf, is_temi_client) values(20005, 20000, '������', 'N', 'N');

--��ʼ������ά����
insert into t_table_id(table_name, value) values('t_client', 10005);
insert into t_table_id(table_name, value) values('t_temi_client', 20005);
insert into t_table_id(table_name, value) values('t_flow_card_detail', 0);
insert into t_table_id ( table_name, value ) values ('t_fiscal_year_period', '0'); 
commit;