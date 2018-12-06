defmodule CodestoriesReviewBotWeb.CategoryControllerTest do
  use CodestoriesReviewBotWeb.ConnCase

  alias CodestoriesReviewBot.Posts
  alias CodestoriesReviewBot.Posts.Category

  @create_attrs %{
    name: "some name"
  }
  @update_attrs %{
    name: "some updated name"
  }
  @invalid_attrs %{name: nil}

  def fixture(:category) do
    {:ok, category} = Posts.create_category(@create_attrs)
    category
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all categories", %{conn: conn} do
      conn = get(conn, Routes.category_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  defp create_category(_) do
    category = fixture(:category)
    {:ok, category: category}
  end
end
