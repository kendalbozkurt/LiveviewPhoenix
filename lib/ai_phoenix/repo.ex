defmodule AiPhoenix.Repo do
  use Ecto.Repo,
    otp_app: :ai_phoenix,
    adapter: Ecto.Adapters.Postgres
end
