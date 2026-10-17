puts RUBY_DESCRIPTION
puts "YJIT: #{defined?(RubyVM::YJIT) ? RubyVM::YJIT.enabled? : 'なし'}"
puts "ZJIT: #{defined?(RubyVM::ZJIT) ? RubyVM::ZJIT.enabled? : 'なし'}"

# パターンマッチ
config = { name: "pd2", langs: ["ruby", "r"], version: { major: 4, minor: 0 } }
case config
in { name: String => name, version: { major: 4.. => major } }
  puts "#{name} は Ruby #{major} 系"
end
case [1, [2, 3]]
in [Integer => a, [b, *rest]]
  p a: a, b: b, rest: rest
end

# Ractor: 並列実行 (実験的機能)
r = Ractor.new { (1..1000).sum }
puts "Ractor: #{r.value}"
