alias LittlestLibrary.Users.UserStore
alias LittlestLibrary.Libraries.LibraryStore

UserStore.create_admin(%{
  email: "matt@headway.io",
  password: "secret1234",
  password_confirmation: "secret1234"
})
