defmodule AttendancePortalWeb.PageController do
  use AttendancePortalWeb, :controller

  alias AttendancePortal.Users
  alias AttendancePortal.Leaves

  def login(conn, %{"id" => id, "password" => password}) do
     case Users.find_user_and_confirm_password(id, password) do
       {:ok, user} ->
          render(conn, "login_success.json",
         user: user
       )

       {:error, _} ->
         render(conn, "msg.json", msg: "Invalid credentials")
    end
  end

  def logout(conn, _params) do
     render(conn, "msg.json.json", msg: "Logged out successfully!")
  end

  def create(conn, %{"user_id" => user_id, "params" => params}) do
    {:ok, leave} = Leaves.create_leave(user_id, params)

    render(conn, "leave.json", leave: leave)
  end

  def update(conn, %{"user_id" => _user_uid, "uid" => leave_uid, "params" => params}) do
    {:ok, leave} = Leaves.update_leave(leave_uid, params)

    render(conn, "leave.json", leave: leave)
  end

  def delete(conn, %{"user_id" => _user_uid, "uid" => leave_uid}) do
    _ = Leaves.delete_leave(leave_uid)

    render(conn, "msg.json", msg: "Leave deleted successfully")
  end

  def index(conn, %{"user_id" => _user_uid}) do
    IO.puts("=====================")
    leaves = Leaves.get_leaves()

    render(conn, "leaves.json", leaves: leaves)
  end

  def show(conn, %{"user_id" => _user_uid, "uid" => leave_uid}) do
    leave = Leaves.get_leave_by_uid(leave_uid)

    render(conn, "leave.json", leave: leave)
  end
end
