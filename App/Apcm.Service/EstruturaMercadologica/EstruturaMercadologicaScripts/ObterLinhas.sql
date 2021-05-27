
/*
	Declare @CodSistema varchar(10) = 'Atacado', @Secao int = 503
--*/

Declare 
	@Table varchar(max),
	@Query nvarchar(max),
	@Parameters nvarchar(max)
	
Select @Table = Case When @CodSistema = 'Atacado' Then 'IF_HIERARCHY_XREF_SAMS' Else 'IF_HIERARCHY_XREF' End
Set @Parameters = N'@Secao int'

Set @Query = N'
Select Distinct 
	Convert(int, N5SAD_LINHAID) as Linha, 
	Convert(varchar, N5SAD_LINHAID) + '' - '' + N5SAD_LINHA as LinhaDesc 
From 
	' + @Table + ' 
Where 
	N4SAD_SECAOID = @Secao  
Order By 
	1
'

Execute sp_executesql @Query, @Parameters, @Secao
