defmodule CodestoriesReviewBotWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use CodestoriesReviewBotWeb, :controller
  alias Ecto.Changeset

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(CodestoriesReviewBotWeb.ErrorView)
    |> render(:"404")
  end

  def call(conn, {:error, %Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(CodestoriesReviewBotWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end
end
