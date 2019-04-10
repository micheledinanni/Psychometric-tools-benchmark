#rq3
#create tables for years consecutive in pull requests comments
create table pr_years1
select * from pull_request_comments inner join activeusers on us1=user_id where year(created_at)=2012;

create table pr_years2
select * from pull_request_comments inner join activeusers on us1=user_id where year(created_at)=2013;

create table pr_years3
select * from pull_request_comments inner join activeusers on us1=user_id where year(created_at)=2014;

#create tables in pull requests comments
create table cc_years1
select * from commit_comments inner join activeusers on us1=user_id where year(created_at)=2012;

create table cc_years2
select * from commit_comments inner join activeusers on us1=user_id where year(created_at)=2013;

create table cc_years3
select * from commit_comments inner join activeusers on us1=user_id where year(created_at)=2014;

#concatenate all pull requests comments in year1 
create table cc_years1_concat
select rq3.user_id as id,group_concat(body) as content from cc_years1 inner join rq3
on cc_years1.user_id=rq3.user_id group by rq3.user_id;

create table cc_years2_concat
select rq3.user_id as id,group_concat(body) as content from cc_years2 inner join rq3
on cc_years2.user_id=rq3.user_id group by rq3.user_id;

create table cc_years3_concat
select rq3.user_id as id,group_concat(body) as content from cc_years3 inner join rq3
on cc_years3.user_id=rq3.user_id group by rq3.user_id;


#select tables export in json

select * from pr_years3_concat;

delete from cc_years1_concat where id = 1654 or id = 28514 or id = 41896 or id = 73930 or id = 150901;





