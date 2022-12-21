defmodule AttendancePortal.Leaves do
  import Ecto.Query, warn: false
  alias AttendancePortal.Repo
  alias AttendancePortal.Schema.{Leave, User}


  def create_leave(user_id, params) do
    user = from(c in User,
      where: c.uid == ^user_id,
      select: c
    )
    |> Repo.one()

    attrs =
      params
      |> Map.put("user_id", user.id)
      |> Map.put("uid", "nleave-" <> Ecto.UUID.generate())

  {:ok, leave} =  %Leave{}
    |> Leave.changeset(attrs)
    |> Repo.insert()

  AttendancePortal.SendEmail.send_email(user, leave)

  {:ok, leave}
  end

  def update_leave(leave_id, params) do
    leave = get_leave_by_uid(leave_id)

    if is_nil(leave) do
      {:error, :not_found, "leave doesn't exist."}
    else
        {:ok, leave} =
        leave
        |> Leave.changeset(params)
        |> Repo.update()

        AttendancePortal.SendEmail.approval_email()

        {:ok, leave}
    end
  end

  def delete_leave(uid) do
    leave = get_leave_by_uid(uid)

    if is_nil(leave) do
      {:error, :not_found, "leave doesn't exist."}
    else

        Repo.delete(leave)
    end
  end

  def get_leave_by_uid(uid) do
    from(c in Leave,
      where: c.uid == ^uid,
      select: c
    )
    |> Repo.one()
  end

  def get_leaves() do
    from(c in Leave,
      where: c.status == "Pending",
      select: c
    )
    |> Repo.all()
  end

  def get_user_name(id) do
    user = from(c in User,
      where: c.id == ^id,
      select: c
    )
    |> Repo.one()

    user.name
  end

end
