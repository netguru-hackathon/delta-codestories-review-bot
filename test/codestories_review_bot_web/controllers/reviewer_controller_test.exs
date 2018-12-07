defmodule CodestoriesReviewBotWeb.ReviewerControllerTest do
  use CodestoriesReviewBotWeb.ConnCase

  alias CodestoriesReviewBot.Reviews

  setup do
    %{category: insert(:category)}
  end

  @create_attrs %{
    category_id: 1, slack_id: "some slack_id"
  }
  @invalid_attrs %{slack_id: nil}

  def fixture(:reviewer) do
    {:ok, reviewer} = Reviews.create_reviewer(@create_attrs)
    reviewer
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all reviewers", %{conn: conn} do
      conn = get(conn, Routes.reviewer_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create reviewer" do
    test "renders reviewer when data is valid", %{conn: conn, category: category} do
      conn = post(conn, Routes.reviewer_path(conn, :create), reviewer: %{slack_id: "some_slack_id", category_id: category.id})
      assert %{"id" => id} = json_response(conn, 201)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.reviewer_path(conn, :create), reviewer: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete reviewer" do
    test "deletes chosen reviewer", %{conn: conn, category: category} do
      reviewer = insert(:reviewer, category: category)
      conn = delete(conn, Routes.reviewer_path(conn, :delete, reviewer))
      assert response(conn, 204)
    end
  end
end
