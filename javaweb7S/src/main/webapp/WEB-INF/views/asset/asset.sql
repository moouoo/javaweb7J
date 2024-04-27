show tables;

select * from member2;

-- 인력관리
create table member2(
	idx int not null auto_increment,
	name varchar(10) not null,
	gender varchar(4) default '남자',
	country varchar(10) not null,
	sTerm date not null,
	eTerm date not null,
	salary int not null,
	cYear datetime default now(),
    photo varchar(100) default 'noimage.jpeg',
	primary key (idx)
);

drop table member2;

select * from member2;

-- 약품관리
create table medicine(
	idx int not null auto_increment,
	title varchar(20) not null UNIQUE,
	purchase int not null,
	stock int,
	price int not null,	/* 개당가격 */
	photo varchar(100),
	content varchar(100),
	pYear datetime default now(),
	primary key (idx)
);

drop table medicine;

select * from medicine;

-- 약품관리 ~ 경영관리 시 수익에 이용할 테이블
-- y. 위의 테이블은 sql문으로 stock부분은 덮어쓰기를 사용하여 바뀌는데 나머지 구입량과 가격, 구입년도는 처음그대로 이기때문
-- 정확히는 가격 구입량 구입년도의 새로운 행이 생기지 않아 나중에 수익 계산할때 사용이 불가, 그래도 윗 테이블의 초기값은 사용해야한다.
create table medicinePlus(
	idx int not null auto_increment,
	title varchar(20),
	purchase int,
	price int,
	pYear datetime,
	primary key (idx)
);

drop table medicinePlus;

select * from medicinePlus;

-- 사료관리
create table feed(
	idx int not null auto_increment,
	dIdx varchar(8) not null UNIQUE,
	stages varchar(8) not null,
	dIntake int not null,  /* 일일 두 당 섭취량(kg) */
	bFeeding int not null, /* 해당 동 사육 두 수 */
	primary key (idx)
);

drop table feed;

select * from feed;

desc feed;

-- 사료관리 : 주문기록 테이블
create table feedOlder(
	idx int not null auto_increment,
	stages varchar(8) not null,
	tKg int not null,
	price int not null,
	pYear datetime default now(),
	primary key (idx)
);

drop table feedOlder;

select * from feedOlder;

delete from feedOlder where idx = 55;

update feedOlder set price = 200;

update feedOlder set stages = '비육전기' where idx = 170;
update feedOlder set stages = '비육전기' where idx = 171;
update feedOlder set stages = '비육전기' where idx = 172;
update feedOlder set stages = '비육전기' where idx = 173;
update feedOlder set stages = '비육전기' where idx = 174;
update feedOlder set stages = '비육전기' where idx = 175;

-- 정액관리 : 등록
create table semen(
	idx int not null auto_increment,
	sNum varchar(10) not null UNIQUE,
	nTank varchar(2),
	EMA double,			/* 배최장근 단면적 */
	MS double,				/* 근내지방도 */
	BF double,				/* 등지방두께 */
	CW double,			/* 도체중 */
	stock int,
	primary key (idx)
);

drop table semen;

select * from semen;

-- 정액관리 : 입고
create table semenPlus(
	idx int not null auto_increment,
	sNum varchar(10) not null,
	purchase int,
	price int,
	pYear datetime,
	primary key (idx)
);

drop table semenPlus;

select * from semenPlus;

-- 시설기록
create table facility(
	idx int not null auto_increment,
	title varchar(30) not null,
	content	varchar(50),
	price int not null,
	pYear datetime default now(),
	primary key (idx)
);

drop table facility;

select * from facility;

select sum(price) as yExpense
		from(
			select price from facility where substring(pYear, 1, 4) = 2023
			union all
			select purchase * price as price from semenPlus where substring(pYear, 1, 4) = 2023
			union all
			select tKg * price as price from feedOlder where substring(pYear, 1, 4) = 2023
			union all
			select purchase * price as price from medicinePlus where substring(pYear, 1, 4) = 2023
			union all
			select purchase * price as price from medicine where substring(pYear, 1, 4) = 2023
			union all
			select salary * floor(DATEDIFF(eTerm, sTerm) / 30) as price from member2 where substring(cYear, 1, 4) = 2023
		) as yExpense;

		
select sum(salary * floor(DATEDIFF(eTerm, sTerm) / 30)) as memberP from member2;

select sum(price) as medicineP
		from(
			select purchase * price as price from medicinePlus
			union all
			select purchase * price as price from medicine
		) as medicineP;
		
select sum(tKg * price) as feedP from feedOlder;

select sum(price) as facilityP from facility;