defmodule Project.Factory do
  # with Ecto
  use ExMachina.Ecto, repo: Project.Repo

  def user_factory do
    %Project.Accounts.User{
      username: sequence(:username, &"User-#{&1}"),
      password_hash: "password hash"
    }
  end

  def post_factory do
    %Project.Twitter.Post{
      tweet: sequence(:tweet, &"Tweet-#{&1}"),
      user: build(:user)
    }
  end

  def register_user_factory do
    %Project.Accounts.User{
      username: sequence(:username, &"User-#{&1}"),
      password: "supersecret"
    }
  end

  def invalid_user_factory do
    %Project.Accounts.User{
      username: "",
      password: ""
    }
  end

  def invalid_post_factory do
    %Project.Twitter.Post{
      tweet: "",
      user: build(:user)
    }
  end

  def favorite_factory do
    %Project.Twitter.Favorite{
      user: build(:user),
      post: build(:post)
    }
  end
end
