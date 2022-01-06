use QLBongDa
-- Câu 35
GO
CREATE PROC sp_35(@ten nvarchar(25))
AS
BEGIN
    PRINT CONCAT(N'Xin Chào ', @ten)
END
go
EXEC sp_35 @ten = "Tèo"
drop PROC sp_35
-- Câu 36
go
create PROC sp_tong(@s1 int,
    @s2 int)
AS
BEGIN
    declare @tong int
    set @tong = @s1 + @s2
    PRINT CONCAT(N'Tổng là: ', @tong)
END
go
EXEC sp_tong 7, 8
drop PROC sp_tong

-- Câu 37
Go
Create PROC sp_tinhtong(@s1 int,
    @s2 int,
    @tong int output)
as
BEGIN
    set @tong = @s1 + @s2
END
GO
DECLARE @sum int = 0;
EXEC sp_tinhtong @s1 = 3, @s2 = 2, @tong = @sum output
PRINT CONCAT(N'Tổng là: ', @sum)
drop PROC sp_tinhtong
--Câu 38
Go
Create Proc sp_38
    (
    @s1 int ,
    @s2 int)
As
Begin
    If(@s1>@s2)
	Begin
        Print CONCAT (N' Số lớn nhất là : ' , @s1)
    End
End
GO
Exec sp_38 10,9
Drop proc sp_38
--Câu 39
go
CREATE PROC sp_minmax(@s1 int,
    @s2 int,
    @max int output,
    @min int output)
AS
BEGIN
    IF(@s1 > @s2)
    BEGIN
        set @max = @s1
        set @min = @s2
    END
    Else
    BEGIN
        set @max = @s2
        set @min = @s1
    END
END
GO
DECLARE @mx int = 0, @mn int = 0;
EXEC sp_minmax @s1 = 19, @s2 =90, @max = @mx output, @min = @mn output
PRINT CONCAT(N'Max là: ', @mx,' ', N'Min là: ', @mn)
DROP proc sp_minmax
--câu 40
go
CREATE PROC sp_inso(@num int)
AS
BEGIN
    DECLARE @n INT = 0
    WHILE (@n < @num)
    BEGIN
        set @n = @n + 1
        PRINT CONCAT(N'Số thứ: ', @n)
    END
END
GO
EXEC sp_inso 9
drop PROC sp_inso
--Câu 41
go
CREATE PROC sp_insochan(@num int)
AS
BEGIN
    DECLARE @n INT = 0, @sum int =0
    WHILE (@n < @num)
    BEGIN
        set @n = @n + 1
        IF(@n%2 = 0 )
        BEGIN
            set @sum = @sum + @n
            PRINT CONCAT(N'Số chẳn là: ', @n)
        END
    END
    PRINT CONCAT(N'Tổng số chẳn: ', @sum)
END
GO
EXEC sp_insochan 30
drop PROC sp_insochan
--Câu 42
GO
CREATE PROC sp_tranhoa(@vong int =3 ,
    @nam int = 2009)
AS
BEGIN
    SELECT *
    FROM TRANDAU
    WHERE VONG = @vong AND NAM = @nam AND LEFT(KETQUA, 1) = RIGHT(KETQUA,1)
END
go
EXEC sp_tranhoa 3, 2009
drop PROC sp_tranhoa
--Câu 43 27
GO
CREATE PROC sp_ct(@clb nvarchar(25) ,
    @qg nvarchar(25))
AS
BEGIN
    SELECT ct.MACT, ct.HOTEN, ct.DIACHI, ct.NGAYSINH, ct.VITRI, ct.MAQG, ct.MACLB
    FROM CAUTHU ct JOIN CAULACBO clb on ct.MACLB = clb.MACLB
        JOIN QUOCGIA qg on ct.MAQG = qg.MAQG
    WHERE clb.TENCLB = @clb AND ct.MAQG = @qg
END
go
EXEC sp_ct N'SHB Đà Nẵng', BRA
drop PROC sp_ct
--Câu 43 28 ket qua thi dau vong, nam
GO
CREATE PROC sp_ketqua(@vong int = 3,
    @nam int = 2009)
