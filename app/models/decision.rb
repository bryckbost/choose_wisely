class Decision
  include MongoMapper::Document

  key :question, String
  key :token,    String

  before_create :set_token, :unless => :token?

  def to_param
    token
  end

  private
    def set_token
      self.token = SecureRandom.hex
    end
end
