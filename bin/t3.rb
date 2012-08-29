#!/usr/bin/env ruby

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'runner'

Runner.new

#results = []
#500.times { |result| results << Runner.new.game.end_condition }
#failure_count = results.select{|value| value != "Draw!"}.count
#failure_count > 0 ? verdict = "Sorry, the AI isn't unbeatable yet." : verdict = "Grats! You've slain the minimax monster!"
#p verdict