AS
BEGIN
    SELECT td.MATRAN, td.NGAYTD, svd.TENSAN, clb1.TENCLB AS TENCLB1 , clb2.TENCLB as TENCLB2, td.KETQUA
    FROM TRANDAU td JOIN SANVD svd on td.MASAN = svd.MASAN
        JOIN CAULACBO clb1 on clb1.MACLB = td.MACLB1
        JOIN CAULACBO clb2 on clb2.MACLB = td.MACLB2
    WHERE VONG = @vong AND NAM = @nam
END
go
exec sp_ketqua
drop PROC sp_ketqua
--Câu 43 29 hlv vn
GO
CREATE PROC sp_HLV(@qg nvarchar(25))
as
BEGIN
    SELECT hlvclb.MAHLV, hlv.TENHLV, hlv.NGAYSINH, hlv.DIACHI, hlvclb.vaitro, clb.TENCLB, qg.TENQG
    FROM HLV_CLB hlvclb
        JOIN HUANLUYENVIEN hlv on hlvclb.MAHLV = hlv.MAHLV
        JOIN CAULACBO clb on hlvclb.MACLB = clb.MACLB
        JOIN QUOCGIA qg on hlv.MAQG = qg.MAQG
    where qg.MAQG = @qg
END
go
EXEC sp_HLV VN
drop PROC sp_HLV
--Câu 43 30
GO
CREATE PROC sp_ctnn(@maqg nvarchar(25) = N'VN')
AS
BEGIN
    SELECT clb.MACLB, clb.TENCLB, svd.TENSAN, t.TENTINH, count(MACT) AS CTNN
    FROM CAUTHU ct
        Join CAULACBO clb on ct.MACLB = clb.MACLB
        JOIN SANVD svd on clb.MASAN = svd.MASAN
        Join TINH t on clb.MATINH = t.MATINH
    WHERE ct.MAQG <> 'VN'
    GROUP by clb.MACLB, clb.TENCLB, svd.TENSAN, t.TENTINH
    HAVING COUNT(MACT) >= 2
END
GO
EXEC sp_ctnn
DROP PROC sp_ctnn
--Câu 43 31
Go
Create proc sp_cttinh
    (@ttinh nvarchar(10),
    @vitri nvarchar(10)= N'Tiền Đạo')
As
Begin
    select t.TENTINH, count (ct.MACT) AS SoLuong
    FROM CAUTHU ct
        join CAULACBO clb on clb.MACLB = ct.MACLB
        join TINH t on t.MATINH = clb.MATINH
    Where T.TENTINH = @ttinh and clb.MATINH = t.MATINH and ct.VITRI = @vitri
    Group by t.TENTINH
End
go
EXEC sp_cttinh N'Gia Lai'
Drop PROC sp_cttinh
--Câu 43 32
go
create proc sp_hang(@vong int = 3,
    @nam int = 2009)
as
BEGIN
    SELECT TENCLB, TENTINH
    FROM CAULACBO clb join TINH t ON clb.MATINH = t.MATINH
    WHERE MACLB in (
    select top 1
        MACLB
    FROM BANGXH
    WHERE VONG = @vong AND NAM = @nam
    ORDER BY HANG
)
end
go
exec sp_hang
drop proc sp_hang
--Câu 43 33
GO
create proc sp_dthlv(@maclb NVARCHAR(25))
as
BEGIN
    Select hlv.TENHLV, hlv.DIENTHOAI
    From HLV_CLB hlvclb JOIN HUANLUYENVIEN hlv on hlvclb.MAHLV = hlv.MAHLV
        JOIN CAULACBO clb ON hlvclb.MACLB = clb.MACLB
    WHERE clb.MACLB = @maclb AND hlv.DIENTHOAI is NULL
