#!/usr/bin/ruby -w
load 'app/simulator.rb'


# ARGV.each do|a|
#   puts "Argument: #{a}"
# end


data = File.readlines('a_example.txt')

simulator = Simulator.new
simulator.run data


