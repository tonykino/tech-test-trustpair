Lien du site en production : https://tech-test-trustpair.herokuapp.com/

Setup le projet en local :
- Cloner le repo et se cd dedans
- `bundle`
- `docker-compose up dependencies`
- `rails db:create db:migrate`
- `rails s`
- Dans un autre terminal : `sidekiq -C config/sidekiq.yml`
- Done !
