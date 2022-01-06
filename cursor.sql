use QLBongDa

--câu 58
go
declare cur_dsct Cursor
for select MACT, HOTEN, VITRI from CAUTHU
open cur_dsct
declare @mact int, @hoten nvarchar(100), @vitri nvarchar(50)
while 0=0 
	begin
	fetch next from cur_dsct into @mact, @hoten, @vitri
	if @@FETCH_STATUS <> 0 break
	print concat(N'Mã cầu thủ là: ', @mact, N', Họ tên cầu thủ: ', @hoten, N', Vị trí: ', @vitri)
	end
close cur_dsct
deallocate cur_dsct

--Câu 59
go
declare cur_dsclb cursor
for select clb.MACLB, clb.TENCLB, svd.TENSAN from CAULACBO clb 
join SANVD svd on clb.MASAN = svd.MASAN
open cur_dsclb
declare @maclb varchar(5), @tenclb nvarchar(100), @tensan nvarchar(100)
while 0=0
	begin
	fetch next from cur_dsclb into @maclb, @tenclb, @tensan
	if @@FETCH_STATUS <> 0 break
	print concat(N'Mã câu lạc bộ: ', @maclb,N', tên câu lạc bộ: ', @tenclb, N', tên sân: ', @tensan)
	end
close cur_dsclb
deallocate cur_dsclb