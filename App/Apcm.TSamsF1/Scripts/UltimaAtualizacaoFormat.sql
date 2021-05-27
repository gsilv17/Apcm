Declare @last_update_ts datetime2 = null 
Select Top 1 @last_update_ts = Max({0}) From {1}
Select @last_update_ts = isnull(@last_update_ts, convert(datetime, '1900-01-01'))
Select Format(@last_update_ts, 'yyyy-MM-dd-HH.mm.ss.ffffff') as last_update_ts