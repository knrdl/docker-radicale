# docker-radicale

Docker Image for Radicale CalDAV server

## Setup 

### 1. Auth
Generate user password hashes: `htpasswd -nBC 10  username` (replace username). Save the hash values to a file called `users`, one per line.


### 2. Docker Compose
```yaml
version: '2.4'

services:
  radicale:
    image: ghcr.io/knrdl/docker-radicale
    volumes:
      - ./data:/data:rw
      - ./users:/users:ro
    ports:
      - "5232:5232"
    mem_limit: 300m
```

### 3. Create calendar

Bring the docker compose stack up and visit http://localhost:5232. Login with credentials from step 1.

### 4. Hardening

If you don't need the web interface to create calendars anymore, disable it:

```diff
  radicale:
    image: ghcr.io/knrdl/docker-radicale
+   command: --web-type=none
    volumes:
```
