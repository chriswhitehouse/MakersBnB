feature 'So i can see spaces in a specified date range' do
  scenario 'I would like to be able to filter the list by date of availibility' do
    user = User.create(email: 'test@example.com', password: 'test')
    
    Space.create(
      name: "Test name",
      description: "Test description",
      date_available_from: "2021-02-02",
      date_available_to: "2021-02-20",
      price: "50",
      user_id: user.id
      )


      Space.create(
        name: "Another name",
        description: "Another Test description",
        date_available_from: "2021-03-09",
        date_available_to: "2021-03-29",
        price: "50",
        user_id: user.id
        )


      visit('/spaces')
      expect(page).to have_content('Available from')
      expect(page).to have_content('Available to')
      expect(page).to have_selector("input", :class => "show_listings")
      fill_in('available_from',with: '2021-02-01')
      fill_in('available_to',with: '2021-02-28')
      click_button('Show listings')
      expect(page).to have_content('Test name')
      expect(page).not_to have_content('Another name')
  end
end
