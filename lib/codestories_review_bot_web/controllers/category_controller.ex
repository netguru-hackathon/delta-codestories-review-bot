defmodule CodestoriesReviewBotWeb.CategoryController do
  use CodestoriesReviewBotWeb, :controller

  alias CodestoriesReviewBot.Reviews

  action_fallback CodestoriesReviewBotWeb.FallbackController

  def index(conn, _params) do
    categories = Reviews.list_categories()
    render(conn, "index.json", categories: categories)
  end
end
