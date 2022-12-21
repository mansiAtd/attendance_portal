defmodule AttendancePortal.Leaves do
  import Ecto.Query, warn: false
  alias AttendancePortal.Repo
  alias AttendancePortal.Schema.{Leave, User}
  alias Services.Mailer

  def create_leave(user_id, params) do
    id = from(c in User,
      where: c.uid == ^user_id,
      select: c.id
    )
    |> Repo.one()
    attrs =
      params
      |> Map.put("user_id", id)
      |> Map.put("uid", "nleave-" <> Ecto.UUID.generate())

    %Leave{}
    |> Leave.changeset(attrs)
    |> Repo.insert()
  end

  def update_leave(leave_id, params) do
    leave = get_leave_by_uid(leave_id)

    if is_nil(leave) do
      {:error, :not_found, "leave doesn't exist."}
    else
        leave
        |> leave.changeset(params)
        |> Repo.update()
    end
  end

  def delete_leave(uid, user_id) do
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

  # defp send_email(restaurant_email, details) do
  #   email =
  #     new_email()
  #     |> to(restaurant_email)
  #     |> from("helping-hand-noreply@gmail.com")
  #     |> subject("New Order from #{details.ngo_name}")
  #     |> put_layout({HelpingHandWeb.EmailView, :send_email})
  #     |> assign(:details, details)
  #     |> render(:email_with_assigns)
  #
  #   Mailer.deliver_now(email)
  # end
end
