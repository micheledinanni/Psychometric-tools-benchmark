import csv
import json
import os

for filename in os.listdir('../users_personality'):
    print(filename)
    with open('../users_personality/{0}'.format(filename), "r", encoding='utf-8-sig') as fp1:
        data = json.load(fp1)
        for i in range(0, 5):
            del data["personality"][i]["children"]
        del data["needs"]
        del data["values"]
        del data["consumption_preferences"]
        del data["warnings"]
        fp1.close()
    with open("../users_personality/cleaned/{0}".format(filename), "w", encoding='utf-8-sig') as fp2:
        json.dump(data, fp2, indent=2)
        fp2.close()



# Open the CSV
with open('../out.csv', 'r', encoding='utf-8-sig') as f:
    reader = csv.DictReader(f)
    rows = list(reader)
with open('test.json','w') as f:
    json.dump(rows,f)



# Parse the CSV into JSON
out = json.dumps([row for row in reader])
print("JSON parsed!")
# Save the JSON
f = open('parsed.json', 'w')
f.write(out)
print("JSON saved!")

with open('test.json','r',encoding='utf-8-sig')as p:
    data = json.load(p)
    print(data[0])

