Port: 19999

---

mkdir /opt/installers
cd /opt/installers
curl https://my-netdata.io/kickstart.sh -o netdata-kickstart.sh
chmod 700 netdata-kickstart.sh
./netdata-kickstart.sh --dont-wait --non-interactive

