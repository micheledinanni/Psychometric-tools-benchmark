create table reporters_pr
select * from (
select pull_request_comments.user_id as id,group_concat(body)as content,commit_id from reporters inner join pull_request_comments
 on pull_request_comments.pull_request_id=reporters.pull_request_id group by user_id)as x
 inner join
 (select us1 from activeusers)as y on x.id = y.us1;
  
create table reviewers_pr
select * from 
(select pull_request_comments.user_id as id,group_concat(body)as content,commit_id from reviewers inner join pull_request_comments
 on pull_request_comments.pull_request_id=reviewers.pull_request_id group by user_id)as x
 inner join
 (select us1 from activeusers)as y on x.id = y.us1;

create table cc_reporters
select user_id as id, group_concat(body)as content from reporters_pr inner join commit_comments 
on commit_comments.commit_id=reporters_pr.commit_id group by user_id;

create table cc_reviewers
select user_id as id, group_concat(body)as content from reviewers_pr 
inner join commit_comments on commit_comments.commit_id=reviewers_pr.commit_id group by user_id;

select * from cc_reporters;
select * from reporters_pr;

select reporters_pr.id,CONCAT_WS(', ', cc_reporters.content, concat(reporters_pr.content))as content 
 from cc_reporters right join reporters_pr on cc_reporters.id=reporters_pr.id;

select reviewers_pr.id,CONCAT_WS(', ', cc_reviewers.content, concat(reviewers_pr.content))as content 
 from cc_reviewers right join reviewers_pr on cc_reviewers.id=reviewers_pr.id;










