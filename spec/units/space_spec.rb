require './lib/space'
require 'database_helpers'

describe Space do

  describe '.create' do
    it 'creates a new space' do
      space = Space.create(
        name: "Test name",
        description: "Test description",
        date_available_from: "2021-01-01",
        date_available_to: "2021-01-02",
        price: "50")

      persisted_data = persisted_data_retrieve(table: 'spaces', id: space.id)

      Space.create(
        name: "Another name",
        description: "Another description",
        date_available_from: "2021-01-11",
        date_available_to: "2021-02-12",
        price: "50")

      expect(space).to be_a Space
      # expect(space.id).to eq persisted_data.first['id']
      expect(space.description).to eq 'Test description'
      expect(space.date_available_from).to eq '2021-01-01'
      expect(space.date_available_to).to eq '2021-01-02'
      expect(space.price).to eq "50"
    end
  end
        
end
