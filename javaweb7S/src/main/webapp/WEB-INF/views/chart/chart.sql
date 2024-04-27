-- 설문조사 (ㄴㅔ이버 오피스 이용)
create table nSurvey(
	idx int not null auto_increment,
	sTitle varchar(100) not null,
	content varchar(200) not null,
	iYear datetime default now(),
	readNum int default 0,
	primary key (idx)
);

drop table nSurvey;

select * from nSurvey;

