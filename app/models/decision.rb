class Decision
  STEPS = %w(question options factors scores answer)

  include MongoMapper::Document

  key :question, String
  key :step,     String
  key :token,    String

  before_create :set_token, :unless => :token?
  before_create :set_step, :unless => :step?

  def to_param
    token
  end

  def continue
    increment_step
    save
  end

  private
    def set_token
      self.token = SecureRandom.hex
    end

    def set_step
      self.step = STEPS.first
    end

    def increment_step
      self.step = STEPS[STEPS.index(step) + 1]
    end
  end
