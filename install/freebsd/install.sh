#!/bin/sh
IO_USER=iobroker
NODE=`which node`

## if iobroker.sh not exists. Copy it
if [ ! -f "/usr/local/rc.d/iobroker" ]; then
    cp @@PATH@@../iobroker/install/freebsd/iobroker /usr/local/etc/rc.d/iobroker
fi
if [ ! -f "/usr/local/bin/iobroker" ]; then
    echo '${NODE} @@PATH@@iobroker.js $1 $2 $3 $4 $5' > /usr/local/bin/iobroker
fi

#Set rights
echo "Set permissions..."
chmod 755 /usr/local/etc/rc.d/iobroker
chmod 755 /usr/local/bin/iobroker

#Replace user iobroker with current user
sed -i -e "s/IOBROKERUSER=.*/IOBROKERUSER=$IO_USER/" /usr/local/etc/rc.d/iobroker
NODE=${NODE//\//\\/}
sed -i -e s/NODECMD=.*/NODECMD=$NODE/ /usr/local/etc/rc.d/iobroker
chown root:root /usr/local/etc/rc.d/iobroker
sysrc iobroker_enable=YES

# Start the service!
echo "Start iobroker..."
service iobroker start
echo "call http://ip_address:8081/ in browser to get the AdminUI of ioBroker"

