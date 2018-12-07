defmodule CodestoriesReviewBot.Repo.Migrations.AddUniqueIndexToReviewers do
  use Ecto.Migration

  def up do
    create unique_index(:reviewers, [:slack_id, :category_id])
  end

  def down do
    drop unique_index(:reviewers, [:slack_id, :category_id])
  end
end
