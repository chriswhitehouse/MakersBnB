feature "So spaces don't get double booked" do
  scenario "It should not allow me to book a date that has already been booked" do
    owner = User.create(email: 'owner@example.com', password: 'test', username: 'test_user')

    space = Space.create(
      name: "Test name",
      description: "Test description",
      date_available_from: "2021-02-02",
      date_available_to: "2021-02-20",
      price: "50",
      user_id: owner.id
      )

    requester = User.create(email: 'requester@example.com', password: 'test', username: 'test_user')

    request = Request.create(user_id: requester.id, requested_date: '2021-01-15', space_id: space.id)
    Request.update_status(id: request.id, status: 'confrimed')


    sign_up

    visit('/spaces')
    first('.space').click_button 'More details'

    expect(current_path).to eq "/spaces/#{space.id}"
    expect(page).to have_content("Test name")
    fill_in('requested_date', with: "2021-01-15")
    click_button('Make a request')
    expect(current_path).to eq "/spaces/#{space.id}"
    expect(page).to have_content 'Space already booked for that date'
  end
end
