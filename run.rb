#!/usr/bin/ruby -w
load 'app/simulator.rb'


# ARGV.each do|a|
#   puts "Argument: #{a}"
# end


data = File.readlines('a_data.txt')

substitute = 'PLACE ';

current_position =  data[0].gsub(/^[#{substitute}]+/, '')
current_position.delete!("\n")
current_position_arr = current_position.split(',')

result = Simulator.new(current_position_arr[0], current_position_arr[1], current_position_arr[2])
end_for = data.count() - 1
for i in 0...end_for
  if i == 0
    next
  end
  if(i == end_for)
    next
  end
  command = data[i].delete!("\n")
  if(command == ToyEnums::MOVE)
    result.move
  end
  if(command == ToyEnums::RIGHT)
    result.right
  end
  if(command == ToyEnums::LEFT)
    result.left
  end
end
puts result.report
# puts a
# puts a.count()

# for i in 0..4
#   puts a[i]
# end

