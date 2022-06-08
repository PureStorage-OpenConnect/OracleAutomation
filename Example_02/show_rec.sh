
ssh -l ${DB_HOST_USER_TGT} ${DB_HOST_TGT} sqlplus -s ${DB_USER_TGT}/${DB_PASS_TGT} << EOF

alter session set nls_date_format='dd-Mon-yy hh24:mi:ss';
set lines 100
set veri off
set feed off
set echo off
set pages 30
col ih noprint new_value ih
col ht noprint new_value ht
col mxn noprint new_value mxn
select max(length(name)) mxn
  from pure_demo;
select instance_name ih, host_name ht from v\$instance;
prompt Connected to Instance "&ih" on Host "&ht"
prompt
prompt
col inm heading 'Instance-Server' format a60
col nm heading 'Customer Name' format a15
col cdt heading 'Date created' format a17
select inm, nm,cdt from (
       select '&ih-&ht' inm, name nm, to_char(cr_date,'mm/dd/yy hh24:mi:ss') cdt,
               row_number() over (order by cr_date desc) rn
          from pure_demo )
  where rn <= 20
  order by rn desc;
exit;
EOF 


