defmodule CodestoriesReviewBot.Reviews.Reviewer do
  use Ecto.Schema
  import Ecto.Changeset

  alias CodestoriesReviewBot.Reviews.Category

  schema "reviewers" do
    field :slack_id, :string

    timestamps()

    belongs_to(
      :category,
      Category,
      foreign_key: :category_id
    )
  end

  @doc false
  def changeset(reviewer, attrs) do
    reviewer
    |> cast(attrs, [:category_id, :slack_id])
    |> validate_required([:category_id, :slack_id])
  end
end
