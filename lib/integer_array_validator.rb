class IntegerArrayValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute) unless value.all?{|e| valid?(e) }
  end

  private
    def valid?(element)
      case element
      when Integer then (0..Decision::SCALE).cover?(element)
      when /^(\d|10)$/ then true
      when Array then element.all?{|e| valid?(e) }
      else false
      end
    end
end
