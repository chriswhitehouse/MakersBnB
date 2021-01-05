require 'space'
require_relative 'database_helpers'

describe Space do

  describe '.create' do
    it 'creates a new space' do
      space = Space.create(
        name: "Test name",
        description: "Test description",
        available_from: "01/01/2021",
        available_to: "02/01/2021",
        price: 50)

      persisted_data = persisted_data_retrieve(table: 'spaces', id: spaces.id)

      space = Space.create(
        name: "Another name",
        description: "Another description",
        available_from: "11/11/2021",
        available_to: "12/12/2021",
        price: 50)

      expect(space).to be_a Space
      expect(space.id).to eq persisted_data.first['id']
      expect(space.description).to eq 'Test description'
      expect(space.available_from).to eq '01/01/2021'
      expect(space.available_to).to eq '02/01/2021'
      expect(space.price).to eq 50
    end
  end
        
end
