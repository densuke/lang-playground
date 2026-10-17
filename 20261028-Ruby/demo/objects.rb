# クラスは開いて足せる。Integer にもメソッドを足せる
class Integer
  def double = self * 2
end
p 21.double

# Comparable を include すると <=> から比較が全部手に入る
class Version
  include Comparable
  attr_reader :parts
  def initialize(s) = @parts = s.split(".").map(&:to_i)
  def <=>(other) = parts <=> other.parts
  def to_s = parts.join(".")
end
vs = %w[4.0.7 3.4.11 4.1.0].map { Version.new(_1) }
puts vs.sort.join(" < ")
puts vs.max
