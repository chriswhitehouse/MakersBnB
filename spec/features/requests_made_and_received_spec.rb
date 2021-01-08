feature "As a user, So I know the status of my requests, I would like to be able to see a list of requests I have made and received" do
  scenario "After logging in as a user I can see requests I've made and received" do
    User.create(email: 'test@example.com', password: 'test', username: 'testuser')

    visit('/')
    click_button('Sign in')
    expect(current_path).to eq '/sessions/new'

    fill_in('email', with: 'test@example.com')
    fill_in('password', with: 'test')
    click_button('Confirm')
    expect(current_path).to eq '/spaces'

    click_link('Requests')
    expect(page).to have_content("Requests I've made")
    expect(page).to have_content("Requests I've received")
    expect(current_path).to eq '/requests'
  end
end
