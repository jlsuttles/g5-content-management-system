class HashWithToLiquid < Hash
  def to_liquid
    liquid = {}
    each_pair do |key, value|
      liquid[key.to_s] = value.to_liquid
    end
    liquid
  end
end
