feature 'signed in user can create a new listing' do
  scenario 'creates listing' do

    visit('/spaces/new')
    fill_in('name', with: 'Beautiful test space')
    fill_in('description', with: 'This is a test description')
    fill_in('available_from', with: 01/01/2021)
    fill_in('available_to', with: 01/01/2021)
    fill_in('Price', with: 50)

    click_button('confirm')

    expect(current_path).to eq '/spaces'
    expect(current_path).not_to eq '/spaces/new'
    expect(page).not_to have_selector("input", :class => "confirm")
  end
end
