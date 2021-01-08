feature 'authentication' do
  scenario 'a user sees an error if they get their email wrong' do
    User.create(email: 'test@example.com', password: 'password123', username: 'testuser')

    visit('/')
    click_button('Sign in')
    expect(current_path).to eq '/sessions/new'
    fill_in(:email, with: 'nottherightemail@me.com')
    fill_in(:password, with: 'password123')
    click_button('Confirm')

    expect(page).not_to have_content('Welcome, testuser')
    expect(page).to have_content('Please check your email or password')
  end

  scenario 'a user sees an error if they get their password wrong' do
    User.create(email: 'test@example.com', password: 'password123', username: 'testuser')

    visit('/')
    click_button('Sign in')
    expect(current_path).to eq '/sessions/new'
    fill_in(:email, with: 'test@example.com')
    fill_in(:password, with: 'notthecorrectpassword123')
    click_button('Confirm')

    expect(page).not_to have_content('Welcome, testuser')
    expect(page).to have_content('Please check your email or password')
  end

  scenario 'a user can sign out' do
    User.create(email: 'test@example.com', password: 'password123', username: 'testuser')

    visit('/')
    click_button('Sign in')
    expect(current_path).to eq '/sessions/new'
    fill_in(:email, with: 'test@example.com')
    fill_in(:password, with: 'password123')
    click_button('Confirm')

    click_button('Sign out')

    expect(page).not_to have_content('Welcome, test@example.com')
    expect(page).to have_selector("input", :class => 'sign_in')
  end

end
