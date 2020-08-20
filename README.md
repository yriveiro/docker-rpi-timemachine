# Docker Time Machine

macOS Time Machine on docker over SMB protocol built to run on a Raspberry pi.

# TL;DR

Edit `docker-compose.yml` file and replace `<your host path>` with the path
where you want to save the Time Machine data, save it and run:

```sh
docker-compose up -d
```

# Use

This Docker is intent to work with the minimal configuration needed.

Replace `<your host path>` for the path of the volume you want to use to store
the backups

```yaml
version: "3"
services:
  timemachine:
    network_mode: "host"
    restart: unless-stopped
    ports:
      - "137:137/udp"
      - "138:138/udp"
      - "139:139"
    volumes:
      - <your host path>:/opt/timemachine"
    ulimits:
      nofile:
        soft: 65536
        hard: 65536
    container_name: rpi-timemachine
    image: yriveiro/timemachine:1.0.0
    env_file:
      - timemachine.env
```

You can tweak other params in the timemachine.env file. The configuration was
thought with sanity defaults in mind and probably the only param you should
change is the `VOLUME_SIZE_LIMIT` if you want to limit the size of the SMB
share for example 400G.

# License

MIT
