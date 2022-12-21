defmodule AttendancePortal.Repo.Migrations.AddUsersTable do
  use Ecto.Migration

  def change do
    create table(:users) do
          add :uid, :string
          add :emp_id, :string
          add :email, :string
          add :name, :string
          add :password_hash, :string
          add :designation, :string
          timestamps()
        end
  end
end
