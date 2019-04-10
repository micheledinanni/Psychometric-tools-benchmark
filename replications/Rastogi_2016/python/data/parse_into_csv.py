import os, json, csv, math

"""
for filename in os.listdir('../users_personality/active_commit_comments'):
    with open('../users_personality/{0}'.format(filename), "r", encoding='utf-8-sig') as fp1:
        data = json.load(fp1)
        data["personality"]
        fp1.close()
    with open("../users_personality/cleaned/{0}".format(filename), "w", encoding='utf-8-sig') as fp2:
        json.dump(data, fp2, indent=2)
        fp2.close()



# Open the CSV
with open('../out.csv', 'r', encoding='utf-8-sig') as f:
    reader = csv.DictReader(f)
    rows = list(reader)
with open('test.json','w') as f:
    json.dump(rows,f)"""


def init():
    with open("../users_personality/reputation/low.csv", "w")as csvFile:
        row = ['user_id', 'O', 'C', 'E', 'A', 'N']
        writer = csv.writer(csvFile)
        writer.writerow(row)
    csvFile.close()

def parsing():
    for filename in os.listdir('../users_personality/reputation/low'):
        with open("../users_personality/reputation/low/{0}".format(filename), "r", encoding='utf-8-sig')as fp:
            data = json.load(fp)
            with open("../users_personality/reputation/low.csv", "a") as f1:
                for i in range(0, 5):
                    openness = '%.3f' % data["personality"][0]["raw_score"]
                    conscientiousness = '%.3f' % data["personality"][1]["raw_score"]
                    extraversion = '%.3f' % data["personality"][2]["raw_score"]
                    agreeableness = '%.3f' % data["personality"][3]["raw_score"]
                    neuroticism = '%.3f' % data["personality"][4]["raw_score"]
                    temp = [int(s) for s in filename.split('_') if s.isdigit()]
                    user_id = ",".join(repr(e) for e in temp)
                writer = csv.writer(f1)
                writer.writerow([user_id,openness,conscientiousness,extraversion,agreeableness,neuroticism])
        fp.close()


if __name__ == '__main__':
    init()
    parsing()