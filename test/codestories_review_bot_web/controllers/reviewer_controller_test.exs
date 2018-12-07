defmodule CodestoriesReviewBotWeb.ReviewerControllerTest do
  use CodestoriesReviewBotWeb.ConnCase

  setup %{conn: conn} do
    category = insert(:category)
    reviewer = insert(:reviewer, category: category)

    %{
      category: category,
      conn: put_req_header(conn, "accept", "application/json"),
      reviewer: reviewer
    }
  end

  describe "index" do
    test "lists all reviewers", %{conn: conn} do
      conn = get(conn, Routes.reviewer_path(conn, :index))
      assert [%{"id" => _, "category_id" => _, "slack_id" => _}] = json_response(conn, 200)["data"]
    end
  end

  describe "create reviewer" do
    test "renders reviewer when data is valid", %{category: category, conn: conn} do
      conn = post(conn,
                  Routes.reviewer_path(conn, :create),
                  reviewer: %{category_id: category.id, slack_id: "some slack_id"})
      assert %{"id" => _, "category_id" => _, "slack_id" => _} = json_response(conn, 201)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn,
                  Routes.reviewer_path(conn, :create),
                  reviewer: %{slack_id: "some slack_id"})
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete reviewer" do
    test "deletes chosen reviewer", %{conn: conn, reviewer: reviewer} do
      conn = delete(conn, Routes.reviewer_path(conn, :delete, reviewer))
      assert response(conn, 204)
    end
  end
end
