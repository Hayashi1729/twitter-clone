defmodule ProjectWeb.AuthorizationPlug do
  import Plug.Conn

  @spec init(Plug.opts) :: Plug.opts
  def init(opts), do: opts

  @doc """
  ユーザー認証処理
  """
  @spec call(Plug.Conn.t, Plug.opts) :: Plug.Conn.t
  def call(conn, _opts) do
    user_id = get_session(conn, :user_id)

    cond do
      conn.assigns[:current_user] ->
        conn

      user = user_id && Project.Accounts.get_user(user_id) ->
        assign(conn, :current_user, user)

      true ->
        assign(conn, :current_user, nil)
    end
  end

  @doc """
  ログイン処理を行う。
  """
  @spec login(Plug.Conn.t(), struct()) :: Plug.Conn.t()
  def login(conn, user) do
    conn
    |> assign(:current_user, user)
    |> put_session(:user_id, user.id)
    |> configure_session(renew: true)
  end

  @doc """
  ログアウト処理を行う。
  """
  @spec logout(Plug.Conn.t()) :: Plug.Conn.t()
  def logout(conn) do
    configure_session(conn, drop: true)
  end
end
