

ssh -l ${DB_HOST_USER_SRC} ${DB_HOST_SRC} sqlplus -s ${DB_USER_SRC}/${DB_PASS_SRC} << EOF
  
  set feed off

  delete from pure_demo;

  insert into pure_demo(name,cr_date) values ('Accelerate 2022',sysdate);
  commit;
  

set lines 100
set veri off
set feed off
set echo off
set pages 30
col ih noprint new_value ih
col ht noprint new_value ht


select instance_name ih, host_name ht from v\$instance;
prompt Connected to Instance "&ih" on Host "&ht"
prompt
prompt
col inm heading 'Instance-Server' format a40
col nm heading 'Customer Name' format a15
col cdt heading 'Date created' format a17
select inm, nm,cdt from (
       select '&ih-&ht' inm, name nm, to_char(cr_date,'mm/dd/yy hh24:mi:ss') cdt,
               row_number() over (order by cr_date desc) rn
          from pure_demo )
  where rn <= 20
  order by rn desc;


col msg format a50 heading 'Space Details'
select 'Allocated Space : '||to_char(sum(bytes)/1024/1024/1024,'9,999.99')||' GB' msg
  from dba_data_files
union all
select 'Used Space      : '||to_char(sum(bytes)/1024/1024/1024,'9,999.99')||' GB'  msg
  from dba_segments
/



  exit;
EOF


