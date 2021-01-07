require 'request'

describe Request do
  describe '.create' do
    it 'should record a request in requests table and return a request instance' do
      owner = User.create(email: 'test@example.com', password: 'test')

      space = Space.create(
        name: "Test name",
        description: "Test description",
        date_available_from: "2021-01-01",
        date_available_to: "2021-01-29",
        price: "50",
        user_id: owner.id
        )

      requester = User.create(email: 'user@example.com', password: 'user')

      request = Request.create(user_id: requester.id, date: '2021-01-15', space_id: space.id)
      persisted_data = persisted_data_retrieve(table: requests, id: request.id)

      expect(request).to be_a Request
      expect(request.date).to eq '2021-01-15'
      expect(request.id).to eq persisted_data['id']
    end
  end
end
