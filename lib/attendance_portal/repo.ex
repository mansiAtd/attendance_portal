defmodule AttendancePortal.Repo do
  use Ecto.Repo,
    otp_app: :attendance_portal,
    adapter: Ecto.Adapters.Postgres
end
