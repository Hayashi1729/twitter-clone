defmodule ProjectWeb.ErrorView do
  use ProjectWeb, :view

  # If you want to customize a particular status code
  # for a certain format, you may uncomment below.
  # def render("500.html", _assigns) do
  #   "Internal Server Error"
  # end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.html" becomes
  # "Not Found".
  def template_not_found(template, _assigns) do
    Phoenix.Controller.status_message_from_template(template)
  end

  def translate_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
  end

  def render("error.json", %{changeset: changeset}) do
    %{errors: translate_errors(changeset)}
  end

  def render("error.json", %{status: status}) do
    case status do
      :unauthorized ->
        %{
          errors: %{
            password: ["パスワードが違います"]
          }
        }

      :not_found ->
        %{
          errors: %{
            username: ["ユーザーが存在しません"]
          }
        }

      :favorite_not_found ->
        %{
          errors: %{
            favorite: ["このツイートはお気に入り登録されていません"]
          }
        }

      _ ->
        %{
          errors: "An unexpected error has occurred"
        }
    end
  end
end
