defmodule CodestoriesReviewBotWeb.ReviewerControllerTest do
  use CodestoriesReviewBotWeb.ConnCase

  alias CodestoriesReviewBot.Reviews

  @create_attrs %{
    slack_id: "some slack_id"
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
    test "renders reviewer when data is valid", %{conn: conn} do
      conn = post(conn, Routes.reviewer_path(conn, :create), reviewer: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.reviewer_path(conn, :create), reviewer: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete reviewer" do
    setup [:create_reviewer]

    test "deletes chosen reviewer", %{conn: conn, reviewer: reviewer} do
      conn = delete(conn, Routes.reviewer_path(conn, :delete, reviewer))
      assert response(conn, 204)
    end
  end

  defp create_reviewer(_) do
    reviewer = fixture(:reviewer)
    {:ok, reviewer: reviewer}
  end
end
