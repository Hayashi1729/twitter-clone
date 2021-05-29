defmodule ProjectWeb.ApiView do
  use ProjectWeb, :view

  def render("api.json", %{api_data: _params}) do
    %{
      id: 100,
      name: "test"
    }
  end
end
