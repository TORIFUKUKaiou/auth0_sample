defmodule Auth0SampleWeb.HomeController do
  @moduledoc """
  Static page controller
  """

  use Auth0SampleWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html", current_user: get_session(conn, :current_user))
  end
end
