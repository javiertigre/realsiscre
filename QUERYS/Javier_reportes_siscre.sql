--1. se elige la super entidad, la entidad , el sistema y el m{aximo id donde está ese sistema --> tabla temporal uno
/*
create temp table uno as
SELECT se.super_entidad,e.id_entidad,e.codigo,e.entidad,c.id_sistema,max(c.id_compatibilizacion)as id_compatibilizacion
FROM entidad e
     left join compatibilizacion c ON e.id_entidad=c.id_entidad
     inner join super_entidad se ON se.id_super_entidad=e.id_super_entidad
     
WHERE se.id_estado='1' and e.id_estado='1'
group by se.super_entidad,e.id_entidad,e.codigo,e.entidad,c.id_sistema
order by 1,2,3,4,5

*/
---------------
--select * from uno
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
/*
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
*/
/*
---creando tabla cuatro para poner contadores
create temp table cuatro as
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
*/
--------------------
/*
select *,
        case  when spo='A' then 1 else 0  end  + case  when soa='A' then 1 else 0 end  + case  when sp='A' then 1 else 0 end  + case  when sap='A' then 1 else 0 end  + case  when sabs='A' then 1 else 0 end  +
        case  when st='A' then 1  else 0  end  + case  when scp='A' then 1 else 0 end  + case  when sci='A' then 1 else 0 end  + case  when rce='A' then 1 else 0 end  + case  when srip='A' then 1  else 0
        end A,
        
        case  when spo='C' then 1 else 0  end  + case  when soa='C' then 1 else 0 end  + case  when sp='C' then 1 else 0 end  + case  when sap='C' then 1 else 0 end  + case  when sabs='C' then 1 else 0 end  +
        case  when st='C' then 1  else 0  end  + case  when scp='C' then 1 else 0 end  + case  when sci='C' then 1 else 0 end  + case  when rce='C' then 1 else 0 end  + case  when srip='C' then 1  else 0
        end C,
        
        case  when spo='CM' then 1 else 0  end  + case  when soa='CM' then 1 else 0 end  + case  when sp='CM' then 1 else 0 end  + case  when sap='CM' then 1 else 0 end  + case  when sabs='CM' then 1 else 0 end  +
        case  when st='CM' then 1  else 0  end  + case  when scp='CM' then 1 else 0 end  + case  when sci='CM' then 1 else 0 end  + case  when rce='CM' then 1 else 0 end  + case  when srip='CM' then 1  else 0
        end   CM,
        
        case  when spo='I' then 1 else 0  end  + case  when soa='I' then 1 else 0 end  + case  when sp='I' then 1 else 0 end  + case  when sap='I' then 1 else 0 end  + case  when sabs='I' then 1 else 0 end  +
        case  when st='I' then 1  else 0  end  + case  when scp='I' then 1 else 0 end  + case  when sci='I' then 1 else 0 end  + case  when rce='I' then 1 else 0 end  + case  when srip='I' then 1  else 0
        end I,
        
        case  when spo='IM' then 1 else 0  end  + case  when soa='IM' then 1 else 0 end  + case  when sp='IM' then 1 else 0 end  + case  when sap='IM' then 1 else 0 end  + case  when sabs='IM' then 1 else 0 end  +
        case  when st='IM' then 1  else 0  end  + case  when scp='IM' then 1 else 0 end  + case  when sci='IM' then 1 else 0 end  + case  when rce='IM' then 1 else 0 end  + case  when srip='IM' then 1  else 0
        end IM,
        
        case  when spo='D' then 1 else 0  end  + case  when soa='D' then 1 else 0 end  + case  when sp='D' then 1 else 0 end  + case  when sap='D' then 1 else 0 end  + case  when sabs='D' then 1 else 0 end  +
        case  when st='D' then 1  else 0  end  + case  when scp='D' then 1 else 0 end  + case  when sci='D' then 1 else 0 end  + case  when rce='D' then 1 else 0 end  + case  when srip='D' then 1  else 0
        end D,
        
        case  when spo='DM' then 1 else 0  end  + case  when soa='DM' then 1 else 0 end  + case  when sp='DM' then 1 else 0 end  + case  when sap='DM' then 1 else 0 end  + case  when sabs='DM' then 1 else 0 end  +
        case  when st='DM' then 1  else 0  end  + case  when scp='DM' then 1 else 0 end  + case  when sci='DM' then 1 else 0 end  + case  when rce='DM' then 1 else 0 end  + case  when srip='DM' then 1  else 0
        end DM,
        
        case  when spo='AM' then 1 else 0  end  + case  when soa='AM' then 1 else 0 end  + case  when sp='AM' then 1 else 0 end  + case  when sap='AM' then 1 else 0 end  + case  when sabs='AM' then 1 else 0 end  +
        case  when st='AM' then 1  else 0  end  + case  when scp='AM' then 1 else 0 end  + case  when sci='AM' then 1 else 0 end  + case  when rce='AM' then 1 else 0 end  + case  when srip='AM' then 1  else 0
        end AM,
        
        case  when spo='NP' then 1 else 0  end  + case  when soa='NP' then 1 else 0 end  + case  when sp='NP' then 1 else 0 end  + case  when sap='NP' then 1 else 0 end  + case  when sabs='NP' then 1 else 0 end  +
        case  when st='NP' then 1  else 0  end  + case  when scp='NP' then 1 else 0 end  + case  when sci='NP' then 1 else 0 end  + case  when rce='NP' then 1 else 0 end  + case  when srip='NP' then 1  else 0
        end NP
        
from cuatro
*/
------------------
/*
create temp table cinco as
select *,
        case  when spo='A' then 1 else 0  end  + case  when soa='A' then 1 else 0 end  + case  when sp='A' then 1 else 0 end  + case  when sap='A' then 1 else 0 end  + case  when sabs='A' then 1 else 0 end  +
        case  when st='A' then 1  else 0  end  + case  when scp='A' then 1 else 0 end  + case  when sci='A' then 1 else 0 end  + case  when rce='A' then 1 else 0 end  + case  when srip='A' then 1  else 0
        end A,
        
        case  when spo='C' then 1 else 0  end  + case  when soa='C' then 1 else 0 end  + case  when sp='C' then 1 else 0 end  + case  when sap='C' then 1 else 0 end  + case  when sabs='C' then 1 else 0 end  +
        case  when st='C' then 1  else 0  end  + case  when scp='C' then 1 else 0 end  + case  when sci='C' then 1 else 0 end  + case  when rce='C' then 1 else 0 end  + case  when srip='C' then 1  else 0
        end C,
        
        case  when spo='CM' then 1 else 0  end  + case  when soa='CM' then 1 else 0 end  + case  when sp='CM' then 1 else 0 end  + case  when sap='CM' then 1 else 0 end  + case  when sabs='CM' then 1 else 0 end  +
        case  when st='CM' then 1  else 0  end  + case  when scp='CM' then 1 else 0 end  + case  when sci='CM' then 1 else 0 end  + case  when rce='CM' then 1 else 0 end  + case  when srip='CM' then 1  else 0
        end   CM,
        
        case  when spo='I' then 1 else 0  end  + case  when soa='I' then 1 else 0 end  + case  when sp='I' then 1 else 0 end  + case  when sap='I' then 1 else 0 end  + case  when sabs='I' then 1 else 0 end  +
        case  when st='I' then 1  else 0  end  + case  when scp='I' then 1 else 0 end  + case  when sci='I' then 1 else 0 end  + case  when rce='I' then 1 else 0 end  + case  when srip='I' then 1  else 0
        end I,
        
        case  when spo='IM' then 1 else 0  end  + case  when soa='IM' then 1 else 0 end  + case  when sp='IM' then 1 else 0 end  + case  when sap='IM' then 1 else 0 end  + case  when sabs='IM' then 1 else 0 end  +
        case  when st='IM' then 1  else 0  end  + case  when scp='IM' then 1 else 0 end  + case  when sci='IM' then 1 else 0 end  + case  when rce='IM' then 1 else 0 end  + case  when srip='IM' then 1  else 0
        end IM,
        
        case  when spo='D' then 1 else 0  end  + case  when soa='D' then 1 else 0 end  + case  when sp='D' then 1 else 0 end  + case  when sap='D' then 1 else 0 end  + case  when sabs='D' then 1 else 0 end  +
        case  when st='D' then 1  else 0  end  + case  when scp='D' then 1 else 0 end  + case  when sci='D' then 1 else 0 end  + case  when rce='D' then 1 else 0 end  + case  when srip='D' then 1  else 0
        end D,
        
        case  when spo='DM' then 1 else 0  end  + case  when soa='DM' then 1 else 0 end  + case  when sp='DM' then 1 else 0 end  + case  when sap='DM' then 1 else 0 end  + case  when sabs='DM' then 1 else 0 end  +
        case  when st='DM' then 1  else 0  end  + case  when scp='DM' then 1 else 0 end  + case  when sci='DM' then 1 else 0 end  + case  when rce='DM' then 1 else 0 end  + case  when srip='DM' then 1  else 0
        end DM,
        
        case  when spo='AM' then 1 else 0  end  + case  when soa='AM' then 1 else 0 end  + case  when sp='AM' then 1 else 0 end  + case  when sap='AM' then 1 else 0 end  + case  when sabs='AM' then 1 else 0 end  +
        case  when st='AM' then 1  else 0  end  + case  when scp='AM' then 1 else 0 end  + case  when sci='AM' then 1 else 0 end  + case  when rce='AM' then 1 else 0 end  + case  when srip='AM' then 1  else 0
        end AM,
        
        case  when spo='NP' then 1 else 0  end  + case  when soa='NP' then 1 else 0 end  + case  when sp='NP' then 1 else 0 end  + case  when sap='NP' then 1 else 0 end  + case  when sabs='NP' then 1 else 0 end  +
        case  when st='NP' then 1  else 0  end  + case  when scp='NP' then 1 else 0 end  + case  when sci='NP' then 1 else 0 end  + case  when rce='NP' then 1 else 0 end  + case  when srip='NP' then 1  else 0
        end NP
        
from cuatro
*/
--select * from cinco
---------
select sum(a) t_a,sum(c)t_c,sum(cm)t_cm,sum(i)t_i,sum(im)t_im,sum(d)t_d,sum(dm)t_dm,sum(am)t_am,sum(np)t_np
from cinco
--group by super_entidad,id_entidad,codigo,entidad,spo,soa,sp,sap,sabs,st,scp,sci,rce,srip,a,c,cm,i,im,d,dm,am,np
-----
 
