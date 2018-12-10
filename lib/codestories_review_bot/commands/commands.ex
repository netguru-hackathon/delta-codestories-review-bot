defmodule CodestoriesReviewBot.Commands do
  alias CodestoriesReviewBot.Reviews

  def call(["reviewers", category_name], _user_id) do
    %{name: category} = Reviews.get_category_by_name(category_name)

    mention_list =
      %{category: category}
      |> Reviews.list_reviewers()
      |> Enum.map(& "<@#{&1.slack_id}>")
      |> Enum.join(", ")

    "Codestories reviewers for category '#{category}': "  <> mention_list
  end

  def call(["reviewer", category_name], _user_id) do
    %{name: category} = Reviews.get_category_by_name(category_name)

    reviewer = Reviews.get_random_reviewer(category)
    "Codestories reviewer for category '#{category}': <@#{reviewer.slack_id}>"
  end

  def call(["join", category_name], user_id) do
    %{name: category, id: id} = Reviews.get_category_by_name(category_name)

    with {:ok, _} <- Reviews.create_reviewer(%{slack_id: user_id, category_id: id}) do
      "You've been added as Codestories reviewer to category '#{category}'"
    end
  end

  def call(["remove_from", category_name], user_id) do
    %{name: category} = Reviews.get_category_by_name(category_name)

    user_id
    |> Reviews.get_reviewer_by_slack_id()
    |> Reviews.delete_reviewer()

    "You're no longer Codestories reviewer for category '#{category}'"
  end

  def call(_command, _user_id), do: "Invalid command"
end
