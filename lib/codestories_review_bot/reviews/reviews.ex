defmodule CodestoriesReviewBot.Reviews do
  @moduledoc """
  The Reviews context.
  """

  import Ecto.Query, warn: false
  alias CodestoriesReviewBot.Repo
  alias CodestoriesReviewBot.Reviews.{Category, Reviewer}

  @doc """
  Returns the list of categories.

  ## Examples

      iex> list_categories()
      [%Category{}, ...]

  """
  def list_categories do
    Repo.all(Category)
  end

  @doc """
  Returns the list of reviewers.

  ## Examples

      iex> list_reviewers()
      [%Reviewer{}, ...]

  """
  def list_reviewers do
    Repo.all(Reviewer)
  end

  def list_reviewers(%{category: category_name}) do
    Category
    |> Repo.get_by(name: category_name)
    |> Repo.preload(:reviewers)
    |> case do
      %Category{} = category ->
        category.reviewers

      nil ->
        []
    end
  end

  def get_random_reviewer(category) do
    %{category: category}
    |> list_reviewers()
    |> Enum.take_random(1)
    |> List.first()
  end

  def get_reviewer_by_slack_id(slack_id), do: Repo.get_by(Reviewer, slack_id: slack_id)

  @doc """
  Creates a reviewer.

  ## Examples

      iex> create_reviewer(%{field: value})
      {:ok, %Reviewer{}}

      iex> create_reviewer(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_reviewer(attrs \\ %{}) do
    %Reviewer{}
    |> Reviewer.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Deletes a Reviewer.

  ## Examples

      iex> delete_reviewer(reviewer)
      {:ok, %Reviewer{}}

      iex> delete_reviewer(reviewer)
      {:error, %Ecto.Changeset{}}

  """
  def delete_reviewer(%Reviewer{} = reviewer) do
    Repo.delete(reviewer)
  end

  def get_category_by_name(name) do
    downcased_name = String.downcase(name)

    Repo.one(from c in Category, where: fragment("lower(?)", c.name) == ^downcased_name)
  end
end
