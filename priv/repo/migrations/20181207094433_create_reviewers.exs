defmodule CodestoriesReviewBot.Repo.Migrations.CreateReviewers do
  use Ecto.Migration

  def change do
    create table(:reviewers) do
      add :slack_id, :text
      add :category_id, references(:categories, on_delete: :nothing)

      timestamps()
    end

    create index(:reviewers, [:category_id])
  end
end
