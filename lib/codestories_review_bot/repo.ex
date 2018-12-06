defmodule CodestoriesReviewBot.Repo do
  use Ecto.Repo,
    otp_app: :codestories_review_bot,
    adapter: Ecto.Adapters.Postgres
end
