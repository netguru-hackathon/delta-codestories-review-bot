defmodule CodestoriesReviewBot.CommandsTest do
  use CodestoriesReviewBot.DataCase

  alias CodestoriesReviewBot.Commands

  setup do
    category = insert(:category, name: "RoR")

    %{
      category: category,
      reviewer: insert(:reviewer, category: category)
    }
  end


  describe "call/1" do
    test "reviewers category", %{category: category, reviewer: reviewer} do
      reviewer2 = insert(:reviewer, category: category, slack_id: "some_slack_id")
      assert "Codestories reviewers for category 'RoR': <@#{reviewer.slack_id}>, <@#{reviewer2.slack_id}>" ==
        Commands.call(["reviewers", "RoR"], nil)
    end

    test "reviewer category", %{reviewer: reviewer} do
      assert "Codestories reviewer for category 'RoR': <@#{reviewer.slack_id}>" ==
        Commands.call(["reviewer", "RoR"], nil)
    end

    test "join category" do
      assert "You've been added as Codestories reviewer to category 'RoR'" ==
        Commands.call(["join", "RoR"], "new_slack_id")
    end

    test "remove_from category", %{reviewer: reviewer} do
      assert "You're no longer Codestories reviewer for category 'RoR'" ==
        Commands.call(["remove_from", "RoR"], reviewer.slack_id)
    end

    test "invalid command" do
      assert "Invalid command" == Commands.call(["invalid", "command"], nil)
    end
  end
end
