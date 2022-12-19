defmodule AiPhoenix.Pizza.Restaurant.Pizza do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pizzas" do
    field :description, :string
    field :image_url, :string
    field :name, :string
    field :pizza_id, :integer

    timestamps()
  end

  @doc false
  def changeset(pizza, attrs) do
    pizza
    |> cast(attrs, [:pizza_id, :name, :description, :image_url])
    |> validate_required([:pizza_id, :name, :description, :image_url])
  end
end
