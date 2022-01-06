

--* Nhóm GPMN  *-- 



--Câu 35
Create proc sp_35 ( @ten nvarchar(10))
AS
Begin
	Print Concat(N'Xin Chào ', @ten) 
End
Go
Exec sp_35 @ten = 'Bạn'
Drop proc sp_35

--Câu 36
go 
create PROC sp_36(@s1 int, @s2 int)
AS
BEGIN
    declare @tg int
    set @tg = @s1 + @s2
    PRINT CONCAT(N'Tổng là: ', @tg)
END
go 
EXEC sp_36 7, 8
drop PROC sp_36

--Câu 37
GO
CREATE PROC sp_37( @s1 int, @s2 int,@tong int output)
AS
BEGIN
	Set @tong=@s1+@s2
    PRINT CONCAT(N'Tổng là :', @tong)
END
Go
DECLARE @sum int = 0;
EXEC sp_37 @s1 =10, @s2 = 25,@tong = @sum output
Drop proc sp_37

--Câu 38
Go
Create Proc sp_38 ( @s1 int , @s2 int )
As
Begin
	If(@s1>@s2)
	Begin
		Print CONCAT (N' Số lớn nhất là : ' , @s1)
	End

	Else
	Begin
		Print CONCAT (N' Số lớn nhất là : ' , @s2)
	End
End

Exec sp_38 8 , 9
Drop proc sp_38

--Câu 39
Go
Create Proc sp_39 ( @s1 int , @s2 int ,@max int output , @min int output)
As
Begin
	If (@s1 > @s2)
	Begin
		Set @max = @s1
		Set @min = @s2
	End
	Else
	Begin
		Set @max = @s2
		Set @min = @s1
	End
End
Declare @Solon int = 0 , @Sonho int = 0
Exec sp_39 8 , 10 ,@max=@Solon output , @min = @Sonho output
Print CONCAT (N'Max là: ',@Solon ,N' Min là: ',@Sonho)
Drop proc sp_39

--Câu 40
Go
Create Proc sp_40 ( @n int )
As
Begin
	Declare @i int =0 	
	Print Concat (N'Các Số Chẵn Từ ',@i+1 ,N' Tới ',@n,N' Là: ')
	While(@i < @n)
	Begin
	Set @i = @i +1	
	If ( @i % 2=0)
	Begin
		Print (@i)
	End
	End	
End
Exec sp_40  20
Drop proc sp_40

--Câu 41
Go
Create Proc sp_41 ( @n int )
As
Begin
	Declare @i int =0 , @sum int = 0
	Print Concat (N'Các Số Chẵn Từ ',@i+1 ,N' Tới ',@n,N' Là: ')
	While(@i < @n)
	Begin
	Set @i = @i +1	
	If ( @i % 2=0)
	Begin
		set @sum = @sum + @i
		Print( @i)
	End
	End
	Print CONCAT (N'Tổng Các Số Chẵn Là : ', @sum)
End
Exec sp_41 12
Drop proc sp_41

--Câu 42
GO
CREATE PROC sp_42(@vong int =3 ,@nam int = 2009)
AS
BEGIN
    SELECT Count(KETQUA) As N'Số Trận Hòa Vòng 3 Năm 2019' FROM TRANDAU
    WHERE VONG = @vong AND NAM = @nam AND LEFT(KETQUA, 1) = RIGHT(KETQUA,1)
END
go
EXEC sp_42 
Drop proc sp_42

--Câu 43v27
Go
Create proc sp_43v27 (@maclb nvarchar(10), @maqg nvarchar(10))
As
Begin
Select SO as N'Số' ,HOTEN as N'Họ Tên', VITRI as N'Vị Trí',NGAYSINH as N'Ngày Sinh',TENQG as N'Quốc Gia' FROM CAUTHU
join QUOCGIA on QUOCGIA.MAQG = CAUTHU.MAQG
Where @maclb = MACLB and @maqg = CAUTHU.MAQG
End
Exec sp_43v27 "SDN","BRA"
Drop proc sp_43v27

--Câu43v28
Go
Create proc sp_43v28 (@Vong int = 3, @Nam int = 2009)
As
Begin
Select MATRAN  as N'Mã Trận'  , NGAYTD  as N'Ngày Thi Đấu' ,
clb1.TENCLB as N'Tên CLB1' ,clb2.TENCLB as N'Tên CLB2',TENSAN as N'Tên Sân', KETQUA as N'Kết Quả'  
FROM TRANDAU td
join SANVD svd ON  td.MASAN = svd.MASAN
join CAULACBO clb1 on td.MACLB1 = clb1.MACLB
join CAULACBO clb2 on td.MACLB2 = clb2.MACLB
WHERE @Vong = td.VONG and @Nam = td.NAM
End
Exec sp_43v28
Drop proc sp_43v28

--Câu 43v29
Go
Create proc sp_43v29 (@Qg nvarchar(10))
As
Begin
Select hlv.MAHLV  as N'Mã HLV' , TENHLV  as N'Họ & Tên HLV' , NGAYSINH as N'Ngày Sinh' ,
DIACHI  as N'Địa Chỉ' ,VAITRO as N'Vai Trò' ,TENCLB  as N'Tên CLB' FROM HUANLUYENVIEN hlv
join HLV_CLB hclb on  hclb.MAHLV=hlv.MAHLV
join CAULACBO clb on hclb.MACLB = clb.MACLB
WHERE  MAQG= @Qg
End
Exec sp_43v29 "VN"
Drop proc sp_43v29

