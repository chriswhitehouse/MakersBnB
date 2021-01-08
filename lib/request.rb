require_relative 'space'

class Request

  attr_reader :id, :user_id, :requested_date, :space_id, :status

  def self.create(user_id:, requested_date: , space_id:, status:'requested')
    # result = DatabaseConnection.query("SELECT * FROM requests WHERE requested_date = #{requested_date} AND space_id = #{space_id};")
    # return unless !result.any?
    result = DatabaseConnection.query("INSERT INTO requests (requester_id, requested_date, space_id, status ) VALUES('#{user_id}', '#{requested_date}', '#{space_id}','#{status}') RETURNING id, requester_id, requested_date, space_id, status")

    Request.new(
      id: result[0]['id'],
      user_id: result[0]['requester_id'],
      requested_date: result[0]['requested_date'],
      space_id: result[0]['space_id'],
      status: result[0]['status'])
  end

  def self.find(id:)
    result = DatabaseConnection.query("SELECT * FROM requests WHERE id = #{id};")

    Request.new(
      id: result[0]['id'],
      user_id: result[0]['requester_id'],
      requested_date: result[0]['requested_date'],
      space_id: result[0]['space_id'],
      status: result[0]['status'])

  end

  def self.update_status(id:, status:)
    result = DatabaseConnection.query("UPDATE requests SET status = '#{status}' WHERE id = #{id} RETURNING id, requester_id, requested_date, space_id, status;")

    Request.new(
      id: result[0]['id'],
      user_id: result[0]['requester_id'],
      requested_date: result[0]['requested_date'],
      space_id: result[0]['space_id'],
      status: result[0]['status'])

  end

  def self.all_made(user_id:)
    result = DatabaseConnection.query("SELECT * FROM requests WHERE requester_id = #{user_id};")

    result.map do |request|
      Request.new(
        id: request['requests.id'],
        user_id: request['requester_id'],
        requested_date: request['requested_date'],
        space_id: request['space_id'],
        status: request['status'])
      end
  end

  def space_info(space_class = Space)
    space_class.where(id: space_id)
  end

  # needs test
  def self.all_received(user_id:)
    result = DatabaseConnection.query("SELECT requests.id, requested_date, space_id, status FROM requests INNER JOIN spaces ON spaces.id = requests.space_id WHERE owner_id = #{user_id};");

    result.map do |request|
      Request.new(
        id: request['requests.id'],
        user_id: request['requester_id'],
        requested_date: request['requested_date'],
        space_id: request['space_id'],
        status: request['status'])
      end

  end

  def initialize(id:, user_id:, requested_date: , space_id:, status:)
    @id = id
    @user_id = user_id
    @requested_date = requested_date
    @space_id = space_id
    @status = status
  end

end
