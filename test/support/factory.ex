defmodule CodestoriesReviewBot.Factory do
  use ExMachina.Ecto, repo: CodestoriesReviewBot.Repo

  def reviewer_factory do
    alias CodestoriesReviewBot.Reviews.Reviewer

    %Reviewer{
      slack_id: "1",
      category: build(:category)
    }
  end

  def category_factory do
    alias CodestoriesReviewBot.Reviews.Category

    %Category{
      name: "test"
    }
  end
end
