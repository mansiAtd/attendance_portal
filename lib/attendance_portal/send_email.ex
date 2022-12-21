defmodule AttendancePortal.SendEmail do
  alias Services.Mailer
  use Bamboo.Phoenix, view: AttendancePortalWeb.EmailView

  def send_email(user, leave) do
    details = %{
      start_date: leave.start_date,
    end_date: leave.end_date,
    type: leave.type,
    name: user.name
    }

    email =
      new_email()
      |> to("vamsi@automatad.com")
      |> from("no-reply-attendance-portal@gmail.com")
      |> subject(" Leave Application from #{user.name}")
      |> put_layout({AttendancePortalWeb.EmailView, :notify_manager})
      |> assign(:details, details)
      |> render(:notify_manager)

    Mailer.deliver_now(email)
  end

  def approval_email() do

    email =
      new_email()
      |> to("ganesh@automatad.com")
      |> from("no-reply-attendance-portal@gmail.com")
      |> subject(" Leave Application approved.")
      |> put_layout({AttendancePortalWeb.EmailView, :notification})
      |> render(:notification)

    Mailer.deliver_now(email)
  end
end
