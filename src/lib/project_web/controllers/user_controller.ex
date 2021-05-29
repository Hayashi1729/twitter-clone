defmodule ProjectWeb.UserController do
  use ProjectWeb, :controller

  @doc """
  ユーザーの一覧を取得して表示。
  """
  @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
  def index(conn, _params) do
    render(conn, "index.html")
  end

  @doc """
  新規ユーザー作成画面を表示。
  """
  @spec new(Plug.Conn.t(), any) :: Plug.Conn.t()
  def new(conn, _params) do
    render(conn, "new.html")
  end

  @doc """
  ユーザー詳細表示画面を表示。
  """
  @spec show(Plug.Conn.t(), map) :: Plug.Conn.t()
  def show(conn, _params) do
    render(conn, "show.html")
  end

  @doc """
  ユーザー情報編集画面を表示。
  """
  @spec edit(Plug.Conn.t(), map) :: Plug.Conn.t()
  def edit(conn, _params) do
    render(conn, "edit.html")
  end
end
