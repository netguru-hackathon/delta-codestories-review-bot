# CodestoriesReviewBot

## :notebook: Description

Our awesome bot to trade Codestories drafts! 🚀

## :closed_lock_with_key: Technology

| Name |  Version |
| :--: | :---: |
| [Elixir](https://elixir-lang.org/) | 1.7.4 |
| [Phoenix](https://phoenixframework.org/) | 1.4.0 |
| [PostgreSQL](http://www.postgresql.org/) | 10.6 |

## :hammer: Setup

### :information_source: Installing dependencies

* Install Elixir for MacOS X

```
brew update
brew install elixir
elixir -v
brew upgrade elixir # use if if the previous steps returns version below 1.4
```

* Install Hex - Dependencies Manager

```
mix local.hex
```

* Install all dependencies used by the Project

```
$ cd codestories-review-bot
$ mix deps.get
```

### :pencil: Default configuration

Define local values for the environment variables defined in `config\dev.exs` file.

### :rocket: Running server on the local machine

Then configure your database in config/dev.exs and run:

```
$ mix ecto.create
```

Start your Phoenix app with:

```
$ mix phx.server
```

You can also run your app inside IEx (Interactive Elixir) as:

```
$ iex -S mix phx.server
```

You should be able to visit the page using [`localhost:4000`](http://localhost:4000) in your browser!

## :computer: Servers

### :unlock: Access

| Environment | Address |
| :--: | :---: |
| Production | codestories-review-bot.herokuapp.com |

### :new: Deployments

To make deployments and manage the apps you need privileges to the Heroku's project.
Automatic deployments to the Production are already enabled for `master` branch.

## :question: Extras

### :vertical_traffic_light: Testing

To execute all tests please use following command:

```
mix test
```

Please remember about checking your changes before pushing to the repo in the code this way.
