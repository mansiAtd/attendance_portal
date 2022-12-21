alias AttendancePortal.Repo
alias AttendancePortal.Schema.User
alias AttendancePortal.Schema.Leaves
# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     HelpingHand.Repo.insert!(%HelpingHand.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.


user_data = [
  User.changeset(
    %User{},
    %{
      uid: "nuser-" <> Ecto.UUID.generate(),
      emp_id: "ATD01",
      name: "Kiran",
      password: "automatad@01",
      designation: "CTO",
      email: "kiran@automatad.com"
    }
  ),
  User.changeset(
    %User{},
    %{
      uid: "nuser-" <> Ecto.UUID.generate(),
      emp_id: "ATD02",
      name: "Vamsi Krishna",
      password: "automatad@02",
      designation: "Engnieering Manager",
      email: "vamsi@automatad.com"
    }
  ),
  User.changeset(
    %User{},
    %{
      uid: "nuser-" <> Ecto.UUID.generate(),
      emp_id: "ATD03",
      name: "Mohan",
      password: "automatad@03",
      designation: "Engnieering Manager",
      email: "mohan@automatad.com"
    }
  ),
  User.changeset(
    %User{},
    %{
      uid: "nuser-" <> Ecto.UUID.generate(),
      emp_id: "ATD04",
      name: "Ganesh Prabhu",
      password: "automatad@04",
      designation: "Software Developer",
      email: "ganesh@automatad.com"
    }
  )
]

Enum.each(
  user_data,
  fn data ->
    AttendancePortal.Repo.insert(data)
  end
)
