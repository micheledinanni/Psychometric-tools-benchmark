from __future__ import print_function
import json, os, yaml
from os.path import join, dirname
from watson_developer_cloud.personality_insights_v3 import PersonalityInsightsV3


# PersonalityInsightsV3 config
def pers_ins_config():
    with open(os.path.join("cfg", "config.yml"), "r") as ymlfile:
        cfg = yaml.load(ymlfile)['personality_insights']
    return cfg


# authentication API
service = PersonalityInsightsV3(
    version=pers_ins_config().__getitem__('version'),
    url=pers_ins_config().__getitem__('url'),
    iam_apikey=pers_ins_config().__getitem__('iam_apikey'))

with open(join(dirname(__file__), 'not_project_members (1).json'), encoding='utf8') as \
        profile_json:
    data = json.load(profile_json)
    for i in data["contentItems"]:
        try:
            #take only comments with number of words >=100
            if len(i["content"].split()) >= 100:
                aux = {
                    "contentItems": [
                        i
                    ]
                }
                profile = service.profile(
                    aux,
                    content_type='application/json',
                    raw_scores=True,
                    consumption_preferences=False).get_result()
                with open("users_personality/proj-nonproj/nonproj/{0}_personality.json".format(i["id"]), "w")as fp:
                    json.dump(profile, fp, indent=2)
            profile_json.close()
        except Exception:
            pass
