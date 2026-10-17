ruby --version
ruby /work/hello.rb
ruby /work/blocks.rb
ruby /work/objects.rb
ruby -W:no-experimental /work/modern.rb
ruby --yjit -e 'puts "YJIT: #{RubyVM::YJIT.enabled?}"'
ruby --zjit -e 'puts "ZJIT: #{RubyVM::ZJIT.enabled?}"'
