defmodule DismoiWeb.ErrorJSONTest do
  use DismoiWeb.ConnCase, async: true

  test "renders 404" do
    assert DismoiWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert DismoiWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
