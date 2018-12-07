defmodule CodestoriesReviewBot.ReviewsTest do
  use CodestoriesReviewBot.DataCase

  alias CodestoriesReviewBot.Reviews

  describe "categories" do
    setup do
      %{category: insert(:category)}
    end

    test "list_categories/0 returns all categories", %{category: category} do
      assert Reviews.list_categories() == [category]
    end
  end

  describe "reviewers" do
    alias CodestoriesReviewBot.Reviews.Reviewer

    setup do
      category = insert(:category)

      %{
        category: category,
        valid_attrs: %{slack_id: "some slack_id", category_id: category.id},
        invalid_attrs: %{slack_id: nil}
      }
    end

    test "list_reviewers/0 returns all reviewers", %{category: category} do
      reviewer = insert(:reviewer, category: category)
      reviewer_id = reviewer.id
      assert [%Reviewer{id: ^reviewer_id}] = Reviews.list_reviewers()
    end

    test "list_reviewers/1 returns reviewers for category", %{category: category} do
      insert(:reviewer, category: category)
      category2 = insert(:category, name: "second_category")
      reviewer = insert(:reviewer, category: category2)
      reviewer_id = reviewer.id
      assert [%Reviewer{id: ^reviewer_id}] = Reviews.list_reviewers(%{category: "second_category"})
    end

    test "get_reviewer!/1 returns the reviewer with given id", %{category: category} do
      reviewer = insert(:reviewer, category: category)
      reviewer_id = reviewer.id
      assert %Reviewer{id: ^reviewer_id} = Reviews.get_reviewer!(reviewer_id)
    end

    test "create_reviewer/1 with valid data creates a reviewer", %{valid_attrs: valid_attrs} do
      assert {:ok, %Reviewer{} = reviewer} = Reviews.create_reviewer(valid_attrs)
      assert reviewer.slack_id == "some slack_id"
    end

    test "create_reviewer/1 with invalid data returns error changeset", %{invalid_attrs: invalid_attrs} do
      assert {:error, %Ecto.Changeset{}} = Reviews.create_reviewer(invalid_attrs)
    end

    test "delete_reviewer/1 deletes the reviewer", %{category: category} do
      reviewer = insert(:reviewer, category: category)
      assert {:ok, %Reviewer{}} = Reviews.delete_reviewer(reviewer)
      assert_raise Ecto.NoResultsError, fn -> Reviews.get_reviewer!(reviewer.id) end
    end
  end
end
