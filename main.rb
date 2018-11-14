#!/usr/bin/ruby -w
load 'app/simulator.rb'
print"Enter example(can chose: [a|b|c]): "
example = gets
example = example.strip
if ['a', 'b', 'c'].include? example
  data = File.readlines('example_data/' + example + '.txt')
  simulator = Simulator.new
  simulator.run data
else
  puts "Example not exists!"
end