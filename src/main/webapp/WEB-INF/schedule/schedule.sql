show tables;

create table junggoschedule (
  idx   int not null auto_increment,	/* 스케줄관리 고유번호 */
  mid   varchar(20) not null,					/* 회원 아이디(일정검색시 필요) */
  sDate datetime not null,						/* 일정 등록 날짜 */
  part  varchar(10) not null,					/* 거래분류(1.신발, 2.가구 ,3.옷, 4.전자제품, 5:기타 */
  content text not null,							/* 일정 상세내역 */
  primary key(idx),
  foreign key(mid) references junggomember(mid)
);
drop table junggoschedule;
desc junggoschedule;
delete from junggoschedule;

insert into junggoschedule values (default, 'hkd1234', '2024-05-31','거래일정', '신발거래');
insert into junggoschedule values (default, 'admin', '2024-05-31','거래일정', '옷장거래');
insert into junggoschedule values (default, 'qwer1234', '2024-05-31','거래일정', '드럼거래');