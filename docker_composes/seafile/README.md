# To make a clean install: 

- Remove the folder /mnt/EXT5TH/docker/seafile. 
- Uncomment the command "/init" from the docker-compose.yml
- Run docker-compose up 

# To upgrade the install
- Backup the folder /mnt/EXT5TH/docker/seafile. 
- Uncomment the command "/upgrade" from the docker-compose.yml
- Run docker-compose up 

# Garbage collection (remove deleted files) 
- Backup the folder /mnt/EXT5TH/docker/seafile. 
- Uncomment the command "/clean" from the docker-compose.yml
- Run docker-compose up 

# How to access the WebUI: 

http://192.168.1.200:10000

# How to enable downloads / uploads: 

Logged as the admin user, go to the upper right corner of your profile picture on the web interface, and click on "System Admin".
On the sidebar, click on "Settings". 

Change SERVICE_URL to: http://192.168.1.200:10000
Change FILE_SERVER_ROOT to: http://192.168.1.200:10000/seafhttp 

(on the config above, I configured the IP and PORT from which the container was redirected to to access the seafile Web UI.)

