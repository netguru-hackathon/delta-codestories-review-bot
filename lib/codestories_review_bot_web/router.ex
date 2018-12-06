defmodule CodestoriesReviewBotWeb.Router do
  use CodestoriesReviewBotWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", CodestoriesReviewBotWeb do
    pipe_through :api
  end
end
