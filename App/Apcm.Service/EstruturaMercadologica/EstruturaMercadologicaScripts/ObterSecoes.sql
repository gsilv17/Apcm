
/*
	Declare @CodSistema varchar(10) = 'Atacado'
--*/

Declare 
	@Table varchar(max),
	@Query nvarchar(max)
		
Select @Table = Case When @CodSistema = 'Atacado' Then 'IF_HIERARCHY_XREF_SAMS' Else 'IF_HIERARCHY_XREF' End

Set @Query = N'
Select Distinct 
	Convert(int, N4SAD_SECAOID) as Secao, 
	Convert(varchar, N4SAD_SECAOID) + '' - '' + N4SAD_SECAO as SecaoDesc 
From 
	' + @Table + ' 
Order By 
	1
'

Execute sp_executesql @Query