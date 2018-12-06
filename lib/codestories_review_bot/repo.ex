defmodule CodestoriesReviewBot.Repo do
  use Ecto.Repo,
    otp_app: :codestories_review_bot,
    adapter: Ecto.Adapters.Postgres

  def init(_, config) do
   config = Confex.Resolver.resolve!(config)
   {:ok, config}
  end
end
