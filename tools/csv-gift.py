import csv
import sys
import re
import hashlib
import jd_csv_common as jd

COLUMNS = {
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

def process(row, item):
    form_name = row[COLUMNS['FORM_NAME']]
    first_name = ""
    last_name = ""
    m = re.search(jd.judge_name_regex, form_name)

    if (m):
        first_name = m.group(2)
        last_name = m.group(1)


    new_row = [row[COLUMNS['DATE' + str(item)]],\
            row[COLUMNS['VAL' + str(item)]],\
            row[COLUMNS['DESC' + str(item)]],\
            row[COLUMNS['SOURCE']],\
            row[COLUMNS['BUSINESS']],\
            last_name,
            first_name,
            hashlib.sha224(last_name.join(first_name)).hexdigest() ]

    return [s.replace("--blank--", "").replace("--impossible--", "") for s in new_row]


def main():
    if len(sys.argv) != 2:
        print "No file specified"
        return

    with open(sys.argv[1], 'rb') as csvfile:
        spamreader = csv.reader(csvfile, delimiter=',')
        count = 0
        for row in spamreader:
            for i in range(1,4):
                if row[COLUMNS['DESC' + str(i)]].strip() != "--blank--":
                    new_row = process(row, i)
                    print new_row

if __name__ == "__main__":
    main()
