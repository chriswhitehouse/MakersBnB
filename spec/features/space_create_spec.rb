feature 'signed in user can create a new listing' do
  scenario 'creates listing' do
    sign_up
    visit('/spaces/new')
    fill_in('name', with: 'Beautiful test space')
    fill_in('description', with: 'This is a test description')
    fill_in('date_available_from', with: "2021-01-01")
    fill_in('date_available_to', with: "2021-01-02")
    fill_in('price', with: "50")

    click_button('Confirm')

    expect(current_path).to eq '/spaces'
    expect(current_path).not_to eq '/spaces/new'
    expect(page).not_to have_selector("input", :class => "confirm")
  end

  scenario 'signed in user/owner can create multiple listings' do
    sign_up

    expect(current_path).to eq('/spaces')
    click_button('List a Space')
    fill_in('name', with: 'Beautiful test space')
    fill_in('description', with: 'This is a beautiful test description')
    fill_in('date_available_from', with: "2021-01-01")
    fill_in('date_available_to', with: "2021-01-02")
    fill_in('price', with: "50")
    click_button('Confirm')

    click_button('List a Space')
    fill_in('name', with: 'Lovely test space')
    fill_in('description', with: 'This is a lovely test description')
    fill_in('date_available_from', with: "2021-05-06")
    fill_in('date_available_to', with: "2021-05-07")
    fill_in('price', with: "60")
    click_button('Confirm')

    expect(current_path).to eq '/spaces'
    expect(current_path).not_to eq '/spaces/new'
    expect(page).not_to have_selector("input", :class => "confirm")
    expect(page).to have_content("Beautiful test space")
    expect(page).to have_content("Date available: 2021-01-01 until: 2021-01-02")
    expect(page).to have_content("Lovely test space")
    expect(page).to have_content("Date available: 2021-05-06 until: 2021-05-07")
  end

end
