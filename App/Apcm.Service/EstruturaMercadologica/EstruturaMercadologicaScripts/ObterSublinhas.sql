
/*
	Declare @CodSistema varchar(10) = 'Atacado', @Secao int, @Linha int
--*/

Declare 
	@Table varchar(max),
	@Query nvarchar(max),
	@Parameters nvarchar(max)
	
Select @Table = Case When @CodSistema = 'Atacado' Then 'IF_HIERARCHY_XREF_SAMS' Else 'IF_HIERARCHY_XREF' End
Set @Parameters = N'@Secao int, @Linha int'

Set @Query = N'
Select Distinct 
	Convert(int, N6SAD_SUBLINHAID) as Sublinha, 
	Convert(varchar, N6SAD_SUBLINHAID) + '' - '' + N6SAD_SUBLINHA as SublinhaDesc 
From 
	' + @Table + ' 
Where 
	N4SAD_SECAOID = @Secao 
	And N5SAD_LINHAID = @Linha 
Order By 
	1
'

Execute sp_executesql @Query, @Parameters, @Secao, @Linha
