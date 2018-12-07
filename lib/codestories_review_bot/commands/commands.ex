defmodule CodestoriesReviewBot.Commands do
  alias CodestoriesReviewBot.Reviews

  def call(["reviewers", category_name], _user_id) do
    mention_list =
      %{category: category_name}
      |> Reviews.list_reviewers()
      |> Enum.map(& "<@#{&1.slack_id}>")
      |> Enum.join(", ")

    "Codestories reviewers for category '#{category_name}': "  <> mention_list
  end

  def call(["reviewer", category_name], _user_id) do
    reviewer = Reviews.get_random_reviewer(category_name)
    "Codestories reviewer for category '#{category_name}': <@#{reviewer.slack_id}>"
  end

  def call(["join", category_name], user_id) do
    category = Reviews.get_category_by_name(category_name)

    with {:ok, _} <- Reviews.create_reviewer(%{slack_id: user_id, category_id: category.id}) do
      "You've been added as Codestories reviewer to category '#{category_name}'"
    end
  end

  def call(["remove_from", category_name], user_id) do
    user_id
    |> Reviews.get_reviewer!()
    |> Reviews.delete_reviewer()

    "You're no longer Codestories reviewer for category '#{category_name}'"
  end

  def call(_command, _user_id), do: "Invalid command"
end
