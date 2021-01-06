def sign_up
  visit('/users/new')
  fill_in('email', with: 'test@example.com')
  fill_in('password', with: 'fakepassword123')
  click_button('Sign up')
end
