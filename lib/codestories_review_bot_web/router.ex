defmodule CodestoriesReviewBotWeb.Router do
  use CodestoriesReviewBotWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", CodestoriesReviewBotWeb do
    pipe_through :api
    resources "/categories", CategoryController, only: [:index]
    resources "/reviewers", ReviewerController, except: [:edit, :new, :show, :update]
    post "/commands", CommandController, :execute
  end
end
