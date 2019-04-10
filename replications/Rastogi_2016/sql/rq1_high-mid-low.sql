##########################commit comments & pull requests for the high contributors ###################
select user_id as id,group_concat(body)as content
 from commit_comments where user_id in (select user_id from high_level_contrib)group by user_id;

select user_id as id,group_concat(body)as content
 from pull_request_comments where user_id in (select user_id from high_level_contrib)group by user_id;
 
##########################commit comments & pull requests for the mid contributors ###################
select user_id as id,group_concat(body)as content
 from commit_comments where user_id in (select user_id from mid_level_contrib)group by user_id;
 

select user_id as id,group_concat(body)as content
 from pull_request_comments where user_id in (select user_id from mid_level_contrib)group by user_id;
 
##########################commit comments & pull requests for the low contributors ###################
select user_id as id,group_concat(body)as content
 from commit_comments where user_id in (select user_id from low_level_contrib)group by user_id;
 
 select user_id as id,group_concat(body)as content
 from pull_request_comments where user_id in (select user_id from low_level_contrib)group by user_id;
 
#############create tables################################################
create table cc_high(id int primary key, content longtext);
create table pr_high(id int primary key, content longtext);
create table cc_mid(id int primary key, content longtext);
create table pr_mid(id int primary key, content longtext);
create table cc_low(id int primary key, content longtext);
create table pr_low(id int primary key, content longtext);

#############concatenate pull-request-comments and commit-comments##########################
create table high_contribution
select cc_high.id,CONCAT_WS(', ', cc_high.content, concat(pr_high.content))as content 
 from cc_high left join pr_high on cc_high.id=pr_high.id;


create table mid_contribution
select cc_mid.id,CONCAT_WS(', ', cc_mid.content, concat(pr_mid.content))as content 
 from cc_mid left join pr_mid on cc_mid.id=pr_mid.id;
 

create table low_contribution
select cc_low.id,CONCAT_WS(', ',cc_low.content,concat(pr_low.content))as content 
from cc_low left join pr_low on cc_low.id=pr_low.id;

 
###############################output json
select * from low_contribution;
 