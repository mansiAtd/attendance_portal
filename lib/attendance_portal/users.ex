defmodule AttendancePortal.Users do
  import Ecto.Query, warn: false
  alias AttendancePortal.Repo
  alias AttendancePortal.Schema.{Leave, User}

  def find_user_and_confirm_password(emp_id, password) do
    case Repo.get_by(User, emp_id: emp_id) do
      nil ->
        {:error, :not_found}

      user ->
        if Bcrypt.verify_pass(password, user.password_hash) do
          {:ok, user}
        else
          {:error, :unauthorized}
        end
    end
  end
end
