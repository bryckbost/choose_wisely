class Decision
  STEPS = %w(options factors scores answer)

  include MongoMapper::Document

  key :options,  Array
  key :question, String
  key :step,     String
  key :token,    String

  before_create :set_token, :unless => :token?
  before_create :set_step, :unless => :step?

  def to_param
    token
  end

  def continue
    increment_step if save
  end

  private
    def set_token
      self.token = SecureRandom.hex
    end

    def set_step
      self.step = STEPS.first
    end

    def increment_step
      update_attribute(:step, next_step) if next_step
    end

    def next_step
      STEPS[STEPS.index(step) + 1]
    end
  end
