import csv
import sys
import re
import hashlib
import jd_csv_common as jd


COLUMNS = {
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

def process(row):
    form_name = row[COLUMNS['FORM_NAME']]
    m = re.search(jd.judge_name_regex, form_name)
    first_name = ""
    last_name = ""

    if (m):
        first_name = m.group(2).lower()
        last_name = m.group(1).lower()

    new_row = [ hashlib.sha224(last_name.join(first_name)).hexdigest(),
               row[COLUMNS['LAST_NAME']].lower(),
               row[COLUMNS['FIRST_NAME']].lower(),
               row[COLUMNS['MIDDLE_NAME']].lower(),
               row[COLUMNS['AGENCY']].lower(),
               row[COLUMNS['DIVISION']].lower(),
               row[COLUMNS['POSITION']].lower(),
               row[COLUMNS['AGENCY_MULTI']].lower(),
               row[COLUMNS['POSITION_MULTI']].lower()]

    return [s.replace("--blank--", "").replace("--impossible--", "") for s in new_row]


def main():

    if len(sys.argv) != 2:
        print "No file specified"
        return

    with open(sys.argv[1], 'rb') as csvfile:
        spamreader = csv.reader(csvfile, delimiter=',')
        count = 0
        for row in spamreader:
            if (count != 0):
                new_row = process(row)
                print new_row
            count = count + 1

if __name__ == "__main__":
    main()
