import csv
import json

csv_file = 'security_groups.csv'
json_file = 'security_groups_data.json'

data = []
with open(csv_file, newline='') as csvfile:
    reader = csv.DictReader(csvfile)
    for row in reader:
        data.append(row)

with open(json_file, 'w') as jsonfile:
    json.dump(data, jsonfile, indent=2)
