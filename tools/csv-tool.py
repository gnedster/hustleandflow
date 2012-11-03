import csv
import sys
import re
import hashlib
import jd_csv_common as jd

COLUMNS_GIFT = {
    'FORM_NAME' : 0,
    'SOURCE' : 1,
    'ADDRESS' : 3,
    'BUSINESS' : 5,
    'DATE1' : 7,
    'VAL1' : 9,
    'DESC1' : 11,
    'DATE2' : 13,
    'VAL2' : 15,
    'DESC2' : 17,
    'DATE3' : 19,
    'VAL3' : 21,
    'DESC3' : 23,
}

COLUMNS_JUDGE = {
    'FORM_NAME' : 0,
    'LAST_NAME' : 2,
    'FIRST_NAME' : 4,
    'MIDDLE_NAME' : 6,
    'AGENCY' : 8,
    'DIVISION' : 10,
    'POSITION' : 12,
    'AGENCY_MULTI' : 14,
    'POSITION_MULTI' : 16,
}

# map judge hash to judge id
judge_map = {}

# map donor hash to donor id
donor_map = {}

def process_judge_row(row):
    form_name = row[COLUMNS_JUDGE['FORM_NAME']]
    m = re.search(jd.judge_name_regex, form_name)
    first_name = ""
    last_name = ""

    if (m):
        first_name = m.group(2).lower().strip()
        last_name = m.group(1).lower().strip()

    judge_hash = hashlib.md5(last_name.join(first_name).encode("utf8")).hexdigest()
    if (judge_hash not in judge_map):
        judge_map[judge_hash] = len(judge_map)
    #print judge_hash, " : ", judge_map[judge_hash]

    row = [re.sub(",", "", s) for s in row]
    row = [re.sub("\n", "", s) for s in row]
    new_row = [ str(judge_map[judge_hash]),
               row[COLUMNS_JUDGE['LAST_NAME']].lower(),
               row[COLUMNS_JUDGE['FIRST_NAME']].lower(),
               row[COLUMNS_JUDGE['MIDDLE_NAME']].lower(),
               row[COLUMNS_JUDGE['AGENCY']].lower(),
               row[COLUMNS_JUDGE['DIVISION']].lower(),
               row[COLUMNS_JUDGE['POSITION']].lower(),
               #row[COLUMNS_JUDGE['AGENCY_MULTI']].lower(),
               #row[COLUMNS_JUDGE['POSITION_MULTI']].lower()
              ]

    return [s.replace("--blank--", "").replace("--impossible--", "") for s in new_row]

def process_gift_row(row, item):
    form_name = row[COLUMNS_GIFT['FORM_NAME']]
    first_name = ""
    last_name = ""
    m = re.search(jd.judge_name_regex, form_name)

    if (m):
        first_name = m.group(2).lower().strip()
        last_name = m.group(1).lower().strip()

    judge_hash = hashlib.md5(last_name.join(first_name).encode("utf8")).hexdigest()
    #print "GIFT", judge_hash, " : ", judge_map[judge_hash]

    judge_id = -1
    if (judge_hash in judge_map):
        judge_id = judge_map[judge_hash]
    else:
        print "ERROR: Unknown judge: ", last_name, ",", first_name
    
    source = row[COLUMNS_GIFT['SOURCE']].lower()
    donor_hash = hashlib.md5(source.encode("utf8")).hexdigest()
    donor_id = -1
    
    source = re.sub(",", "", source)
    business = re.sub(",", "", row[COLUMNS_GIFT['BUSINESS']].lower())
    if donor_hash in donor_map:
        donor_id = donor_map[donor_hash][0]
    else:
        donor_id = len(donor_map)
        donor_map[donor_hash] = [str(donor_id), source, business]

    row = [re.sub(",", "", s) for s in row]
    row = [re.sub("\n", "", s) for s in row]
    new_row = [row[COLUMNS_GIFT['DATE' + str(item)]].lower(),
               row[COLUMNS_GIFT['VAL' + str(item)]].lower(),
               row[COLUMNS_GIFT['DESC' + str(item)]].lower(),
               str(donor_id),
               #last_name,
               #first_name,
               str(judge_id)
            ]

    return [s.replace("--blank--", "").replace("--impossible--", "") for s in new_row]

def process_cover(cover_in):
    with open(cover_in, 'rb') as csvfile:
        cover_out = open("cover-fixed.csv", "w")
        reader = csv.reader(csvfile, delimiter=',')
        count = 0
        for row in reader:
            if (count != 0):
                new_row = process_judge_row(row)
                print new_row
                cover_out.write(', '.join(new_row))
                cover_out.write("\n")
            count = count + 1
        cover_out.close()

def process_gift(gift_in):
    with open(gift_in, 'rb') as csvfile:
        gift_out = open("gift-fixed.csv", "w")
        reader = csv.reader(csvfile, delimiter=',')
        count = 0
        for row in reader:
            for i in range(1,4):
                if row[COLUMNS_GIFT['DESC' + str(i)]].strip() != "--blank--":
                    new_row = process_gift_row(row, i)
                    print new_row
                    gift_out.write(', '.join(new_row))
                    gift_out.write("\n")
        gift_out.close()

def main():
    if len(sys.argv) != 3:
        print "Insufficient arguments: cover.csv gifts.csv"
        return

    g_judge_count = 0
    g_donor_count = 0
    process_cover(sys.argv[1])
    process_gift(sys.argv[2])

    donor_out = open("donor-fixed.csv", "w")
    for donor in donor_map:
            print donor_map[donor]
            donor_out.write(', '.join(donor_map[donor]))
            donor_out.write("\n")
    donor_out.close()



if __name__ == "__main__":
    main()
