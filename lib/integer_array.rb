class IntegerArray < Array
  def self.to_mongo(value)
    case value
    when Hash then value.inject([]){|a,(k,v)| a[k.to_i] = to_mongo(v); a }
    when Array then value.map{|v| to_mongo(v) }
    when Integer then value
    when /^\d+$/ then value.to_i
    else nil
    end
  end

  def self.from_mongo(value)
    value || []
  end
end