END
go
exec sp_dthlv 'BBD'
drop PROC sp_dthlv
--Câu 44
	--Câu 44 BANGXH
	GO
	create PROC bangxh(@maclb varchar(5),
		@nam int,
		@vong int,
		@sotran int,
		@thang int,
		@hoa int,
		@thua int,
		@hieuso VARCHAR(5),
		@diem int,
		@hang int)
	AS
	BEGIN
		INSERT into BANGXH(MACLB, NAM, VONG, SOTRAN, THANG, HOA, THUA, HIEUSO, DIEM, HANG)
		VALUES(@maclb, @nam, @vong, @sotran, @thang, @hoa ,@thua, @hieuso, @diem, @hang)
	END
	GO
	exec bangxh 'BBD', 0, 0, 0, 0, 0, 0, 'test', 0, 99
	drop PROC bangxh
	--Câu 44 CAULACBO
	go 
	create proc clb(@maclb varchar(5), @tenclb nvarchar(100), @masan varchar(5), @matinh varchar(5))
	as
	begin
	 insert into CAULACBO(MACLB, TENCLB, MASAN, MATINH)
	 values(@maclb, @tenclb, @masan, @matinh)
	end
	go
	exec clb 'TTT', 'Test', 'T', 'T'
	drop proc clb
	-- Câu 44 Cầu Thủ
	go
	create proc addct( @hoten nvarchar(100), @vitri nvarchar(50), @ngaysinh datetime, @diachi nvarchar(200),  @maclb varchar(5), @maqg varchar(5), @so int)
	as
	begin
		insert into CAUTHU( HOTEN, VITRI, NGAYSINH, DIACHI, MACLB,MAQG, SO)
		values( @hoten, @vitri, @ngaysinh, @diachi, @maclb, @maqg, @so)
	end
	go
	exec addct  'Test', N'Hậu Vệ', null, null, 'BBD', 'VN', 180
	drop proc addct
	-- Câu 44 HLV_CLB
	go
	create proc addhlvclb(@mahlv varchar(5), @maclb varchar(5), @vaitro nvarchar(100))
	as
	begin
	insert into HLV_CLB(MAHLV, MACLB, VAITRO)
	values(@mahlv, @maclb, @vaitro)
	end
	go
	exec addhlvclb 'T','BBD',N'HLV Chính'
	drop proc addhlvclb
	--Câu 44 HUANLUYENVIEN
	go 
	create proc addhlv(@mahlv varchar(5), @tenhlv nvarchar(100), @ngaysinh datetime, @diachi nvarchar(100), @dienthoai nvarchar(20), @maqg varchar(5))
	as
	begin
	insert into HUANLUYENVIEN(MAHLV, TENHLV, NGAYSINH, DIACHI, DIENTHOAI, MAQG)
	values(@mahlv, @tenhlv, @ngaysinh, @diachi, @dienthoai, @maqg)
	end
	go
	exec addhlv 'T',N'Mã Văn Tèo', null, null, null, 'VN'
	drop proc addhlv
	--Câu 44 QUOCGIA
	go
	create proc addqg(@maqg varchar(5), @tenqg nvarchar(60))
	as
	begin
	insert into QUOCGIA(MAQG, TENQG)
	values(@maqg, @tenqg)
	end
	go
	exec addqg 'T',N'Test'
	drop proc addqg
	--Câu 44 SANVD
	go
	create proc addsvd(@masan varchar(5), @tensan nvarchar(100), @diachi nvarchar(100))
	as
	begin
	insert into SANVD(MASAN, TENSAN, DIACHI)
	values(@masan, @tensan, @diachi)
	end
	go
	exec addsvd 'T','Test',null
	drop proc addsvd
	--//Câu 44 Tham Gia//
	--Câu 44 TINH
	go
	create proc addtinh(@matinh varchar(5), @tentinh nvarchar(100))
	as
	begin
	insert into TINH(MATINH, TENTINH)
	values(@matinh, @tentinh)
	end
	go
	exec addtinh 'T', 'Test'
	drop proc addtinh
	--//Câu 44 Tran Dau//
--Câu 45
GO
CREATE PROC sp_ttintd(@mact int)
AS
BEGIN
    select ct.MACT, ct.HOTEN, tg.MATD, td.NGAYTD
    FROM CAUTHU ct
        join THAMGIA tg on ct.MACT = tg.MACT
        JOIN TRANDAU td on tg.MATD = td.MATRAN
    WHERE ct.MACT = @mact
End
GO
exec sp_ttintd 2
drop proc sp_ttintd
--Câu 46
go
CREATE PROC sp_dsgb(@matd int)
AS
BEGIN
    SELECT tg.MACT, ct.HOTEN, tg.SOTRAI
    FROM THAMGIA tg
        JOIN CAUTHU ct on tg.MACT = ct.MACT
    WHERE MATD = @matd
END
GO
EXEC sp_dsgb 8
drop PROC sp_dsgb
--Câu 47
GO
CREATE PROC sp_tthoa
AS
BEGIN
    SELECT COUNT(KETQUA) as SoTranHoa
    FROM TRANDAU
    where LEFT(KETQUA,1) = RIGHT(KETQUA, 1)
END
go
exec sp_tthoa
drop proc sp_tthoa