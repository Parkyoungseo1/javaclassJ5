show tables;

create table junggoboard(
	idx int not null auto_increment,		/* 게시글의 고유번호*/
	mid varchar(20) not null,						/* 게시글 올린이 아이디 */
	nickName varchar(20) not null, 			/* 게시글 올린이 닉네임 */
	title varchar(100) not null,  			/* 게시글 제목 */
	content text not null, 							/* 글 내용 */
	readNum int default 0, 							/* 글 조회수 */
	openSw char(2) default 'OK',        /* 게시글 공개여부(OK:공개, NO:비공개) */
	wDate datetime default now(),				/* 글쓴 날짜 */
	good int default 0,									/* '좋아요' 클릭 횟수 누적 */
	complaint char(2) default 'NO',			/* 신고글 유무(신고당한글 :OK, 정상글: NO) */
	primary key(idx),										/* 기본키 : 고유번호 */
	foreign key(mid) references junggomember(mid)
);
drop table junggoboard;
desc junggoboard;

insert into junggoboard values (default,'admin','관리자','중고거래는 커넥션 중고거래','항상 거래 조심하세요!',default,default,default,default,default);