alias Tri.Repo

Repo.insert!(%Tri.Account.User{
  display_name: "User Test",
  email: "email@mail.com",
  password: "123456",
  image: "http://img.web.com/usuario.png"
})
