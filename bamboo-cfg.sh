# Set variables
SVRCONFIGLOC=${BAMBOO_INSTALL_DIR}/conf
SERVERFILE=${SVRCONFIGLOC}/server.xml
export JAVA_HOME=`cat /java_home.txt`

if [[ -n "${ssl_term_domain}" ]] ; then
    # Build proxy info
    PROXYNAME=${ssl_term_domain}
    PROXYPORT="443"
    SCHEME="https"

    var_name="PROXY"
    var_value="proxyName=\"${PROXYNAME}\" \nproxyPort=\"${PROXYPORT}\" \nscheme=\"${SCHEME}\""
    declare "$var_name=$var_value"

    ##
    # Insert proxy info
    # The result of the awk should look similar to the following
    # where proxyName is replaced with ${PROXYNAME} variable:
    ########
    ##    proxyName="bamboo.kadima.solutions"    -- Added by this script
    ##    secure="true"                          -- Added by this script
    ##    proxyPort="443"                        -- Added by this script
    ##    scheme="https"                         -- Added by this script
    ##    redirectPort="8443"                    -- Already present in file
    ########

    awk -v "var=${PROXY}" '/redirectPort/ && !x {print var; x=1} 1' ${SERVERFILE} > /tmp/tmp.xml && cp /tmp/tmp.xml ${SERVERFILE}
fi

if [[ -n "${JVM_MIN_MEM}" ]] ; then 
	sed -i  "s/JVM_MINIMUM_MEMORY=.*/JVM_MINIMUM_MEMORY=\"${JVM_MIN_MEM}\"/g" ${BAMBOO_INSTALL_DIR}/bin/setenv.sh
fi

if [[ -n "${JVM_MAX_MEM}" ]] ; then 
	sed -i  "s/JVM_MAXIMUM_MEMORY=.*/JVM_MAXIMUM_MEMORY=\"${JVM_MAX_MEM}\"/g" ${BAMBOO_INSTALL_DIR}/bin/setenv.sh
fi 

if [[ -n "${JVM_REQUIRED_ARGS}" ]] ; then 
	sed -i  "s|^JVM_REQUIRED_ARGS=.*|JVM_REQUIRED_ARGS=\"${JVM_REQUIRED_ARGS}\"|" ${BAMBOO_INSTALL_DIR}/bin/setenv.sh
fi 

# Import ROOT CERT if path provided
if [[ -n "${AUX_ROOT_CERT_1}" ]] ; then
	if [ ${BAMBOO_VERSION} = "5.4.2" ]; then
		keytool -noprompt -importcert -storepass changeit -keystore ${JAVA_HOME}/lib/security/cacerts -file ${AUX_ROOT_CERT_1} -alias AUX_ROOT_CERT_1
	else
		keytool -noprompt -importpass -storepass changeit -importcert -keystore ${JAVA_HOME}/lib/security/cacerts -file ${AUX_ROOT_CERT_1} -alias AUX_ROOT_CERT_1
	fi
fi

if [[ -n "${AUX_ROOT_CERT_2}" ]] ; then
	if [ ${BAMBOO_VERSION} = "5.4.2" ]; then
		keytool -noprompt -importcert -storepass changeit -keystore ${JAVA_HOME}/lib/security/cacerts -file ${AUX_ROOT_CERT_2} -alias AUX_ROOT_CERT_2
	else
		keytool -noprompt -importpass -storepass changeit -importcert -keystore ${JAVA_HOME}/lib/security/cacerts -file ${AUX_ROOT_CERT_2} -alias AUX_ROOT_CERT_2
	fi
fi

if [[ -n "${AUX_ROOT_CERT_3}" ]] ; then
	if [ ${BAMBOO_VERSION} = "5.4.2" ]; then
		keytool -noprompt -importcert -storepass changeit -keystore ${JAVA_HOME}/lib/security/cacerts -file ${AUX_ROOT_CERT_3} -alias AUX_ROOT_CERT_3
	else
		keytool -noprompt -importpass -storepass changeit -importcert -keystore ${JAVA_HOME}/lib/security/cacerts -file ${AUX_ROOT_CERT_3} -alias AUX_ROOT_CERT_3
	fi
fi

