# Post Database for PostHoop
> cbarange | 07th Junuary 2021
---

# Get Started

## Docker

```bash
mkdir data

# - Login : posthoop | Pwd : Epsi2020! | DB : posthoop | SCHEMA : posthoop - 

# Post Database
sudo docker build -t posthoop_db_post:0.1 .
sudo docker run --name posthoop_db_post -it --rm -p 5450:5432 \
-e POSTGRES_PASSWORD=Epsi2020! \
-e POSTGRES_USER=postgres \
-e POSTGRES_DB=postgres \
-v `pwd`/data:/var/lib/postgresql/data \
posthoop_db_post:0.1

# - Test inserted data -
sudo docker exec posthoop_db_post su - postgres -c "psql -A -d posthoop -c \"select * from posthoop.post\""
sudo docker exec posthoop_db_post su - postgres -c "psql -A -d posthoop -c \"select P.text as post, C.text as comment from posthoop.post as P, posthoop.comment as C where C.uid_post=P.uid\""


# Remove all docker container
sudo docker ps -a | cut -f 1 -d" " | sudo xargs -L 1 docker rm
# Remoce all docker image
sudo docker images | xargs -L 1 | cut -f 3 -d" " | sudo xargs -L 1 docker image rm
```

## OnPremise without docker

```bash
sudo apt update && sudo apt upgrade -y
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt install postgresql postgresql-contrib -y
service postgresql start

sudo -u postgres psql --version
sudo -u postgres psql -t -A -f drop_posthoop.sql # Drop Database User
sudo -u postgres psql -t -A -f ddl_posthoop.sql # Create User Database Schema Table Constraint
sudo -u postgres psql -t -A -f dml_posthoop.sql # Init sample data

# Test inserted data
sudo -u postgres psql -t -A -d posthoop -c "select fullname from posthoop.user"
sudo -u postgres psql -t -A -d posthoop -c "select P.text, C.text from posthoop.post as P, posthoop.comment as C where C.uid_post=P.uid"
```
