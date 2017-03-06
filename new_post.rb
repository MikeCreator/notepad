if(Gem.win_platform?)
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

require_relative "post.rb"
require_relative "link.rb"
require_relative "memo.rb"
require_relative "task.rb"


puts "Блоконот"
puts "Что хотите записать?"
choices = Post.post_types.keys
choice = -1
until choice >=0 and choice <choices.size

  choices.each_with_index do |type, index|
    puts "\t#{(index+1)}. #{type}"
  end

  choice = STDIN.gets.chomp.to_i
  choice -= 1
end

entry = Post.create(choices[(choice)])
entry.read_from_console
id = entry.save_to_db

puts "Запись сохранена, id = #{id}"