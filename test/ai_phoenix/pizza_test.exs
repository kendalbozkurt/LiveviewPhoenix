defmodule AiPhoenix.PizzaTest do
  use AiPhoenix.DataCase

  alias AiPhoenix.Pizza

  describe "pizzas" do
    alias AiPhoenix.Pizza.Restaurant.Pizza

    import AiPhoenix.PizzaFixtures

    @invalid_attrs %{description: nil, image_url: nil, name: nil, pizza_id: nil}

    test "list_pizzas/0 returns all pizzas" do
      pizza = pizza_fixture()
      assert Pizza.list_pizzas() == [pizza]
    end

    test "get_pizza!/1 returns the pizza with given id" do
      pizza = pizza_fixture()
      assert Pizza.get_pizza!(pizza.id) == pizza
    end

    test "create_pizza/1 with valid data creates a pizza" do
      valid_attrs = %{
        description: "some description",
        image_url: "some image_url",
        name: "some name",
        pizza_id: 42
      }

      assert {:ok, %Pizza{} = pizza} = Pizza.create_pizza(valid_attrs)
      assert pizza.description == "some description"
      assert pizza.image_url == "some image_url"
      assert pizza.name == "some name"
      assert pizza.pizza_id == 42
    end

    test "create_pizza/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pizza.create_pizza(@invalid_attrs)
    end

    test "update_pizza/2 with valid data updates the pizza" do
      pizza = pizza_fixture()

      update_attrs = %{
        description: "some updated description",
        image_url: "some updated image_url",
        name: "some updated name",
        pizza_id: 43
      }

      assert {:ok, %Pizza{} = pizza} = Pizza.update_pizza(pizza, update_attrs)
      assert pizza.description == "some updated description"
      assert pizza.image_url == "some updated image_url"
      assert pizza.name == "some updated name"
      assert pizza.pizza_id == 43
    end

    test "update_pizza/2 with invalid data returns error changeset" do
      pizza = pizza_fixture()
      assert {:error, %Ecto.Changeset{}} = Pizza.update_pizza(pizza, @invalid_attrs)
      assert pizza == Pizza.get_pizza!(pizza.id)
    end

    test "delete_pizza/1 deletes the pizza" do
      pizza = pizza_fixture()
      assert {:ok, %Pizza{}} = Pizza.delete_pizza(pizza)
      assert_raise Ecto.NoResultsError, fn -> Pizza.get_pizza!(pizza.id) end
    end

    test "change_pizza/1 returns a pizza changeset" do
      pizza = pizza_fixture()
      assert %Ecto.Changeset{} = Pizza.change_pizza(pizza)
    end
  end
end
