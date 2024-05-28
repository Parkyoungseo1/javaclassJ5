show tables;

create table junggoboard(
	idx int not null auto_increment,		/* 게시글의 고유번호*/
	mid varchar(20) not null,						/* 게시글 올린이 아이디 */
	nickName varchar(20) not null, 			/* 게시글 올린이 닉네임 */
	title varchar(100) not null,  			/* 게시글 제목 */
	content text not null, 							/* 글 내용 */
	readNum int default 0, 							/* 글 조회수 */
	price int not null,								  /* 물건 가격 */
	openSw char(2) default 'OK',        /* 게시글 공개여부(OK:공개, NO:비공개) */
	wDate datetime default now(),				/* 글쓴 날짜 */
	good int default 0,									/* '좋아요' 클릭 횟수 누적 */
	complaint char(2) default 'NO',			/* 신고글 유무(신고당한글 :OK, 정상글: NO) */
	primary key(idx),										/* 기본키 : 고유번호 */
	foreign key(mid) references junggomember(mid)
);

drop table junggoboard;
desc junggoboard;

insert into junggoboard values (default,'admin','관리맨','게시판 서비스를 시작합니다.','즐거운 게시판생활이 되세요.',default,0,default,default,default,default);

/* 댓글 달기 */
create table junggoboardReply(
	idx int not null auto_increment, /* 댓글 고유번호*/
	boardIdx int not null,  /* 원본글의 고유번호-외래키로 지정*/
	mid varchar(20) not null, /* 댓글 올린이의 아이디*/
	nickName varchar(20) not null, /* 댓글 올린이의 닉네임*/
	wDate datetime default now(), /* 댓글 올린 날짜/시간*/
	content text not null, /* 댓글 내용 */
	primary key(idx),
	foreign key(boardIdx) references junggoboard(idx)
	on update cascade
	on delete restrict
);

drop table junggoboardReply;
desc junggoboardReply;

insert into junggoboardReply values (default, 1, 'hkd1234', '홍장군', default, '제가 홍장군입니다요.');
insert into junggoboardReply values (default, 1, 'hkd1234', '홍장군', default, '헤헷.');
insert into junggoboardReply values (default, 1, 'hkd1234', '홍장군', default, '푸...zzz.');

select * from junggoboardReply;

select * from junggoboard;
select * from junggoboard where idx =1;  /*현재글*/
select idx,title from junggoboard where idx >9 order by idx limit 1;  /*다음글*/
select idx,title from junggoboard where idx <9 order by idx desc limit 1;  /*이전글*/

-- 시간으로 비교해서 필드에 값 저장하기
select *, timestampdiff(hour, wDate, now()) as hour_diff from junggoboard;

-- 날짜 비교해서 필드에 값 저장하기
select *, datediff(wDate, now()) as date_diff from junggoboard;