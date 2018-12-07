defmodule CodestoriesReviewBotWeb.CategoryView do
  use CodestoriesReviewBotWeb, :view
  alias CodestoriesReviewBotWeb.CategoryView

  def render("index.json", %{categories: categories}) do
    %{data: render_many(categories, CategoryView, "category.json")}
  end

  def render("category.json", %{category: category}) do
    %{
      id: category.id,
      name: category.name
    }
  end
end
