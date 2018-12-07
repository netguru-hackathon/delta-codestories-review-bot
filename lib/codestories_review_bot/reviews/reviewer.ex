defmodule CodestoriesReviewBot.Reviews.Reviewer do
  use Ecto.Schema
  import Ecto.Changeset


  schema "reviewers" do
    field :slack_id, :string
    field :category_id, :id

    timestamps()
  end

  @doc false
  def changeset(reviewer, attrs) do
    reviewer
    |> cast(attrs, [:category_id, :slack_id])
    |> validate_required([:category_id, :slack_id])
  end
end
