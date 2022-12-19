defmodule AiPhoenix.Repo.Migrations.CreatePizzas do
  use Ecto.Migration

  def change do
    create table(:pizzas) do
      add :pizza_id, :integer
      add :name, :string
      add :description, :text
      add :image_url, :string

      timestamps()
    end
  end
end
