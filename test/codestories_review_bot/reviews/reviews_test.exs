defmodule CodestoriesReviewBot.ReviewsTest do
  use CodestoriesReviewBot.DataCase

  alias CodestoriesReviewBot.Reviews

  describe "categories" do
    alias CodestoriesReviewBot.Reviews.Category

    @valid_attrs %{category_id: 1, name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    setup do
      %{category: insert(:category)}
    end

    test "list_categories/0 returns all categories", %{category: category} do
      assert Reviews.list_categories() == [category]
    end

    test "get_category!/1 returns the category with given id", %{category: category} do
      assert Reviews.get_category!(category.id) == category
    end

    test "create_category/1 with valid data creates a category" do
      assert {:ok, %Category{} = category} = Reviews.create_category(@valid_attrs)
      assert category.name == "some name"
    end

    test "create_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Reviews.create_category(@invalid_attrs)
    end

    test "update_category/2 with valid data updates the category", %{category: category} do
      assert {:ok, %Category{} = category} = Reviews.update_category(category, @update_attrs)
      assert category.name == "some updated name"
    end

    test "update_category/2 with invalid data returns error changeset", %{category: category} do
      assert {:error, %Ecto.Changeset{}} = Reviews.update_category(category, @invalid_attrs)
      assert category == Reviews.get_category!(category.id)
    end

    test "delete_category/1 deletes the category", %{category: category} do
      assert {:ok, %Category{}} = Reviews.delete_category(category)
      assert_raise Ecto.NoResultsError, fn -> Reviews.get_category!(category.id) end
    end

    test "change_category/1 returns a category changeset", %{category: category} do
      assert %Ecto.Changeset{} = Reviews.change_category(category)
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
