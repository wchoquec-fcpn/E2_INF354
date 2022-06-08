declare		@cadena1 varchar(50),
			@cadena2 varchar(50),
			@len_cadena1 int,
			@len_cadena2 int,
			@contador int,
			@sql nvarchar(4000),
			@letra varchar(3),
			@columna varchar(10),
			@len_table int

set @cadena1='martha'
set @cadena2='marta'
set @len_cadena1=LEN(@cadena1)
set @len_cadena2=LEN(@cadena2)
set @contador=0
set @sql='create table nombre (';
while @contador<@len_cadena1
begin
	set @letra=LEFT(@cadena1,1)+cast(@contador as varchar(1))
	set @sql=@sql+@letra+' int,'
	set @cadena1 = RIGHT(@cadena1, LEN(@cadena1)-1)
	set @contador=@contador+1
end
set @sql=LEFT(@sql,LEN(@sql)-1)
set @sql=@sql+')'
print(@sql) 
exec sp_executesql @sql
set @contador=0
while @contador<@len_cadena2
begin
	set @letra=LEFT(@cadena2,1)
	set @cadena2 = RIGHT(@cadena2, LEN(@cadena2)-1)
	select top 1 @columna=COLUMN_NAME from INFORMATION_SCHEMA.COLUMNS
		where TABLE_NAME='nombre'
		and LEFT(COLUMN_NAME,1)=@letra
		and ORDINAL_POSITION>=@contador
	set @sql='insert into nombre('+@columna+') values(1)'
	exec sp_executesql @sql
	set @contador=@contador+1
end

set @contador=1
select @len_table=count(*) from INFORMATION_SCHEMA.COLUMNS
	where TABLE_NAME='nombre'
set @sql=''
while @contador<=@len_table
begin
	select @columna=COLUMN_NAME from INFORMATION_SCHEMA.COLUMNS
		where TABLE_NAME='nombre'
		and ORDINAL_POSITION=@contador
	set @sql=@sql+'sum('+@columna+'),'
	set @contador=@contador+1
end
set @sql='select '+LEFT(@sql, LEN(@sql)-1)
set @sql=@sql+' from nombre'
print (@sql)
--

drop table nombre

--
select top 1 @columna=COLUMN_NAME from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME='nombre'
and LEFT(COLUMN_NAME,1)='a'
and ORDINAL_POSITION>=4
print(@variable)
-- 5. Generar un agente inteligente que diferencia dos cadenas de caracteres.
-- ============= Solucion ===================================
--Tabla
SELECT * 
FROM nombre

--Filas
SELECT COUNT(*) 
FROM nombre;

--Columnas
SELECT COUNT(*)
FROM information_schema.columns
WHERE table_name = 'nombre'

--Suma Columnas
select sum(m0)+sum(a1)+sum(r2)+sum(t3)+sum(ISNULL(h4,0))+sum(a5) 
from nombre 

--Desactivar las advertencias
SET ANSI_WARNINGS OFF;
GO


--Solucion
IF 
(SELECT COUNT(*)FROM nombre)
= 
(select sum(m0)+sum(a1)+sum(r2)+sum(t3)+sum(ISNULL(h4,0))+sum(a5)from nombre ) 

AND 
(
SELECT COUNT(*)
FROM information_schema.columns
WHERE table_name = 'nombre'
)
= 
(select sum(m0)+sum(a1)+sum(r2)+sum(t3)+sum(ISNULL(h4,0))+sum(a5)from nombre )  

BEGIN  
   PRINT 'Son Iguales cadenas'  
END  
ELSE PRINT 'Son distintas cadenas';  
GO  
  


