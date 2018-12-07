defmodule CodestoriesReviewBotWeb.ReviewerController do
  use CodestoriesReviewBotWeb, :controller

  alias CodestoriesReviewBot.Posts
  alias CodestoriesReviewBot.Posts.Reviewer

  action_fallback CodestoriesReviewBotWeb.FallbackController

  def index(conn, _params) do
    reviewers = Posts.list_reviewers()
    render(conn, "index.json", reviewers: reviewers)
  end

  def create(conn, %{"reviewer" => reviewer_params}) do
    with {:ok, %Reviewer{} = reviewer} <- Posts.create_reviewer(reviewer_params) do
      conn
      |> put_status(:created)
      |> render("show.json", reviewer: reviewer)
    end
  end

  def delete(conn, %{"id" => id}) do
    reviewer = Posts.get_reviewer!(id)

    with {:ok, %Reviewer{}} <- Posts.delete_reviewer(reviewer) do
      send_resp(conn, :no_content, "")
    end
  end
end
