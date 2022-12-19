defmodule AiPhoenixWeb.PizzaLiveTest do
  use AiPhoenixWeb.ConnCase

  import Phoenix.LiveViewTest
  import AiPhoenix.PizzaFixtures

  @create_attrs %{
    description: "some description",
    image_url: "some image_url",
    name: "some name",
    pizza_id: 42
  }
  @update_attrs %{
    description: "some updated description",
    image_url: "some updated image_url",
    name: "some updated name",
    pizza_id: 43
  }
  @invalid_attrs %{description: nil, image_url: nil, name: nil, pizza_id: nil}

  defp create_pizza(_) do
    pizza = pizza_fixture()
    %{pizza: pizza}
  end

  describe "Index" do
    setup [:create_pizza]

    test "lists all pizzas", %{conn: conn, pizza: pizza} do
      {:ok, _index_live, html} = live(conn, ~p"/pizzas")

      assert html =~ "Listing Pizzas"
      assert html =~ pizza.description
    end

    test "saves new pizza", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/pizzas")

      assert index_live |> element("a", "New Pizza") |> render_click() =~
               "New Pizza"

      assert_patch(index_live, ~p"/pizzas/new")

      assert index_live
             |> form("#pizza-form", pizza: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#pizza-form", pizza: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/pizzas")

      assert html =~ "Pizza created successfully"
      assert html =~ "some description"
    end

    test "updates pizza in listing", %{conn: conn, pizza: pizza} do
      {:ok, index_live, _html} = live(conn, ~p"/pizzas")

      assert index_live |> element("#pizzas-#{pizza.id} a", "Edit") |> render_click() =~
               "Edit Pizza"

      assert_patch(index_live, ~p"/pizzas/#{pizza}/edit")

      assert index_live
             |> form("#pizza-form", pizza: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#pizza-form", pizza: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/pizzas")

      assert html =~ "Pizza updated successfully"
      assert html =~ "some updated description"
    end

    test "deletes pizza in listing", %{conn: conn, pizza: pizza} do
      {:ok, index_live, _html} = live(conn, ~p"/pizzas")

      assert index_live |> element("#pizzas-#{pizza.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#pizza-#{pizza.id}")
    end
  end

  describe "Show" do
    setup [:create_pizza]

    test "displays pizza", %{conn: conn, pizza: pizza} do
      {:ok, _show_live, html} = live(conn, ~p"/pizzas/#{pizza}")

      assert html =~ "Show Pizza"
      assert html =~ pizza.description
    end

    test "updates pizza within modal", %{conn: conn, pizza: pizza} do
      {:ok, show_live, _html} = live(conn, ~p"/pizzas/#{pizza}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Pizza"

      assert_patch(show_live, ~p"/pizzas/#{pizza}/show/edit")

      assert show_live
             |> form("#pizza-form", pizza: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#pizza-form", pizza: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/pizzas/#{pizza}")

      assert html =~ "Pizza updated successfully"
      assert html =~ "some updated description"
    end
  end
end
