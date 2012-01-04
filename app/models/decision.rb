require "integer_array"

class Decision
  STEPS = %w(options factors weights scores answer)
  SCALE = 10

  include MongoMapper::Document

  key :factors,  Array
  key :options,  Array
  key :question, String
  key :scores,   IntegerArray
  key :step,     String
  key :token,    String
  key :weights,  IntegerArray

  validates :question, :presence => true

  before_create :set_token, :unless => :token?
  before_create :set_step, :unless => :step?

  def to_param
    token
  end

  def continue
    increment_step if save
  end

  def winner
    winners.first
  end

  def winners
    options.sort_by{|o| score(o) }.reverse
  end

  def score(option)
    sum = 0
    scores[options.index(option)].each_with_index{|s,i| sum += s * weights[i] }
    sum
  end

  def confidence
    score_1, score_2 = winners.first(2).map{|w| score(w) }
    score_1.to_f / (score_1 + score_2) * 100
  end

  def percentage(option)
    score(option).to_f / perfect_score * 100
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
