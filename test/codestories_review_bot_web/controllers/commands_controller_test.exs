defmodule CodestoriesReviewBotWeb.CategoryControllerTest do
  use CodestoriesReviewBotWeb.ConnCase

  alias CodestoriesReviewBot.Repo
  alias CodestoriesReviewBot.Reviews.Reviewer

  setup %{conn: conn} do
    category = insert(:category, name: "RoR")
    insert(:reviewer, slack_id: "123", category: category)
    insert(:reviewer, slack_id: "456", category: category)

    %{conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "execute/2" do
    test "lists reviewers for given category", %{conn: conn} do
      conn =
        post(conn, Routes.commands_path(conn, :execute), %{
          text: "reviewers ror",
          user_id: "some_slack_id"
        })

      assert "Codestories reviewers for category 'RoR': <@123>, <@456>" = text_response(conn, 200)
    end

    test "gets random reviewer for given category", %{conn: conn} do
      conn =
        post(conn, Routes.commands_path(conn, :execute), %{
          text: "reviewer ror",
          user_id: "some_slack_id"
        })

      assert Regex.match?(
               ~r/\ACodestories reviewer for category 'RoR': (<@123>|<@456>)\z/,
               text_response(conn, 200)
             )
    end

    test "adds reviewer with category", %{conn: conn} do
      conn = post(conn, Routes.commands_path(conn, :execute), %{text: "join ror", user_id: "789"})

      assert "You've been added as Codestories reviewer to category 'RoR'" ==
               text_response(conn, 200)

      assert %Reviewer{slack_id: "789"} = Repo.get_by(Reviewer, slack_id: "789")
    end

    test "removes reviewer from category", %{conn: conn} do
      conn =
        post(conn, Routes.commands_path(conn, :execute), %{
          text: "remove_from ror",
          user_id: "123"
        })

      assert "You're no longer Codestories reviewer for category 'RoR'" ==
               text_response(conn, 200)

      assert nil == Repo.get_by(Reviewer, slack_id: "123")
    end

    test "handles invalid command", %{conn: conn} do
      conn =
        post(conn, Routes.commands_path(conn, :execute), %{
          text: "invalid command",
          user_id: "some_slack_id"
        })

      assert "Invalid command" == text_response(conn, 200)
    end
  end
end
