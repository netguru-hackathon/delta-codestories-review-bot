defmodule CodestoriesReviewBot.PostsTest do
  use CodestoriesReviewBot.DataCase

  alias CodestoriesReviewBot.Posts

  describe "categories" do
    alias CodestoriesReviewBot.Posts.Category

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def category_fixture(attrs \\ %{}) do
      {:ok, category} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Posts.create_category()

      category
    end

    test "list_categories/0 returns all categories" do
      category = category_fixture()
      assert Posts.list_categories() == [category]
    end

    test "get_category!/1 returns the category with given id" do
      category = category_fixture()
      assert Posts.get_category!(category.id) == category
    end

    test "create_category/1 with valid data creates a category" do
      assert {:ok, %Category{} = category} = Posts.create_category(@valid_attrs)
      assert category.name == "some name"
    end

    test "create_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Posts.create_category(@invalid_attrs)
    end

    test "update_category/2 with valid data updates the category" do
      category = category_fixture()
      assert {:ok, %Category{} = category} = Posts.update_category(category, @update_attrs)
      assert category.name == "some updated name"
    end

    test "update_category/2 with invalid data returns error changeset" do
      category = category_fixture()
      assert {:error, %Ecto.Changeset{}} = Posts.update_category(category, @invalid_attrs)
      assert category == Posts.get_category!(category.id)
    end

    test "delete_category/1 deletes the category" do
      category = category_fixture()
      assert {:ok, %Category{}} = Posts.delete_category(category)
      assert_raise Ecto.NoResultsError, fn -> Posts.get_category!(category.id) end
    end

    test "change_category/1 returns a category changeset" do
      category = category_fixture()
      assert %Ecto.Changeset{} = Posts.change_category(category)
    end
  end

  describe "reviewers" do
    alias CodestoriesReviewBot.Posts.Reviewer

    @valid_attrs %{slack_id: "some slack_id"}
    @invalid_attrs %{slack_id: nil}

    def reviewer_fixture(attrs \\ %{}) do
      {:ok, reviewer} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Posts.create_reviewer()

      reviewer
    end

    test "list_reviewers/0 returns all reviewers" do
      reviewer = reviewer_fixture()
      assert Posts.list_reviewers() == [reviewer]
    end

    test "get_reviewer!/1 returns the reviewer with given id" do
      reviewer = reviewer_fixture()
      assert Posts.get_reviewer!(reviewer.id) == reviewer
    end

    test "create_reviewer/1 with valid data creates a reviewer" do
      assert {:ok, %Reviewer{} = reviewer} = Posts.create_reviewer(@valid_attrs)
      assert reviewer.slack_id == "some slack_id"
    end

    test "create_reviewer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Posts.create_reviewer(@invalid_attrs)
    end

    test "delete_reviewer/1 deletes the reviewer" do
      reviewer = reviewer_fixture()
      assert {:ok, %Reviewer{}} = Posts.delete_reviewer(reviewer)
      assert_raise Ecto.NoResultsError, fn -> Posts.get_reviewer!(reviewer.id) end
    end
  end
end
