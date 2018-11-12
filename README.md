# elixir cool libs talk for BeamBA meetup

This is a basic Phoenix `Species App` :bird: :herb: done with :heart: 

## How to follow the talk:
 1. `git clone git@github.com:pbrudnick/elixir_cool_libs_talk.git` or just `fork` it!
 2. `git checkout <BRANCH_NAME>` for the desired topic of the talk
 3. Read the `README.md` of each branch to know the additions and more details.
 4. Run it!

## Branch logic
In the different branches I will be adding some cool libs to my app. 
Each branch will be incremental from the previous one in order to adding functionality to the app.

 * `base` - the base [`Phoenix`](https://github.com/phoenixframework/phoenix) with species endpoints
 * `guardian` - adds [`Guardian`](https://github.com/ueberauth/guardian) and [`Comeonin`/`Bcrypt`](https://github.com/riverrun/comeonin) for user/session
 * `cachex` - adds [`Cachex`](https://github.com/whitfin/cachex) for caching API responses
 * `external_service` - adds [`ExternalService`](https://github.com/jvoegele/external_service) for circuit breaker and rate limiter on API requests for specie observations
 * `logster` - adds [`Logster`](https://github.com/navinpeiris/logster) plug for HTTP logs
 * `master` - always the last version (`logster` branch for now)

## Run it!

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## HTML admin
### Creating a user:
`http://localhost:4000/admin/users/new`

### Species admin
`http://localhost:4000/admin/species`

## API REST Endpoints
### GET /api/species
`http://localhost:4000/api/species`

### GET /api/species/:id
`http://localhost:4000/api/species/:id`

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
