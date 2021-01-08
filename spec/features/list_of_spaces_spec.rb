feature "So i can choose a space" do
  scenario "I would like to see a list of spaces" do
    user = User.create(email: 'test@example.com', password: 'test', username: 'testuser')

    Space.create(
      name: "Test name",
      description: "Test description",
      date_available_from: "2021-01-01",
      date_available_to: "2021-01-02",
      price: "50",
      user_id: user.id
      )

    Space.create(
      name: "Another name",
      description: "Another description",
      date_available_from: "2021-01-11",
      date_available_to: "2021-02-12",
      price: "50",
      user_id: user.id)

    visit('/spaces')
    expect(page).to have_selector("input", :class => "list_a_space")
    expect(page).not_to have_content('sinatra')
    expect(page).to have_content('Book A Space')
    expect(page).to have_content("Test name")
    expect(page).to have_content("Another description")
    expect(page).to have_content("Another name")
  end
end
