#!/usr/bin/env ruby

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'runner'

Runner.new

# results = []
# 300.times { |a| results << Runner.new.game.end_condition }
# p results