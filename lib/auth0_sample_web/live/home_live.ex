defmodule Auth0SampleWeb.HomeLive do
  use Auth0SampleWeb, :live_view

  def mount(_params, %{"current_user" => current_user}, socket) do
    {:ok, assign(socket, current_user: current_user)}
  end

  def render(assigns) do
    ~L"""
    <section class="phx-hero">
      <h1>Überauth + Phoenix Example</h1>
      <p>
        This is an application to show an example of how to wire up
        <a href="https://github.com/ueberauth/ueberauth">Überauth</a> with
        <a href="https://github.com/phoenixframework/phoenix">Phoenix</a>.
      </p>
      <%= if @current_user do %>
        <h2>Welcome, <%= @current_user.name %>!</h2>
        <div>
          <img src="<%= @current_user.avatar %>" />
        </div>
        <%= link "page", to: "/page" %>
        <br>
      <% else %>
        <h2>Please log in !!!</h2>
      <% end %>
    </section>
    """
  end
end
