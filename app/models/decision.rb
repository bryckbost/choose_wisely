require "integer_array"

class Decision
  STEPS = %w(options factors scores answer)
  SCALE = 10

  include MongoMapper::Document

  key :factors,  Array
  key :options,  Array
  key :question, String
  key :scores,   IntegerArray
  key :step,     String
  key :token,    String
  key :weights,  IntegerArray

  before_create :set_token, :unless => :token?
  before_create :set_step, :unless => :step?

  def to_param
    token
  end

  def continue
    increment_step if save
  end

  def winner
    options.max_by{|o| score(o) }
  end

  def score(option)
    sum = 0
    scores[options.index(option)].each_with_index{|s,i| sum += s * weights[i] }
    sum
  end

  def perfect_score
    weights.sum * SCALE
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
