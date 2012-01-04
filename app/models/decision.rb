require "integer_array"

class Decision
  SCALE = 10

  include MongoMapper::Document

  key :factors,  Array
  key :options,  Array
  key :question, String
  key :scores,   IntegerArray
  key :state,    String
  key :token,    String
  key :weights,  IntegerArray

  before_create :set_token, :unless => :token?

  state_machine :initial => :questioned do
    state :questioned do
      validates :question, :presence => true
    end

    state :optioned do
      validates :options, :presence => true
    end

    state :factored do
      validates :factors, :presence => true
    end

    state :weighted do
      validates :weights, :presence => true
    end

    state :scored do
      validates :scores, :presence => true
    end

    event :continue do
      transition :questioned => :optioned
      transition :optioned => :factored
      transition :factored => :weighted
      transition :weighted  => :scored
    end
  end

  def to_param
    token
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
      self.token = SecureRandom.urlsafe_base64(8)
    end
end
