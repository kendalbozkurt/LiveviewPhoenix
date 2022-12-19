# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     AiPhoenix.Repo.insert!(%AiPhoenix.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

import Ecto

alias AiPhoenix.Repo
alias AiPhoenix.Pizza.Restaurant.Pizza

# Delete all existing data
Ecto.Adapters.SQL.query!(Repo, "DELETE FROM pizzas")

# Insert some sample data
Repo.insert_all(Pizza, [
  %{
    name: "Margherita",
    description: "Classic tomato, mozzarella, and basil",
    image_url: "https://example.com/margherita.jpg",
    pizza_id: 1,
    inserted_at: NaiveDateTime.local_now(),
    updated_at: NaiveDateTime.local_now()
  },
  %{
    name: "Pepperoni",
    description: "Spicy pepperoni and mozzarella",
    image_url: "https://example.com/pepperoni.jpg",
    pizza_id: 2,
    inserted_at: NaiveDateTime.local_now(),
    updated_at: NaiveDateTime.local_now()
  }
])
