--1. se elige la super entidad, la entidad , el sistema y el m{aximo id donde está ese sistema --> tabla temporal uno
/*
create temp table uno as
SELECT se.super_entidad,c.id_entidad,e.codigo,e.entidad,c.id_sistema,max(c.id_compatibilizacion)as id_compatibilizacion
FROM entidad e
     left join compatibilizacion c ON e.id_entidad=c.id_entidad
     inner join super_entidad se ON se.id_super_entidad=e.id_super_entidad
WHERE se.id_estado='1' and e.id_estado='1'
group by se.super_entidad,c.id_entidad,e.codigo,e.entidad,c.id_sistema
order by 1,2,3,4,5
*/
---------------
select * from uno
-------------
--2 por sistema pone en columnas el id de la tabla compatibilización, para jalar la letra posteriormente --> tabla temporal dos
/*
create temp table dos as
Select super_entidad,id_entidad,codigo,entidad,
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
*/
--3 se agrupa por sistema el id para jalar la letra posteriormente --> tabla temporal tres
/*
create temp table tres as
select super_entidad ,id_entidad,codigo,entidad,max(spo) spo, max(soa) soa, max(sp) sp,max(sap) sap, max(sabs) sabs, max(st) st,max(scp) scp, max(sci) sci, max(rce) rce,max(srip)srip
from dos
group by super_entidad ,id_entidad,codigo,entidad
*/
select a.super_entidad,a.id_entidad,a.codigo,a.entidad,
coalesce(b.id_estado,'NP') SPO,
coalesce(c.id_estado,'NP') SOA,
coalesce(d.id_estado,'NP') SP,
coalesce(e.id_estado,'NP') SAP,
coalesce(f.id_estado,'NP') SABS,
coalesce(g.id_estado,'NP') ST,
coalesce(h.id_estado,'NP') SCP,
coalesce(i.id_estado,'NP') SCI,
coalesce(j.id_estado,'NP') RCE,
coalesce(k.id_estado,'NP') SRIP

from tres a

left join compatibilizacion b on b.id_compatibilizacion=a.spo
left join compatibilizacion c on c.id_compatibilizacion=a.soa
left join compatibilizacion d on d.id_compatibilizacion=a.sp
left join compatibilizacion e on e.id_compatibilizacion=a.sap
left join compatibilizacion f on f.id_compatibilizacion=a.sabs
left join compatibilizacion g on g.id_compatibilizacion=a.st
left join compatibilizacion h on h.id_compatibilizacion=a.scp
left join compatibilizacion i on i.id_compatibilizacion=a.sci
left join compatibilizacion j on j.id_compatibilizacion=a.rce
left join compatibilizacion k on k.id_compatibilizacion=a.srip

order by  a.super_entidad asc,a.entidad asc

