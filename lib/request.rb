
class Request

  attr_reader :id, :user_id, :requested_date, :space_id, :status

  def self.create(user_id:, requested_date: , space_id:, status:'requested')
    result = DatabaseConnection.query("INSERT INTO requests (user_id, requested_date, space_id, status ) VALUES('#{user_id}', '#{requested_date}', '#{space_id}','#{status}') RETURNING id, user_id, requested_date, space_id, status")

    Request.new(
      id: result[0]['id'],
      user_id: result[0]['user_id'],
      requested_date: result[0]['requested_date'],
      space_id: result[0]['space_id'],
      status: result[0]['status'])
  end

  def self.find(id:)
    result = DatabaseConnection.query("SELECT * FROM requests WHERE id = #{id};")

    Request.new(
      id: result[0]['id'],
      user_id: result[0]['user_id'],
      requested_date: result[0]['requested_date'],
      space_id: result[0]['space_id'],
      status: result[0]['status'])

  end

  def self.update_status(id:, status:)
    result = DatabaseConnection.query("UPDATE requests SET status = '#{status}' WHERE id = #{id} RETURNING id, user_id, requested_date, space_id, status;")

    Request.new(
      id: result[0]['id'],
      user_id: result[0]['user_id'],
      requested_date: result[0]['requested_date'],
      space_id: result[0]['space_id'],
      status: result[0]['status'])

  end

  def initialize(id:, user_id:, requested_date: , space_id:, status:)
    @id = id
    @user_id = user_id
    @requested_date = requested_date
    @space_id = space_id
    @status = status
  end

end
