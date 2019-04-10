create table high_level_contrib
select cc.user_id, group_concat(cc.cc_cont,pr.pr_cont) from
(select user_id, group_concat(body)as cc_cont  from commit_comments group by user_id
having count(user_id)>=2000) as cc
inner join 
(select user_id, group_concat(body)as pr_cont from pull_request_comments group by user_id
having count(user_id)>=2000)as pr
on cc.user_id=pr.user_id;

create table mid_level_contrib
select cc.user_id, group_concat(cc.cc_cont,pr.pr_cont) from
(select user_id, group_concat(body)as cc_cont  from commit_comments group by user_id
having count(user_id)<2000 and count(user_id)<=500) as cc
inner join 
(select user_id, group_concat(body)as pr_cont from pull_request_comments group by user_id
having count(user_id)<2000 and count(user_id)<=500)as pr
on cc.user_id=pr.user_id;

create table low_level_contrib
select cc.user_id, group_concat(cc.cc_cont,pr.pr_cont) from
(select user_id, group_concat(body)as cc_cont  from commit_comments group by user_id
having count(user_id)<500 and count(user_id)>10) as cc
inner join 
(select user_id, group_concat(body)as pr_cont from pull_request_comments group by user_id
having count(user_id)<2000 and count(user_id)>10)as pr
on cc.user_id=pr.user_id;