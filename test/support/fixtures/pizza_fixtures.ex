defmodule AiPhoenix.PizzaFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `AiPhoenix.Pizza` context.
  """

  @doc """
  Generate a pizza.
  """
  def pizza_fixture(attrs \\ %{}) do
    {:ok, pizza} =
      attrs
      |> Enum.into(%{
        description: "some description",
        image_url: "some image_url",
        name: "some name",
        pizza_id: 42
      })
      |> AiPhoenix.Pizza.create_pizza()

    pizza
  end
end
