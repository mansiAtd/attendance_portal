defmodule AttendancePortal.Repo.Migrations.AddLeavesTable do
  use Ecto.Migration

  def change do
    create table(:leaves) do
          add :uid, :string
          add :user_id, references(:users, on_delete: :delete_all)
          add :type, :string
          add :start_date, :utc_datetime
          add :end_date, :utc_datetime
          add :reason, :string
          add :status, :string
          add :manager_comments, :string
          timestamps()
        end
  end
end
