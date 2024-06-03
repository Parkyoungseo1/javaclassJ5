show tables;

/* 신고테이블(complaint) */
create table junggocomplaint(
	idx int not null auto_increment, /* 신고테이블 고유번호 */
	part varchar(15) not null, 			 /* 신고 분류(게시판:board, 자료실:pds, 방명록:guest) */
	partIdx int not null, 					 /* 신고분류항목 글의 고유번호 */
	cpMid varchar(20) not null,			 /* 신고자 아이디 */
	cpContent text not null,				 /* 신고 사유 */
	cpDate datetime default now(),	 /* 신고한 날짜 */
	primary key(idx)
);
desc junggocomplaint;
drop table junggocomplaint;

insert into junggocomplaint values (default, 'junggoboard', 6, 'hkd1234', '광고성 글', default);

select * from junggocomplaint;

delete from junggocomplaint where idx = '1';

select c.*, b.title, b.nickName, b.mid from junggocomplaint c, junggoboard b where c.partIdx = b.idx ;

select c.*, b.title as title, b.nickName as nickName, b.mid as mid from junggocomplaint c, junggoboard b where c.partIdx = b.idx;

select c.*, date_format(c.cpDate, '%Y-%m-%d %H:%i') as cpDate, b.title as title, b.nickName as nickName, b.mid as mid from junggocomplaint c, junggoboard b where c.partIdx = b.idx ;
