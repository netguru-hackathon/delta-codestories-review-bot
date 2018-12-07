# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     CodestoriesReviewBot.Repo.insert!(%CodestoriesReviewBot.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias CodestoriesReviewBot.Repo
alias CodestoriesReviewBot.Reviews.Category

Repo.insert! %Category{name: "Android"}
Repo.insert! %Category{name: "Elixir"}
Repo.insert! %Category{name: "Front-end"}
Repo.insert! %Category{name: "iOS"}
Repo.insert! %Category{name: "Machine Learning"}
Repo.insert! %Category{name: "QA"}
Repo.insert! %Category{name: "RoR"}
