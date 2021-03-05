defmodule ProjectWeb.Auth do
  import Plug.Conn

  @spec init(Plug.opts) :: Plug.opts
  def init(opts), do: opts

  @spec call(Plug.Conn.t, Plug.opts) :: Plug.Conn.t
  @doc """
  ユーザー認証処理
  """
  def call(conn, _opts) do
    user_id = get_session(conn, :user_id)

    cond do
      conn.assigns[:current_user] ->
        conn

      user = user_id && Project.Twitter.get_user(user_id) ->
        assign(conn, :current_user, user)

      true ->
        assign(conn, :current_user, nil)
    end
  end

  @spec login(Plug.Conn.t(), struct()) :: Plug.Conn.t()
  @doc """
  ログイン処理を行う。
  """
  def login(conn, user) do
    conn
    |> assign(:current_user, user)
    |> put_session(:user_id, user.id)
    |> configure_session(renew: true)
  end

  @spec logout(Plug.Conn.t()) :: Plug.Conn.t()
  @doc """
  ログアウト処理を行う。
  """
  def logout(conn) do
    configure_session(conn, drop: true)
  end
end
