show tables;

create table login(
	idx int not null auto_increment,
	mid varchar(10) not null,
	pwd varchar(200) not null,
	level int default 1,				/* 1:고용인, 2:농장주 */
	primary key (idx)
);


desc member2;

desc login;

INSERT INTO login (mid, pwd, level) VALUES ('admin', 'admin', 2);
INSERT INTO login (mid, pwd, level) VALUES ('member', 'member', default);
INSERT INTO login (mid, pwd, level) VALUES ('member2', 'member2', default);

select * from login;


-- 특이사항기록
create table chat(
	idx int not null auto_increment,
	chat varchar(100),
	cYear datetime default now(),
	mid varchar(10),
	primary key (idx)
);

drop table chat;

select * from chat;

insert into chat values (default, '안녕하세요, 그린농장 관리 프로그램 입니다. 여기에는 축산관련 특이사항을 입력해주시면 됩니다. 감사합니다.', '2020-01-01', '농장주' );
insert into chat values (default, '축사 주변 처음보는 차량 12가 3456', '2020-03-10', '농장주' );
insert into chat values (default, '축사 주위 뱀 발견, 6/17일 벌초 예정', '2020-06-15', '농장주' );
insert into chat values (default, '축사 주위 떠돌이 견 발견, 축사 내부에서 발견시 쫓아낼것', '2020-10-04', '농장주' );
insert into chat values (default, '11월 12일 HACCP심사예정, 축사 주위 청소', '2020-11-09', '농장주' );
insert into chat values (default, '한파주의보 발령, 물통 확인할 것', '2021-01-12', '농장주' );
insert into chat values (default, '사장님을 찾는 손님 오셨다 가셨습니다.', '2021-03-21', '관리인' );
insert into chat values (default, 'A동에 벌집 발견', '2021-07-03', '관리인' );
insert into chat values (default, '역대급 태풍인 온다고 하니 배수구 확인.', '2021-08-10', '농장주' );
insert into chat values (default, '축사 주위 예초', '2021-08-20', '농장주' );
insert into chat values (default, '외부차량 발견 42나 8643', '2021-10-02', '관리인' );
insert into chat values (default, '외부차량 발견 17다 1483', '2021-10-12', '관리인' );
insert into chat values (default, '축사 빙판길 조심', '2021-12-21', '농장주' );
insert into chat values (default, 'C동 3번째 칸 물통 고장', '2022-02-01', '관리인' );
insert into chat values (default, '외부차량 13가 7631', '2022-03-12', '농장주' );
insert into chat values (default, '외부차량 85나 1073', '2022-07-02', '관리인' );
insert into chat values (default, '오후에 배수구 관리 하겠습니다.', '2022-07-12', '농장주' );
insert into chat values (default, '사장님 손님 오셨다 가셨습니다. 받은 명함은 관리실 책상위에 두겠습니다.', '2022-09-12', '관리인' );
insert into chat values (default, '8888번 저번에 새끼 버렸던 경험 있으니 유심히 잘 살펴볼것', '2022-10-11', '농장주' );
insert into chat values (default, '1월 5일 새로운 관리인이 오시니 빈 방 정리할 것', '2022-12-25', '농장주' );
insert into chat values (default, '축사에서 떨어지는 얼음덩어리를 조심하세요', '2023-01-13', '농장주' );
insert into chat values (default, '떠돌이견 축사 주위에서 발견 하였으니 조심하시기 바람니다.', '2023-02-28', '관리인' );
insert into chat values (default, '국내 구제역이 퍼지고 있으니 최대한 외출을 삼가해주시면 감사하겠습니다.', '2023-05-17', '농장주' );
insert into chat values (default, '비가 많이 오고 있으니 바람에 날아오는 나뭇가지 등을 조심하시기 바랍니다.', '2023-07-24', '농장주' );










