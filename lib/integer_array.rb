class IntegerArray < Array
  def self.to_mongo(value)
    case value
    when Hash then value.inject([]){|a,(k,v)| a[k.to_i] = to_mongo(v); a }
    when Array then value.map{|v| to_mongo(v) }
    when nil, "" then []
    else value.to_i
    end
  end

  def self.from_mongo(value)
    value || []
  end
end
