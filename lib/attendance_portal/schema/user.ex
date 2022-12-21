defmodule AttendancePortal.Schema.User do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  alias AttendancePortal.Repo

  schema "users" do
    field :email, :string
    field :emp_id, :string
    field :designation, :string
    field :name, :string
    field :uid, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :name, :password, :emp_id, :designation, :uid])
    |> validate_required([:email, :name, :password, :uid])
    |> validate_changeset
  end

  defp validate_changeset(user) do
    user
    |> validate_length(:email, min: 5, max: 255)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> unique_constraint(:emp_id)
    |> validate_length(:password, min: 8)
    |> generate_password_hash
  end

  defp generate_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password_hash, Bcrypt.hash_pwd_salt(password))

      _ ->
        changeset
    end
  end
end
