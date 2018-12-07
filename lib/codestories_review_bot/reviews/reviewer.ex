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
    |> cast(attrs, [:slack_id])
    |> validate_required([:slack_id])
  end
end
