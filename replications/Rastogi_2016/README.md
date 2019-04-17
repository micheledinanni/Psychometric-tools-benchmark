# # Psychometric tools (Rastogi 2016 replication) 

## 1. Connect to GHTorrent
```bash
Use SSH connection 
```
* `ssh -i ~/.ssh/key -L 3306:web.ghtorrent.org:3306 ghtorrent@web.ghtorrent.org -NnT`
## 2. Extract data from remote GHTorrent database
Use MySqlWorkbench
```yaml
 Export all tables in database ghtorrent
```
## 3. Import data in local database
Use MySqlWorkbench
```yaml
 Import in local database with name `personality`
```
Now contents are stored in database
## 4. Classification of users
* *Execution*:
    1. Open MySqlWorkbench software
    2. Import all scripts that are stored in `.../sql`
    3. Run .sql scripts
    4. Export data in file .json with user and relative comments
## 5. Use IBM Watson Personality Insights 
* *Setup*:
    Use Python
* *Execution*:
   Edit the following configuration file:
* `python/cfg/config.yml` - IBM Personality Insights API keys
```yaml
personality_insights:
  version : 'replace with your version'
  url: ****
  iam_apikey: ****
```
* Put file .json (step 4.4) in folder:
 `python/data`
 * Run `python/main.py`
## 6. Import in local database the output files of step 5
 Use MySqlWorkbench
```yaml
 Import in local database with name `personality`
```
Now contents are stored in database
## 7. Execute statistical tests
 * *Setup*:
    Use RStudio
 * *Execution*:
    Execute R files from `.../R`. 
    <strong>Notice: </strong>run first `connectTodb.R`
   
