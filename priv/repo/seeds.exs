alias LittlestLibrary.Users.UserStore
alias LittlestLibrary.Libraries.LibraryStore

UserStore.create_admin(%{
  email: "matt@headway.io",
  password: "secret1234",
  password_confirmation: "secret1234"
})

LibraryStore.create_library(%{
  address: "602 N Lawe St",
  city: "Appleton",
  state: "WI",
  zip: "54911",
  latitude: 44.267204,
  longitude: -88.39712,
  status: "active"
})
