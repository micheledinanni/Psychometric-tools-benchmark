######commitcomments project/not project members
select user_id as id,group_concat(body)as content
 from commit_comments where user_id in (select author_id from project_members)group by user_id;
 
 select user_id as id,group_concat(body)as content
 from commit_comments where user_id in (select author_id from not_project_members)group by user_id;


######pull_requests_comments projectmembers/noprojectmember
select user_id as id,group_concat(body)as content
 from pull_request_comments where user_id in (select author_id from project_members)group by user_id;
 
 select user_id as id,group_concat(body)as content
 from pull_request_comments where user_id in (select author_id from not_project_members)group by user_id;
  
create table cc_proj_memb(id int primary key,content longtext);
create table cc_not_proj_memb(id int primary key,content longtext);
create table pr_proj_memb(id int primary key,content longtext);
create table not_proj_memb_pr(id int primary key,content longtext);


#############concatenate pull-request-comments and commit-comments##########################
create table proj_memb
select cc_proj_memb.id,CONCAT_WS(', ', cc_proj_memb.content, concat(pr_proj_memb.content))as content 
 from cc_proj_memb left join pr_proj_memb on cc_proj_memb.id=pr_proj_memb.id;


create table not_proj_memb
select cc_not_proj_memb.id,CONCAT_WS(', ', cc_not_proj_memb.content, concat(not_proj_memb_pr.content))as content 
 from cc_not_proj_memb left join not_proj_memb_pr on cc_not_proj_memb.id=not_proj_memb_pr.id;
 
#select active projmemb/notprojmemb
create table active_pr_memb 
select id, content from proj_memb inner join activeusers on id=user_id;

create table active_pr_not_memb 
select id, content from not_proj_memb inner join activeusers on id=user_id;

#export as json
select * from active_pr_memb having length(content)>3000;
select * from active_pr_not_memb having length(content)>3000;
