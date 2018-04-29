# Build the version specific image
Building this image requires that you pass a version of the Bamboo binary to the build command.  This version must be supported by the Docker image. 
The same version of the Bamboo binary used (6.4.1 as in the example below), should be used to tag the Docker image produced.  Additional tags may be added as needed after the initial image is built.

```bash
docker build --build-arg BAMBOO_VERSION=6.4.1 -t kadimasolutions/bamboo:6.4.1 .
```

# Run the container
Running the container can be done as follows:

```bash
docker run -h bamboo \
--name bamboo \
-v live-bambdev-home:/app/bamboo-home:z \
-e JVM_REQUIRED_ARGS="-Duser.timezone=America/Chicago" \
-e ssl_term_domain="bamboo.kadima.solutions" \
-e nfs_mount_home_cmd=mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 my.nfshost.com:/live-bambdev-home /app/bamboo-home
-p 8085:8085 \
-dt kadimasolutions/bamboo:6.4.1
```

# Environment Variables

## live-bambdev-home
This is the volume that will be referenced by the nfs mount command.

## ssl_term_domain
This environment variable is used when setting up your server with SSL Termination.  Bamboo needs to know what domain your server is listening on for port 443 traffic.  This assumes that all other measures, such as certification and network routing is already in place for proper SSL Termination.  Providing this environment variable injects the appropriate proxy information into the server configuration to properly serve terminated traffic.  This setup does NOT support SSL Offloading where the Bamboo server itself is setup to translate the encrypted SSL traffic.

## NFS Mount commands
These NFS commands should be used instead of the volume mounts if the system is using NFS to store the data.  You cannot use both the volume mounts and the NFS mount commands.  The NFS devices need to be mounted to the container locations that are referenced in the example.  These locations support the application's persisted data.

## JVM_REQUIRED_ARGS
This environment variable can be used to specify the Timezone of the managing personnel. Since there is no defined default value for this variable in Dockerfile, a value must be specified at runtime for this variable.  Same applies for any environment variables with undefined default values in Dockerfile.

## JVM_MIN_MEM
The default value for this environment variable specified in Dockerfile is "1g". The minimum memory value can be overridden at runtime by passing the desired value to the variable according to the user's requirements.

## JVM_MAX_MEM
The default value for this environment variable specified in Dockerfile is "4g". The maximum memory value can be overridden at runtime by passing the desired value to the variable according to the user's requirements. For instance in a DEV environment, you may want to run with a maximum memory of "1g" instead of "4g".

## AUX_ROOT_CERT_1
The location where to copy the ROOT certificate into the Bamboo container can be specified using this variable.  If you have mutliple ROOT certificates, you can add AUX_ROOT_CERT_2 and so on, up to AUX_ROOT_CERT_5 and specify the path values.

## AUX_INTER_CERT_1
The location where to copy the INTERMEDIATE certificate into the Bamboo container can be specified using this variable.  If you have mutliple INTERMEDIATE certificates, you can add AUX_INTER_CERT_2 and so on, up to AUX_INTER_CERT_5 and specify the path values.

# Volume Mounts
In the case that you are using named volumes or host mounts, the volume commands in the example should be used.  Note that these volume mounts should not be used in conjunction with the NFS Mount Command environment variables as they serve the same purpose through different methods.  You must use one or the other depending on your system setup.

