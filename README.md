# Docker image to determine external IP and push it to Pushover for ARM

This Docker image is based on the minimal Alpine Linux with simple script to determine external IP address and push it to pushover.
Script will push message only when IP address was changed.

# Environment Variables:

`INTERVAL` - default value is 1800 [ in seconds ]
`PUSHOVER_PRIORITY` - default value is 1
`PUSHOVER_TOKEN` - token for pushover  
`PUSHOVER_USER` - pushover username  


# Create an instance
```
docker run -it --name check-ip -e INTERVAL=1800 -e PUSHOVER_PRIORITY=1 -e PUSHOVER_TOKEN=1234567890 -e PUSHOVER_USER=1234567890 sepludowski/docker-check-ip-pushover-arm
```

# Docker compose example
```
mysql:
  image: sepludowski/docker-check-ip-pushover-arm
  environment:
    INTERVAL: 1800
    PUSHOVER_PRIORITY: 1
    PUSHOVER_TOKEN: 1234567890
    PUSHOVER_USER: 1234567890
  restart: always
```

# Links

[Alpine Linux](https://alpinelinux.org "Alpine Linux")  
[Pushover](https://pushover.net "Pushover")
