import os

with open('07.queries.sql', 'r') as input_file, open('07.queries.sql.patched', 'w') as output_file:
    for line in input_file.readlines():
        if not line.startswith('INSERT INTO'):
            output_file.write(line)
        else:
            words = line.split()
            words[12] = 'NULL,'
            new_line = ' '.join(words)+'\n'
            output_file.write(new_line)


os.rename('07.queries.sql', '07.queries.sql.ORIGINAL')
os.rename('07.queries.sql.patched', '07.queries.sql')

