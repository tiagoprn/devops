import os

influx_password = os.environ.get('INFLUX_PASSWORD', '{{ influx_password.stdout }}')
influx_host_ip = os.environ.get('INFLUX_HOST_IP', '{{ ansible_eth0.ipv4.address }}')

with open('04.data_sources.sql', 'r') as input_file, open('04.data_sources.sql.j2', 'w') as output_file:
    for line in input_file.readlines():
        if not line.startswith('INSERT INTO'):
            output_file.write(line)
        else:
            words = line.split()
            influx_url = words[10]

            splitted_url = influx_url.split(':')

            password_and_host_ip = splitted_url[2]

            template_vars = '{}@{}'.format(influx_password, influx_host_ip)
            splitted_url[2] = template_vars

            new_url = ':'.join(splitted_url)

            words[10] = new_url

            new_line = ' '.join(words)+'\n'
            output_file.write(new_line)

