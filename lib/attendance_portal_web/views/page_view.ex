defmodule AttendancePortalWeb.PageView do
  use AttendancePortalWeb, :view

  def render("login_success.json", %{user: user}) do
    %{
      name: user.name,
      emp_id: user.emp_id,
      designation: user.designation,
      email: user.email,
      uid: user.uid
    }
  end

  def render("login_error.json", %{msg: msg}) do
    msg
  end
end
