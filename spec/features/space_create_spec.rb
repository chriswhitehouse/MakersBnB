feature 'signed in user can create a new listing' do
  scenario 'creates listing' do

    visit('/spaces/new')
    fill_in('name', with: 'Beautiful test space')
    fill_in('description', with: 'This is a test description')
    fill_in('date_available_from', with: "2021-01-01")
    fill_in('date_available_to', with: "2021-01-02")
    fill_in('price', with: "50")

    click_button('confirm')

    expect(current_path).to eq '/spaces'
    expect(current_path).not_to eq '/spaces/new'
    expect(page).not_to have_selector("input", :class => "confirm")
  end
end

