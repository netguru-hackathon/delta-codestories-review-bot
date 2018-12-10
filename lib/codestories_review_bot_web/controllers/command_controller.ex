defmodule CodestoriesReviewBotWeb.CommandController do
  use CodestoriesReviewBotWeb, :controller

  action_fallback CodestoriesReviewBotWeb.FallbackController

  def execute(conn, _params) do
    text(conn, "We're working on it. :rocket:")
  end
end
