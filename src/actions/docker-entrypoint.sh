#!/bin/bash
set -e
echo "[ ****************** ] Starting Endpoint of Application"
if ! [ -d "/var/www/simec" ] || ! [ -d "/var/www/simec/includes" ]; then
    echo "Application not found in /var/www/simec - cloning now..."
    if [ "$(ls -A /var/www/simec)" ]; then
        echo "WARNING: /var/www/simec is not empty - press Ctrl+C now if this is an error!"
        ( set -x; ls -A; sleep 5 )
    fi
    echo "[ ****************** ] Cloning Project repository to tmp folder"
    git clone -b "simec" https://github.com/culturagovbr/siminc2 /tmp/simec
    ls -la /tmp/simec

    echo "[ ****************** ] Copying Project from temporary folder to workdir"
    cp /tmp/simec -R /var/www/

    chown www-data:1000 -R /var/www/simec
    ls -la /var/www/simec

    echo "[ ****************** ] Complete! The application has been successfully copied to /var/www/simec"

    cd /var/www/simec
fi

if  ! [ -e "/var/www/simec/global/config.inc" ] ; then

    echo "[ ****************** ] Copying sample application configuration to real one"
    cp /var/www/simec/global/config-exemplo.inc /var/www/simec/global/config.inc
    cp /var/www/simec/global/database-exemplo.php /var/www/simec/global/database.php
    chown www-data:1000 -R /var/www/simec/global
    ls -la /var/www/simec/global

    echo "[ ****************** ] Show database configuration! To modify configuration: $ vim simec/global/database.php"
    cat /var/www/simec/global/database.php
fi

echo "[ ****************** ] Ending Endpoint of Application"
exec "$@"
