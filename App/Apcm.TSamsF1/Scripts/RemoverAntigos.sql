Delete
	a
From
	{0} as a
	Inner Join {0} as b on 
		a.idLoad < b.idLoad
		And a.{1} < b.{1}
		{2}
Where
	b.idLoad = @p0