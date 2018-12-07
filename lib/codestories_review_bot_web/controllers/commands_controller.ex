defmodule CodestoriesReviewBotWeb.CommandsController do
  use CodestoriesReviewBotWeb, :controller

  alias CodestoriesReviewBot.Commands

  action_fallback CodestoriesReviewBotWeb.FallbackController

  def execute(conn, params) do
    with result <- String.split(params["text"]) |> Commands.call(params["user_id"]) do
      text(conn, result)
    end
  end
end
