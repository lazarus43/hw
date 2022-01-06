use QLBongDa;
-- câu 48
go
create trigger tg_vitri on CAUTHU for insert
as
begin
    declare  @vitri nvarchar(24)
    select @vitri = vitri
    from inserted
    if @vitri not in (N'Thủ Môn', N'Tiền đạo', N'Tiền Vệ', N'Trung vệ', N'Hậu vệ')
	begin
        raiserror('Vi tri sai',15,1)
        rollback tran
        return
    end
end
INSERT into CAUTHU
VALUES(N'Nguyễn Tèo', N'Hau', null, null, 'BBD', 'VN', 99)
drop trigger tg_vitri
--Câu 49
GO
create TRIGGER tg_soao on CAUTHU FOR INSERT
as
BEGIN
    DECLARE @soao int, @maclb nvarchar(25)
    select @soao = SO, @maclb = MACLB
    from inserted
    if((select count(MACT)
    from CAUTHU
    where SO = @soao and MACLB = @maclb)>1)
    BEGIN
        RAISERROR(N'Trung so ao',15,1)
        ROLLBACK TRAN
        RETURN
    END
END
INSERT INTO CAUTHU
VALUES(N'Tèo Nguyễn', N'Tiền Đạo', null, null, 'SDN', 'VN', 7)
drop TRIGGER tg_soao
--Câu 50
go
create trigger tg_themct on CAUTHU FOR INSERT
AS
BEGIN
    print N'đã them cầu thủ mới'
END
--Câu 51
go
create TRIGGER tg_ctnn on CAUTHU
FOR INSERT
AS
BEGIN
    DECLARE @maclb NVARCHAR(25), @maqg NVARCHAR(25)
    SELECT @maclb = MACLB, @maqg = MAQG
    FROM inserted
    IF(@maqg <> 'VN')
    BEGIN
        IF((select COUNT(MACT)
        from CAUTHU
        where MACLB = @maclb and MAQG <> 'VN') > 8)
        BEGIN
            RAISERROR(N'Không cho phép quá 8 cầu thủ nước ngoài',15,1)
        END
    END
END
drop trigger tg_ctnn
--Câu 52
go
create TRIGGER tg_qg on QUOCGIA
FOR INSERT
AS
BEGIN
    DECLARE @tenqg NVARCHAR(26)
    SELECT @tenqg = TENQG
    FROM inserted
    if((select COUNT(MAQG)
    from QUOCGIA
    where TENQG = @tenqg) > 1)
BEGIN
        RAISERROR(N'Tên quốc gia đã tồn tại', 15,1)
    END
END
INSERT into QUOCGIA
VALUES
    ('NK', N'Hàn Quốc')
drop TRIGGER tg_qg
--Câu 53
GO
create TRIGGER tg_tinh on TINH FOR INSERT
AS
begin
    declare @tentinh nvarchar(100)
    SELECT @tentinh = TENTINH
    from inserted
    if((select count(MATINH) from TINH where TENTINH = @tentinh )> 1)
    BEGIN
        RAISERROR(N'Tên tỉnh đã tồn tại',15,1)
    END
end
INSERT into TINH
VALUES ('rr', N'Gia Lai')
drop trigger tg_tinh
--Câu 54
go
create trigger tg_trandau on TRANDAU FOR UPDATE
as
begin
	if update(ketqua)
	begin
	raiserror(N'Khong duoc sua ket qua', 15,1)
	end
end
drop trigger tg_trandau
	--54 but longer
	go
	create trigger tg_kqtrandau on TRANDAU FOR update
	as
	begin 
	declare @ketqua_m varchar(5) 
	declare @ketqua_cu varchar(5)
	select @ketqua_m  = KETQUA from inserted
	select @ketqua_cu = KETQUA from deleted
	if(@ketqua_m <> @ketqua_cu)
	begin
	raiserror(N'Khong duoc sua doi ket qua', 15, 1)
	end
	end
--Câu 55
go
create trigger tg_vthlv on HLV_CLB for update, insert
as
begin
	declare @maclb varchar(5), @vaitro nvarchar(100), @mahlv varchar(5)
	select @maclb = MACLB, @vaitro = VAITRO, @mahlv = MAHLV from inserted
	if(@vaitro not in (N'HLV Chính', N'HLV Phụ', N'HLV thể lực', N'HLV thủ môn'))
	begin
	raiserror(N'Vai tro HLV khong dung', 15,1)
	end
	if((select COUNT(*) from HLV_CLB where MAHLV = @mahlv)>1)
	begin
	raiserror(N'Chi 1 hlv trong 1 clb', 15, 1)
	end
	if((select COUNT(MAHLV) from HLV_CLB where MACLB = @maclb and VAITRO =N'HLV chính') > 2)
	begin
	raiserror(N'Khong the co hon 2 hlv chính trong mot doi', 15, 1)
	end
end