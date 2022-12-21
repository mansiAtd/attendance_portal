defmodule AttendancePortal.Schema.Leave do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  alias AttendancePortal.Repo
  alias AttendancePortal.Schema.User

  schema "leaves" do
    field :uid, :string
    belongs_to :user, User, foreign_key: :user_id
    field :type, :string
    field :start_date, :utc_datetime
    field :end_date, :utc_datetime
    field :reason, :string
    field :status, :string
    field :manager_comments, :string

    timestamps()
  end

  @doc false
  def changeset(leave, attrs) do
    leave
    |> cast(attrs, [:uid, :type, :start_date, :end_date, :reason, :status, :manager_comments])
  end
end
