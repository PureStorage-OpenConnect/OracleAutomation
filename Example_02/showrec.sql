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
select instance_name ih, host_name ht from v$instance;

prompt Connected to Instance "&ih" on Host "&ht"
prompt
prompt Showing last 20 records
prompt

col inm heading 'Instance-Server' format a15
col nm heading 'Customer Name' format a15
col cdt heading 'Date created' format a17
select inm, nm,cdt from (
       select '&ih-&ht' inm, name nm, to_char(creation_date,'mm/dd/yy hh24:mi:ss') cdt,
               row_number() over (order by creation_date desc) rn
          from pure_demo )
  where rn <= 20
  order by rn desc;
col ct format a32 heading 'Record Count'
select 'Total number of records: '||count(*) ct from pure_demo;
prompt
prompt Database Size
@showspace
prompt
exit
