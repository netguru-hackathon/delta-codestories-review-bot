defmodule CodestoriesReviewBot.Reviews.Category do
  use Ecto.Schema
  import Ecto.Changeset

  alias CodestoriesReviewBot.Reviews.Reviewer


  schema "categories" do
    field :name, :string

    timestamps()

    has_many(
      :reviewers,
      Reviewer,
      foreign_key: :category_id
    )
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
