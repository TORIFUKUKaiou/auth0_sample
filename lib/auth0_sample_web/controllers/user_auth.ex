defmodule Auth0SampleWeb.UserAuth do
  import Plug.Conn
  import Phoenix.Controller

  def fetch_current_user(conn, _opts) do
    user = get_session(conn, :current_user)
    assign(conn, :current_user, user)
  end

  def require_authenticated_user(conn, _opts) do
    if conn.assigns[:current_user] do
      conn
    else
      conn
      |> put_flash(:error, "You must log in to access this page.")
      |> redirect(to: "/")
      |> halt()
    end
  end
end
