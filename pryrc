def prefix
  version = Pry::Helpers::BaseHelpers.jruby? ? JRUBY_VERSION : RUBY_VERSION
  "#{RUBY_ENGINE}-#{version}"
end

Pry.prompt = [
  proc { |target_self, nest_level, pry|
    "#{prefix} [#{pry.input_array.size}] pry(#{Pry.view_clip(target_self)})#{":#{nest_level}" unless nest_level.zero?}> "
  },
  proc { |target_self, nest_level, pry|
    "#{prefix} [#{pry.input_array.size}] pry(#{Pry.view_clip(target_self)})#{":#{nest_level}" unless nest_level.zero?}* "
  }
]
