feature "Signing up to website" do
  scenario "A user can enter a email and password to sign up to the site" do
    visit('/')
    expect(page).to have_content 'Make it a MakersBnB'
    fill_in('email',with: 'bob@gmail.com')
    fill_in('password',with: 'password123')
    fill_in('username',with: 'bob')
    click_button('Sign up')

    expect(current_path).to eq ('/spaces')
    expect(page).to have_content 'Book A Space'
  end
end
