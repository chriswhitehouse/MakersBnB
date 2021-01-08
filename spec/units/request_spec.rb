require 'request'

describe Request do
  describe '.create' do
    it 'should record a request in requests table and return a request instance' do
      owner = User.create(email: 'test@example.com', password: 'test', username: 'testuser1')

      space = Space.create(
        name: "Test name",
        description: "Test description",
        date_available_from: "2021-01-01",
        date_available_to: "2021-01-29",
        price: "50",
        user_id: owner.id
        )

      requester = User.create(email: 'user@example.com', password: 'user', username: 'testuser2')

      request = Request.create(user_id: requester.id, requested_date: '2021-01-15', space_id: space.id)
      persisted_data = persisted_data_retrieve(table: 'requests', id: request.id)

      expect(request).to be_a Request
      expect(request.requested_date).to eq '2021-01-15'
      expect(request.id).to eq persisted_data['id']
      expect(request.status).to eq('requested')
    end
  end

  describe '.all_made' do
    it 'should show all requests made' do
      owner = User.create(email: 'test@example.com', password: 'test', username: 'testuser1')
      requester = User.create(email: 'test1@example.com', password: 'test1', username: 'testuser2')

      space = Space.create(
        name: "Test Name",
        description: "Test description",
        date_available_from: "2021-01-01",
        date_available_to: "2021-01-02",
        price: "50",
        user_id: owner.id)

      Space.create(
        name: "Lovely space",
        description: "Lovely description",
        date_available_from: "2021-03-03",
        date_available_to: "2021-01-04",
        price: "70",
        user_id: owner.id)

      Space.create(
        name: "Another Lovely space",
        description: "Anothr Lovely description",
        date_available_from: "2021-04-04",
        date_available_to: "2021-05-04",
        price: "170",
        user_id: requester.id)

      request1 = Request.create(user_id: requester.id, requested_date: '2021-01-01', space_id: space.id)
      request2 = Request.create(user_id: requester.id, requested_date: '2021-03-03', space_id: space.id)

      persisted_data = persisted_data_retrieve(table: 'requests', id: request1.id)

      requests = Request.all_made(user_id: requester.id)

      expect(requests.length).to eq(2)
      expect(requests.first).to be_a(Request)
      expect(request1.requested_date).to eq('2021-01-01')
    end
  end

end
