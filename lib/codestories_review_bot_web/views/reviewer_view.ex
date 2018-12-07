defmodule CodestoriesReviewBotWeb.ReviewerView do
  use CodestoriesReviewBotWeb, :view
  alias CodestoriesReviewBotWeb.ReviewerView

  def render("index.json", %{reviewers: reviewers}) do
    %{data: render_many(reviewers, ReviewerView, "reviewer.json")}
  end

  def render("show.json", %{reviewer: reviewer}) do
    %{data: render_one(reviewer, ReviewerView, "reviewer.json")}
  end

  def render("reviewer.json", %{reviewer: reviewer}) do
    %{id: reviewer.id,
      slack_id: reviewer.slack_id}
  end
end
