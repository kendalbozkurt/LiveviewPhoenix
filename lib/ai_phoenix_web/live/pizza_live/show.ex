defmodule AiPhoenixWeb.PizzaLive.Show do
  use AiPhoenixWeb, :live_view

  alias AiPhoenix.Pizza

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:pizza, Pizza.get_pizza!(id))}
  end

  defp page_title(:show), do: "Show Pizza"
  defp page_title(:edit), do: "Edit Pizza"
end
