feature "As a user, so I can make changes to my bookings/listings, I would like to log in" do
  scenario "A previous user can sign in to the site" do
    User.create(email: 'test@example.com', password: 'test', username: 'testuser')

    visit('/')
    click_button('Sign in')
    expect(current_path).to eq '/sessions/new'

    fill_in('email', with: 'test@example.com')
    fill_in('password', with: 'test')
    click_button('Confirm')
    expect(current_path).to eq '/spaces'
  end
end
