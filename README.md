# resin-boinc-server

You need to add following code to the start of the resin container:

```
#!/bin/bash
if [[ "$INITSYSTEM" == "on" ]]; then
	echo "RUNNING"
	cd boinc-server-docker && make build && make up
else
	echo "RUNNING"
	cd boinc-server-docker && make build && make up
fi

while true
do
	echo "App exited but container is still running to allow web terminal access"
	sleep 3600
done
```
