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
  status: "active",
  image:
    "https://bloximages.chicago2.vip.townnews.com/auburnpub.com/content/tncms/assets/v3/editorial/5/80/580e1e82-e642-50f5-bd71-674207d79b2e/558d79d6d7ad7.image.jpg",
  thumbnail:
    "https://bloximages.chicago2.vip.townnews.com/auburnpub.com/content/tncms/assets/v3/editorial/5/80/580e1e82-e642-50f5-bd71-674207d79b2e/558d79d6d7ad7.image.jpg"
})
