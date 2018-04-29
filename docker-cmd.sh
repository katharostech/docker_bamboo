#!/usr/bin/bash

trap "{ ${BAMBOO_INSTALL_DIR}/bin/stop-bamboo.sh; exit $?; }" SIGTERM SIGINT

# Run config for Bamboo
/bamboo-cfg.sh

# Start Bamboo
# ${BAMBOO_INSTALL_DIR}/bin/start-bamboo.sh -fg &
su -s /usr/bin/bash "${RUN_USER}" -c "${BAMBOO_INSTALL_DIR}/bin/start-bamboo.sh -fg ${ARGS}" &

# Loop until signal
while :
do
    sleep 4
done
