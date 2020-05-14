#### docker-compose.yaml

```yaml
version: '2'
services:

  bugzilla-db:
    container_name: bugzilla-db
    image: postgres:10
    restart: always
    ports:
      - 5432:5432
    volumes:
       - ./bugzilla-db:/var/lib/postgresql/data
    environment:
      POSTGRES_DB: "bugs"
      POSTGRES_USER: "bugs"
      POSTGRES_PASSWORD: "bugs"

  bugzilla-svc:
    container_name: bugzilla-svc
    image: bxwill/bugzilla:5.0.6
    restart: always
    ports:
      - 80:80
      - 443:443
    environment:
      BUGZILLA_ADMIN_EMAIL: "administrator@bugzilla.local"
      BUGZILLA_ADMIN_NAME: "administrator"
      BUGZILLA_ADMIN_PASS: "baoxian-sz"
      BUGZILLA_DB_HOST: "bugzilla-db"
      BUGZILLA_DB_PORT: "5432"
      BUGZILLA_DB_NAME: "bugs"
      BUGZILLA_DB_USER: "bugs"
      BUGZILLA_DB_PASS: "bugs"
    depends_on:
      - bugzilla-db
```

#### access bugzilla

Waiting for bugzilla container healthy

http://localhost/bugzilla
