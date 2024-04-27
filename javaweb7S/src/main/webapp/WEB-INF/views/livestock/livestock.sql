show databases;

show tables;

-- 가축등록
create table registration(
	idx int not null auto_increment,
	cNum varchar(20) not null,
	birthday datetime default now(),
	gender varchar(10) default '수',
	etc text,
	price int,
	primary key (idx)
);

drop table registration;

select * from registration;

update registration set birthday = '2021-08-12' where idx = 92;
update registration set birthday = '2021-08-11' where idx = 93;
update registration set birthday = '2021-08-15' where idx = 94;
update registration set birthday = '2021-08-17' where idx = 95;



-- 가축등록 : 통계를 위한 가축등록
create table registrationPlus(
	idx int not null auto_increment,
	cNum varchar(20) not null,
	birthday datetime default now(),
	price int,
	primary key (idx)
);

drop table registrationPlus;

select * from registrationPlus;



-- 질병관리
create table disease(
	idx int not null auto_increment,
	cNum varchar(20) not null,
	dType varchar(10) default '호흡기',
	content varchar(100),
	dBirth datetime default now(),
	primary key (idx)
);

drop table disease;
desc disease;

show table disease;


-- 출하등록
create table livestockShipment(
	idx int not null auto_increment,
	cNum varchar(20) not null,
	price int not null,
	sYear datetime default now(),
	primary key (idx)
);

drop table livestockShipment;

select * from livestockShipment;



-- 발정관리
CREATE TABLE estrus (
	idx INT NOT NULL AUTO_INCREMENT,
	cNum VARCHAR(20) NOT NULL,
	etc varchar(50),
	sBirth datetime default now(),	/* 발정시작일 */
	eBirth datetime default now(),	/* 재발정일 */
	dBirth datetime,				/* 출산예정일 */
	eTime varchar(5) not null,
	PRIMARY KEY (idx)
);

drop table estrus;



select * from estrus;

select *,DATE_FORMAT(sBirth, '%Y-%c-%e') as stBirth,DATE_FORMAT(eBirth, '%Y-%c-%e') as etBirth from estrus order by idx desc;


insert into estrus values (default, '002-1111-1113-9', '', '2022-12-10', (select DATE_ADD('2022-12-10',INTERVAL 21 DAY)), (select DATE_ADD('2022-12-10',INTERVAL 284 DAY)), '19시');


-- 출산관리
create table birth(
	idx int not null auto_increment,
	cNum varchar(20) not null,
	etc varchar(50),
	dBirth datetime,	/* 출산예정일 */
	primary key (idx)
);

drop table birth;

select * from birth;



select substring(sYear, 1 ,4) from livestockShipment;
select substring(sYear, 1 ,4), price as yRevenue from livestockShipment where substring(sYear, 1 ,4) = 2022;
select substring(sYear, 1 ,4), price as yRevenue from livestockShipment where substring(sYear, 1 ,4) in ('2020', '2021');
