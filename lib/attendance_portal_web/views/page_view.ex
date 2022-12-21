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

  def render("msg.json", %{msg: msg}) do
    msg
  end

  def render("leave.json", %{leave: leave}) do
    %{
      type: leave.type,
      reason: leave.reason,
      start_date: leave.start_date,
    end_date: leave.end_date,
      uid: leave.uid,
      status: leave.status
    }
  end

  def render("leaves.json", %{leaves: leaves}) do
    leaves |> Enum.map(fn leave -> %{
      type: leave.type,
      reason: leave.reason,
      start_date: leave.start_date,
    end_date: leave.end_date,
      uid: leave.uid,
      status: leave.status,
      name: AttendancePortal.Leaves.get_user_name(leave.user_id)
    }
  end)

  end
end
