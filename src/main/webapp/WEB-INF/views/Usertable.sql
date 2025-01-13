CREATE database user;
use user;
CREATE TABLE userstore(
	storeIndex INT AUTO_INCREMENT PRIMARY KEY,
    storeID varchar(50),
    storePW varchar(50),
    storeName varchar(50),
    storePhone1 varchar(3),
    storePhone2 varchar(4),
    storePhone3 varchar(4),
    storeMobile1 varchar(3),
    storeMobile2 varchar(4),
    storeMobile3 varchar(4),
    storeMap varchar(50)
);
Alter TABLE userstore auto_increment=1;
insert into userstore values('abcd','0000','꽃집이네','010','0000','0000','02','1111','2222');
delete from userstore where storeID='abcd';
SELECT storeName FROM userstore WHERE storeID='abcd' AND storePW='0000';
INSERT INTO userstore (storeID, storePW, storeName, storePhone1, storePhone2, storePhone3, storeMobile1, storeMobile2, storeMobile3)
VALUES ('abcd', '0000', '꽃집이네', '010', '0000', '0000', '02', '1111', '2222');
select * from userstore;
ALTER TABLE userstore AUTO_INCREMENT = 1;
delete from userstore;
insert into userstore (storeID, storePW, storeName) values('admin','admin','관리자');
CREATE TABLE userDriver(
	driverIndex INT AUTO_INCREMENT PRIMARY KEY,
    driverID varchar(50),
	driverPW varchar(50),
    driverName varchar(50),
    driverMobile1 varchar(3),
    driverMobile2 varchar(4),
    driverMobile3 varchar(5),
    driverAvailavleArea varchar(50)
);
Alter TABLE userDriver auto_increment=1;
select * from userDriver;
INSERT INTO userDriver VALUES (0,'driver','0000','기사1','010','0000','0000','강남구');