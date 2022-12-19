defmodule AiPhoenixWeb.PizzaLive.FormComponent do
  use AiPhoenixWeb, :live_component

  alias AiPhoenix.Pizza

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage pizza records in your database.</:subtitle>
      </.header>

      <.simple_form
        :let={f}
        for={@changeset}
        id="pizza-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={{f, :pizza_id}} type="number" label="pizza_id" />
        <.input field={{f, :name}} type="text" label="name" />
        <.input field={{f, :description}} type="text" label="description" />
        <.input field={{f, :image_url}} type="text" label="image_url" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Pizza</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{pizza: pizza} = assigns, socket) do
    changeset = Pizza.change_pizza(pizza)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"pizza" => pizza_params}, socket) do
    changeset =
      socket.assigns.pizza
      |> Pizza.change_pizza(pizza_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"pizza" => pizza_params}, socket) do
    save_pizza(socket, socket.assigns.action, pizza_params)
  end

  defp save_pizza(socket, :edit, pizza_params) do
    case Pizza.update_pizza(socket.assigns.pizza, pizza_params) do
      {:ok, _pizza} ->
        {:noreply,
         socket
         |> put_flash(:info, "Pizza updated successfully")
         |> push_navigate(to: socket.assigns.navigate)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_pizza(socket, :new, pizza_params) do
    case Pizza.create_pizza(pizza_params) do
      {:ok, _pizza} ->
        {:noreply,
         socket
         |> put_flash(:info, "Pizza created successfully")
         |> push_navigate(to: socket.assigns.navigate)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
