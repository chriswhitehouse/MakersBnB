class Space

  attr_reader :id, :name, :description, :price, :date_available_from, :date_available_to

  def self.all
    result = DatabaseConnection.query("SELECT * FROM spaces;")
    result.map do |space|
      Space.new(
        id: space['id'],
        name: space['name'],
        description: space['description'],
        date_available_from: space['date_available_from'],
        date_available_to: space['date_available_to'],
        price: space['price'])
    end
  end

  def self.create(name:, description:, price:, date_available_from:, date_available_to:)
    result = DatabaseConnection.query("INSERT INTO spaces (name, description, price, date_available_from, date_available_to ) VALUES('#{name}', '#{description}', '#{price}', '#{date_available_from}', '#{date_available_to}') RETURNING id, name, description, price, date_available_from, date_available_to")
    Space.new(
      id: result[0]['id'],
      name: result[0]['name'],
      description: result[0]['description'],
      date_available_from: result[0]['date_available_from'],
      date_available_to: result[0]['date_available_to'],
      price: result[0]['price'])
  end

  def self.filter(from:, to:)
    result = DatabaseConnection.query("SELECT * FROM spaces WHERE date_available_from <= cast('#{to}' as date) and date_available_to >= cast('#{from}' as date);")
    result.map do |space|
      Space.new(
        id: space['id'],
        name: space['name'],
        description: space['description'],
        date_available_from: space['date_available_from'],
        date_available_to: space['date_available_to'],
        price: space['price'])
      end
  end

  def initialize(id:, name:, description:, price:, date_available_from:, date_available_to:)
    @id = id
    @name = name
    @description = description
    @price = price
    @date_available_from = date_available_from
    @date_available_to = date_available_to
  end

end
