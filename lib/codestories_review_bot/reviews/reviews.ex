defmodule CodestoriesReviewBot.Reviews do
  @moduledoc """
  The Reviews context.
  """

  import Ecto.Query, warn: false
  alias CodestoriesReviewBot.Repo

  alias CodestoriesReviewBot.Reviews.Category

  @doc """
  Returns the list of categories.

  ## Examples

      iex> list_categories()
      [%Category{}, ...]

  """
  def list_categories do
    Repo.all(Category)
  end

  alias CodestoriesReviewBot.Reviews.Reviewer

  @doc """
  Returns the list of reviewers.

  ## Examples

      iex> list_reviewers()
      [%Reviewer{}, ...]

  """
  def list_reviewers do
    Repo.all(Reviewer)
  end

  @doc """
  Gets a single category.

  Raises `Ecto.NoResultsError` if the Category does not exist.

  ## Examples

      iex> get_category!(123)
      %Category{}

      iex> get_category!(456)
      ** (Ecto.NoResultsError)

  """
  def get_category!(id), do: Repo.get!(Category, id)

  @doc """
  Gets a single reviewer.

  Raises `Ecto.NoResultsError` if the Reviewer does not exist.

  ## Examples

      iex> get_reviewer!(123)
      %Reviewer{}

      iex> get_reviewer!(456)
      ** (Ecto.NoResultsError)

  """
  def get_reviewer!(id), do: Repo.get!(Reviewer, id)

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
end
