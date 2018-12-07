defmodule CodestoriesReviewBotWeb.ReviewerController do
  use CodestoriesReviewBotWeb, :controller

  alias CodestoriesReviewBot.Reviews
  alias CodestoriesReviewBot.Reviews.Reviewer

  action_fallback CodestoriesReviewBotWeb.FallbackController

  def index(conn, %{"category" => category}) do
    reviewers = Reviews.list_reviewers(%{category: category})
    render(conn, "index.json", reviewers: reviewers)
  end

  def index(conn, _params) do
    reviewers = Reviews.list_reviewers()
    render(conn, "index.json", reviewers: reviewers)
  end


  def create(conn, %{"reviewer" => reviewer_params}) do
    with {:ok, %Reviewer{} = reviewer} <- Reviews.create_reviewer(reviewer_params) do
      conn
      |> put_status(:created)
      |> render("show.json", reviewer: reviewer)
    end
  end

  def delete(conn, %{"id" => id}) do
    reviewer = Reviews.get_reviewer!(id)

    with {:ok, %Reviewer{}} <- Reviews.delete_reviewer(reviewer) do
      send_resp(conn, :no_content, "")
    end
  end
end