if [[ -n "${AUX_ROOT_CERT_4}" ]] ; then
	if [ ${BAMBOO_VERSION} = "5.4.2" ]; then
		keytool -noprompt -importcert -storepass changeit -keystore ${JAVA_HOME}/lib/security/cacerts -file ${AUX_ROOT_CERT_4} -alias AUX_ROOT_CERT_4
	else
		keytool -noprompt -importpass -storepass changeit -importcert -keystore ${JAVA_HOME}/lib/security/cacerts -file ${AUX_ROOT_CERT_4} -alias AUX_ROOT_CERT_4
	fi
fi

if [[ -n "${AUX_ROOT_CERT_5}" ]] ; then
	if [ ${BAMBOO_VERSION} = "5.4.2" ]; then
		keytool -noprompt -importcert -storepass changeit -keystore ${JAVA_HOME}/lib/security/cacerts -file ${AUX_ROOT_CERT_5} -alias AUX_ROOT_CERT_5
	else
		keytool -noprompt -importpass -storepass changeit -importcert -keystore ${JAVA_HOME}/lib/security/cacerts -file ${AUX_ROOT_CERT_5} -alias AUX_ROOT_CERT_5
	fi
fi


# Import INTERMEDIATE CERT if path provided

if [[ -n "${AUX_INTER_CERT_1}" ]] ; then
	if [ ${BAMBOO_VERSION} = "5.4.2" ]; then
	       	keytool -noprompt -importcert -storepass changeit -keystore ${JAVA_HOME}/lib/security/cacerts -file ${AUX_INTER_CERT_1} -alias AUX_INTER_CERT_1
	else
		keytool -noprompt -importpass -storepass changeit -importcert -keystore ${JAVA_HOME}/lib/security/cacerts -file ${AUX_INTER_CERT_1} -alias AUX_INTER_CERT_1
	fi
fi

if [[ -n "${AUX_INTER_CERT_2}" ]] ; then
	if [ ${BAMBOO_VERSION} = "5.4.2" ]; then
	       	keytool -noprompt -importcert -storepass changeit -keystore ${JAVA_HOME}/lib/security/cacerts -file ${AUX_INTER_CERT_2} -alias AUX_INTER_CERT_2
	else
		keytool -noprompt -importpass -storepass changeit -importcert -keystore ${JAVA_HOME}/lib/security/cacerts -file ${AUX_INTER_CERT_2} -alias AUX_INTER_CERT_2
	fi
fi

if [[ -n "${AUX_INTER_CERT_3}" ]] ; then
	if [ ${BAMBOO_VERSION} = "5.4.2" ]; then
	       	keytool -noprompt -importcert -storepass changeit -keystore ${JAVA_HOME}/lib/security/cacerts -file ${AUX_INTER_CERT_3} -alias AUX_INTER_CERT_3
	else
		keytool -noprompt -importpass -storepass changeit -importcert -keystore ${JAVA_HOME}/lib/security/cacerts -file ${AUX_INTER_CERT_3} -alias AUX_INTER_CERT_3
	fi
fi

if [[ -n "${AUX_INTER_CERT_4}" ]] ; then
	if [ ${BAMBOO_VERSION} = "5.4.2" ]; then
	       	keytool -noprompt -importcert -storepass changeit -keystore ${JAVA_HOME}/lib/security/cacerts -file ${AUX_INTER_CERT_4} -alias AUX_INTER_CERT_4
	else
		keytool -noprompt -importpass -storepass changeit -importcert -keystore ${JAVA_HOME}/lib/security/cacerts -file ${AUX_INTER_CERT_4} -alias AUX_INTER_CERT_4
	fi
fi

if [[ -n "${AUX_INTER_CERT_5}" ]] ; then
	if [ ${BAMBOO_VERSION} = "5.4.2" ]; then
	       	keytool -noprompt -importcert -storepass changeit -keystore ${JAVA_HOME}/lib/security/cacerts -file ${AUX_INTER_CERT_5} -alias AUX_INTER_CERT_5
	else
		keytool -noprompt -importpass -storepass changeit -importcert -keystore ${JAVA_HOME}/lib/security/cacerts -file ${AUX_INTER_CERT_5} -alias AUX_INTER_CERT_5
	fi
fi
