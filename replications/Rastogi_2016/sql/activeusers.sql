create table activeusers
select * from (select user_id from pull_request_comments group by user_id having count(user_id)>100 )as pr
inner join (select * from commit_comments group by user_id having count(user_id)>100)as cc
on pr.user_id=cc.user_id;