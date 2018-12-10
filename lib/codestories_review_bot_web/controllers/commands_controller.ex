defmodule CodestoriesReviewBotWeb.CommandsController do
  use CodestoriesReviewBotWeb, :controller

  alias CodestoriesReviewBot.Commands

  action_fallback CodestoriesReviewBotWeb.FallbackController

  def execute(conn, %{"text" => command, "user_id" => user_id}) do
    with result <- String.split(command) |> Commands.call(user_id) do
      text(conn, result)
    end
  end
end
