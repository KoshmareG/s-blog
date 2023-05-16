# S-Blog

S-Blog is an application for publishing and reading posts.

The application is built on Ruby 3.1.2 and Rails 7.0.4. PostgreSQL and Redis databases. RSpec is used for testing.

## Application start

To run the application, you will need an installed [Docker](https://docs.docker.com/engine/install/) and [Compose](https://docs.docker.com/compose/) plugin.

In the app folder, run

```
$ docker compose build
```

This command will load the necessary images. Next, run the application

```
$ docker compose up
```

At the first start, you need to create a database and run migrations. Open an additional terminal window and run from the application directory

```
$ docker compose exec web rails db:create
$ docker compose exec web rails db:migrate
```

Then build css and js

```
$ docker compose exec web yarn
$ docker compose exec web yarn build
$ docker compose exec web yarn build:css
```

Now the application is ready to work. In the browser, open

```
http://localhost:3000
```

At the following runs, you will only need to run `docker compose up`

## Stop app

To stop the application, run in the new terminal from the application directory

```
$ docker compose down
```
