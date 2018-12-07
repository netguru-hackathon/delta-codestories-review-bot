defmodule CodestoriesReviewBotWeb.CategoryController do
  use CodestoriesReviewBotWeb, :controller

  alias CodestoriesReviewBot.Posts

  action_fallback CodestoriesReviewBotWeb.FallbackController

  def index(conn, _params) do
    categories = Posts.list_categories()
    render(conn, "index.json", categories: categories)
  end
end
