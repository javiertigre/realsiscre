/*
create temp table uno as 
SELECT c.id_entidad,e.codigo,e.entidad,c.id_sistema,max(c.id_compatibilizacion)as id_compatibilizacion
FROM compatibilizacion c
     inner join entidad e ON e.id_entidad=c.id_entidad
--WHERE id_entidad=578
group by c.id_entidad,e.codigo,e.entidad,c.id_sistema
order by 1,2,3,4,5
----------------------
select * from uno
-----------------------
create temp table dos as
Select id_entidad,codigo,entidad,
case  
     when id_sistema=7 
     then   id_compatibilizacion
     else 0
end spo,
case  
     when id_sistema=5
     then   id_compatibilizacion
     else 0
end soa,
case  
     when id_sistema=6
     then   id_compatibilizacion
     else 0
end sp,
case  
     when id_sistema=2
     then   id_compatibilizacion
     else 0
end sap,
case  
     when id_sistema=1
     then   id_compatibilizacion
     else 0
end sabs,
case  
     when id_sistema=8
     then   id_compatibilizacion
     else 0
end st,
case  
     when id_sistema=4
     then   id_compatibilizacion
     else 0
end scp,

case  
     when id_sistema=3
     then   id_compatibilizacion
     else 0
end sci,
case  
     when id_sistema=10
     then   id_compatibilizacion
     else 0
end rce,
case  
     when id_sistema=9
     then   id_compatibilizacion
     else 0
end srip

from uno
-------------------
select * from dos
------------------

select id_entidad,codigo,entidad,max(spo) spo, max(soa) soa, max(sp) sp,max(sap) sap, max(sabs) sabs, max(st) st,max(scp) scp, max(sci) sci, max(rce) rce,max(srip)srip
from dos
group by id_entidad,codigo,entidad
*/
---------
create temp table tres as
select id_entidad,codigo,entidad,max(spo) spo, max(soa) soa, max(sp) sp,max(sap) sap, max(sabs) sabs, max(st) st,max(scp) scp, max(sci) sci, max(rce) rce,max(srip)srip
from dos 
    inner join super_entidad se ON se.id_super_entidad=id_super_entidad
group by id_entidad,codigo,entidad
*/

select * from tres


create temp table cuatro as
select id_entidad,codigo,entidad,max(spo) spo, max(soa) soa, max(sp) sp,max(sap) sap, max(sabs) sabs, max(st) st,max(scp) scp, max(sci) sci, max(rce) rce,max(srip)srip
from dos 
   
group by id_entidad,codigo,entidad

select * from cuatro