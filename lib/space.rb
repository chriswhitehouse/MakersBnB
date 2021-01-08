require_relative 'user'

class Space

  attr_reader :id, :name, :description, :price, :date_available_from, :date_available_to, :user_id


  def self.all
    result = DatabaseConnection.query("SELECT * FROM spaces;")
    result.map do |space|
      Space.new(
        id: space['id'],
        name: space['name'],
        description: space['description'],
        date_available_from: space['date_available_from'],
        date_available_to: space['date_available_to'],
        price: space['price'],
        user_id: space['owner_id'])
    end
  end

  def self.create(name:, description:, price:, date_available_from:, date_available_to:, user_id:)
    result = DatabaseConnection.query("INSERT INTO spaces (name, description, price, date_available_from, date_available_to, owner_id ) VALUES('#{name}', '#{description}', '#{price}', '#{date_available_from}', '#{date_available_to}','#{user_id}') RETURNING id, name, description, price, date_available_from, date_available_to, owner_id")

    Space.new(
      id: result[0]['id'],
      name: result[0]['name'],
      description: result[0]['description'],
      date_available_from: result[0]['date_available_from'],
      date_available_to: result[0]['date_available_to'],
      price: result[0]['price'],
      user_id: result[0]['owner_id'])
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
        price: space['price'],
        user_id: space['owner_id'])
      end
  end

  def self.find(id:)
    return nil unless id
    result = DatabaseConnection.query("SELECT * FROM spaces WHERE id = #{id}").first

    Space.new(
      id: result['id'],
      name: result['name'],
      description: result['description'],
      date_available_from: result['date_available_from'],
      date_available_to: result['date_available_to'],
      price: result['price'],
      user_id: result['owner_id'])

  end

  # needs test
  def self.where(id:)
    space = DatabaseConnection.query("SELECT * FROM spaces WHERE id = #{id};")
    Space.new(
      id: space[0]['id'],
      name: space[0]['name'],
      description: space[0]['description'],
      date_available_from: space[0]['date_available_from'],
      date_available_to: space[0]['date_available_to'],
      price: space[0]['price'],
      user_id: space[0]['owner_id'])
  end

  def initialize(id:, name:, description:, price:, date_available_from:, date_available_to:, user_id:)
    @id = id
    @name = name
    @description = description
    @price = price
    @date_available_from = date_available_from
    @date_available_to = date_available_to
    @user_id = user_id
  end
end
