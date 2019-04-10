create table pr_to_analyze
select * from (select user_id,group_concat(body)as content from pull_request_comments 
group by user_id)as pr
inner join 
(select user_id from activeusers)as actus
on pr.user_id=actus.user_id;

create table cc_to_analyze
select * from (select user_id,group_concat(body)as content from commit_comments 
group by user_id)as cc
inner join 
(select user_id from activeusers)as actus
on cc.user_id=actus.user_id;