--Câu 43v30
Go
Create proc sp_43v30 (@Qg nvarchar(10))
As
Begin
 select clb.MACLB as N'Mã CLB' , clb.TENCLB as N'Tên CLB', TENSAN as N'Tên Sân' ,t.TENTINH as N'Tên Tỉnh', count(MACT)  as N'Số Lượng Cầu Thủ Nước Ngoài' FROM CAUTHU ct
 join CAULACBO clb on clb.MACLB = ct.MACLB
 join SANVD svd on svd.MASAN = clb.MASAN
 join Tinh t on t.MATINH = clb.MATINH
 Where ct.MAQG not like @Qg
  GROUP by clb.MACLB, clb.TENCLB, svd.TENSAN,T.TENTINH
    HAVING COUNT(MACT) >= 2
END
Exec sp_43v30 "VN"
Drop proc sp_43v30

--Câu 43V31
Go
Create proc sp_43v31 (@tentinh nvarchar(10), @vitri nvarchar(10))
As
Begin
select t.TENTINH as N'Tên Tỉnh',clb.TENCLB as N'Tên CLB', count (ct.MACT) AS SL FROM CAUTHU ct
join CAULACBO clb on clb.MACLB = ct.MACLB
join TINH t on t.MATINH = clb.MATINH
Where T.TENTINH = @tentinh and ct.VITRI = @vitri
Group by t.TENTINH,clb.TENCLB
End
go
Exec sp_43v31 N'Bình Dương ',N'Tiền Đạo'
drop proc sp_43v31

--Câu 43v32
Go
Create proc sp_43v32 (@Vong int= 3,@Nam int=2009)
As
Begin
Select clb.TENCLB as N'Tên CLB' , t.TENTINH as N'Tên Tỉnh' ,bxh.HANG as N'Hạng' from CAULACBO clb
Join TINH t on t.MATINH = clb.MATINH
join BANGXH bxh on bxh.MACLB = clb.MACLB
Where bxh.HANG =1 and Vong =@Vong  and NAM=@Nam
End
Go
Exec sp_43v32 
Drop proc sp_43v32

--Câu 43v33
Go
Create proc sp_43v33 
as
Begin
Select TENHLV as N'Họ & Tên HLV', VAITRO as N'Vai Trò',DIENTHOAI as N'Số Điện Thoại' from HUANLUYENVIEN hlv
join HLV_CLB hlvclb on hlvclb.MAHLV = hlv.MAHLV
Where hlv.DIENTHOAI IS NULL
End
Exec sp_43v33
Drop proc sp_43v33

---Câu 44
--Table QuocGia
Go
Create proc sp_44_QG ( @maqg nvarchar(25), @tenqg nvarchar(25))
As
Begin
Insert into QUOCGIA (MAQG,TENQG) values
(@maqg,@tenqg)
End
Exec sp_44_QG N'USA' ,N'Mỹ'
Drop proc sp_44_QG

--Table Tinh
Go
Create proc sp_44_Tinh(@matinh nvarchar(25),@tentinh nvarchar(25))
As
Begin
Insert into TINH(MATINH,TENTINH) values
(@matinh,@tentinh)
End
Exec sp_44_Tinh N'DL',N'Đà Lạt'
Drop proc sp_44_Tinh

--Table	CauTHU
GO
Create proc sp_44_CauThu (@hoten nvarchar(25), @vitri nvarchar(25),@ngaysinh datetime , @diachi nvarchar(25),
@maclb nvarchar(25),@maqg nvarchar(25),@so int)
As
Begin
Insert into CAUTHU (HOTEN,VITRI,NGAYSINH,DIACHI,MACLB,MAQG,SO) values
(@hoten,@vitri,@ngaysinh,@diachi,@maclb,@maqg,@so)
End
Exec sp_44_CauThu N'ABC',N'Thủ Môn','2016-12-20','HCM','BBD','USA',20
Drop proc sp_44_CauThu

--Câu 45
Go
Create Proc sp_45 (@mact int)
As
Begin
Select ct.HOTEN as N'Họ & Tên',td.MATRAN as N'Mã Trận Đấu',td.NGAYTD as N'Ngày Thi Đấu',svd.TENSAN as N'Tên Sân' FROM CAUTHU ct
Join CAULACBO clb on clb.MACLB = ct.MACLB
Join TRANDAU td on td.MASAN = clb.MASAN
Join SANVD svd on svd.MASAN = td.MASAN
Where ct.MACT = @mact and ct.MACLB = td.MACLB1 or ct.MACLB = td.MACLB2
End
Exec sp_45 3
Drop proc sp_45

--Câu 46
Go
Create proc sp_46 (@mact int)
As
Begin
Select ct.MACT as N'Mã Cầu Thủ',ct.HOTEN as N'Họ & Tên' ,ct.SO as N'Số', ct.MACLB as N'Mã CLB' , tg.SOTRAI as N'Số Trái Ghi Bàn' from CAUTHU CT
join CAULACBO clb on clb.MACLB = CT.MACLB
join THAMGIA tg on tg.MACT = ct.MACT
Where ct.MACT = @mact
End
Exec sp_46 15
Drop proc sp_46

--Câu 47
GO
CREATE PROC sp_47
AS
BEGIN
    SELECT COUNT(KETQUA) As N'Tổng Số Trận Hòa ' FROM TRANDAU
    WHERE LEFT(KETQUA, 1) = RIGHT(KETQUA,1)
END
EXEC sp_47 
Drop proc sp_47
