# Select top 100 repositories on issue's comments count
create table repoOnIss
select repo_id
,count(*) activityCount # total count of issue comments
from issues
group by repo_id
order by count(*) desc
limit 100;

# Select top 100 repositories on pull request's comments count
create table repoOnPR
select base_repo_id as repo_id
,count(*) activityCount # total count of pull request comments
from pull_requests
group by base_repo_id
order by count(*) desc
limit 100;

# Select top 100 repositories on commit's comments count
drop table if exists repoOnCom;
create table repoOnCom
select project_id as repo_id
,count(*) activityCount # total count of commit's comments count
from commits
group by project_id
order by count(*) desc
limit 100;

##########################
# Aggregation of selected top repositories based on issues', pull requests' and commits' comments count
drop table if exists selectedRepos;
create table selectedRepos
select repo_id
from repoOnIss
union
select repo_id
from repoOnPR
union
select repo_id
from repoOnCom; # 230 repositories were selected
