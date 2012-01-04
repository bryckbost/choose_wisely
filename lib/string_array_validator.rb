class StringArrayValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute) unless value.all?{|e| valid?(e) }
  end

  private
    def valid?(element)
      case element
      when String then element.present?
      else false
      end
    end
end
