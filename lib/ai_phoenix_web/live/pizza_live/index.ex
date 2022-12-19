defmodule AiPhoenixWeb.PizzaLive.Index do
  use AiPhoenixWeb, :live_view

  alias AiPhoenix.Pizza

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :pizzas, list_pizzas())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Pizza")
    |> assign(:pizza, Pizza.get_pizza!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Pizza")
    |> assign(:pizza, %AiPhoenix.Pizza.Restaurant.Pizza{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Pizzas")
    |> assign(:pizza, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    pizza = Pizza.get_pizza!(id)
    {:ok, _} = Pizza.delete_pizza(pizza)

    {:noreply, assign(socket, :pizzas, list_pizzas())}
  end

  defp list_pizzas do
    Pizza.list_pizzas()
  end
end
