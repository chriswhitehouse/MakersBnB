feature 'As a user So that i can rent an owners space I would like to be able to request an owners space for one night' do
  scenario 'user makes a single request' do
    user = User.create(email: 'test@example.com', password: 'test', username: 'testuser')

    space = Space.create(
      name: "Lovely space",
      description: "Lovely description",
      date_available_from: "2021-01-01",
      date_available_to: "2021-01-02",
      price: "50",
      user_id: user.id
      )

    sign_up
    visit('/spaces')
    first('.space').click_button 'More details'

    expect(current_path).to eq "/spaces/#{space.id}"
    expect(page).to have_content("Lovely space")
    fill_in('requested_date', with: "2021-01-01")
    click_button('Make a request')
    expect(current_path).to eq "/spaces"

  end
end
