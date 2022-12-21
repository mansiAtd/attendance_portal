defmodule AttendancePortalWeb.PageController do
  use AttendancePortalWeb, :controller

  alias AttendancePortal.Users
  alias AttendancePortalWeb.Leaves

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def login(conn, %{"user" => %{"id" => id, "password" => password}}) do
     case Users.find_user_and_confirm_password(id, password) do
       {:ok, user} ->
          render(conn, "login_success.json",
         user: user
       )

       {:error, _} ->
         render(conn, "login_error.json", msg: "Invalid credentials")
    end

  end

  def logout(conn, _params) do
     render("logout_success.json", conn)
  end

  def create(conn, %{"user_uid" => _user_uid, "params" => params}) do
  end

  def update(conn, %{"user_uid" => _user_uid, "uid" => leave_uid, "params" => params}) do

  end

  def delete(conn, %{"user_uid" => _user_uid, "uid" => leave_uid}) do
    _ = Leaves.delete(leave_uid)

    render(conn, "msg.json", msg: "Leave deleted successfully")
  end

  def index(conn, %{"user_uid" => user_uid}) do
    leaves = Leaves.get_leaves(user_uid)

    render(conn, "leaves.json", leaves: leaves)
  end

  def show(conn, %{"user_uid" => _user_uid, "uid" => leave_uid}) do
    leave = Leaves.get_leave(leave_uid)

    render(conn, "leave.json", leave: leave)
  end

  def approve_leave(conn, %{"user_uid" => _user_uid, "leave_uid" => leave_uid, "params" => params}) do

  end
end
