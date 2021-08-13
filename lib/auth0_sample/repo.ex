defmodule Auth0Sample.Repo do
  use Ecto.Repo,
    otp_app: :auth0_sample,
    adapter: Ecto.Adapters.Postgres
end
