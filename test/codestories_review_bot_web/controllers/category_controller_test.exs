defmodule CodestoriesReviewBotWeb.CategoryControllerTest do
  use CodestoriesReviewBotWeb.ConnCase

  setup %{conn: conn} do
    %{
      category: insert(:category, name: "test"),
      conn: put_req_header(conn, "accept", "application/json")
    }
  end

  describe "index" do
    test "lists all categories", %{conn: conn} do
      conn = get(conn, Routes.category_path(conn, :index))
      assert [%{"id" => _, "name" => "test"}] = json_response(conn, 200)["data"]
    end
  end
end
