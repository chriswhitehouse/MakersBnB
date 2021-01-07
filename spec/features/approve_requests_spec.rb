require 'request'

feature 'So I can approve a request' do
  scenario 'I would like to be able to confirm requests on my space' do
    owner = User.create(email: 'owner@example.com', password: 'test')

    space = Space.create(
      name: "Test name",
      description: "Test description",
      date_available_from: "2021-02-02",
      date_available_to: "2021-02-20",
      price: "50",
      user_id: owner.id
      )

    requester = User.create(email: 'requester@example.com', password: 'test')

    request = Request.create(user_id: requester.id, requested_date: '2021-01-15', space_id: space.id)

    visit("/requests/#{request.id}")

    expect(page).not_to have_content 'Sinatra'
    expect(page).to have_content "Request for '#{space.name}'"
    expect(page).to have_content "From: #{requester.email}"
    expect(page).to have_content "Date: #{request.requested_date}"
    click_button("Confirm request from #{requester.email}")
    expect(current_path).to eq '/spaces'
  end

  scenario 'I would like to be able to deny requests on my space' do
    owner = User.create(email: 'owner@example.com', password: 'test')

    space = Space.create(
      name: "Test name",
      description: "Test description",
      date_available_from: "2021-02-02",
      date_available_to: "2021-02-20",
      price: "50",
      user_id: owner.id
      )

    requester = User.create(email: 'requester@example.com', password: 'test')

    request = Request.create(user_id: requester.id, requested_date: '2021-01-15', space_id: space.id)

    visit("/requests/#{request.id}")

    expect(page).not_to have_content 'Sinatra'
    expect(page).to have_content "Request for '#{space.name}'"
    expect(page).to have_content "From: #{requester.email}"
    expect(page).to have_content "Date: #{request.requested_date}"
    click_button("Deny request from #{requester.email}")
    expect(current_path).to eq '/spaces'

  end
end
