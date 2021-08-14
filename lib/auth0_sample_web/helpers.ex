defmodule Auth0SampleWeb.Helpers do
  def keep_current_user(conn) do
    %{"current_user" => conn.assigns.current_user}
  end
end
