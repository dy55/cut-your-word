# frozen_string_literal: true

require 'json'
require_relative './wordpart/root_word'
require_relative './wordpart/dictionary'

dict_path = './dict/dict.json'

@loop = true
@exit_immediately = false

@escapes = {
  exit: { exec: -> { exit(0) }, description: 'Exit input loop' },
  help: { exec: -> { print_help }, description: 'Print this help info' },
  once: { exec: -> { @loop = false }, description: 'Evaluate words once' },
  "exit-then": {
    exec: -> { @exit_immediately = true },
    description: 'Exit immediately after eval instead of waiting for Enter key'
  }
}

@alias_escapes = {
  e: 'exit',
  h: 'help',
  o: 'once',
  t: 'exit-then'
}

@word_dict = JSON.parse(File.read(dict_path))

def print_help
  lines = '-' * 20

  puts lines
  puts 'Cut Your Word CLI'
  puts lines
  puts 'Usage: '
  puts lines
end

def print_each(arr, delimiter = ', ')
  out_arr = []

  arr.each do |item|
    out_arr << item
    out_arr << delimiter
  end

  out_arr[0..-2].each { |item| print item }
end

def find_word(dict, word)
  count = 1

  dict.find word do |item|
    puts count.to_s + '.'
    count += 1

    print_each item.features
    puts
    print_each item.meaning
    puts
    print_each item.examples
    puts
    puts
  end
end

def eval_word(word)
  puts
  puts word

  puts 'Possible related root words:'

  dict1 = Dictionary.read_from('./dict/dict1.json')
  dict2 = Dictionary.read_from('./dict/dict2.json')

  puts 'Dict 1:'
  find_word dict1, word

  puts 'Dict 2:'
  find_word dict2, word
end

def do_if_escape(input)
  return unless /-.*/.match? input

  is_alias = /-[^-]*/.match? input

  cmd = input.delete '-'
  cmd = @alias_escapes[cmd] if is_alias

  @escapes[cmd]['exec'].call unless cmd == '' # FIXME: Cannot work properly, 2020-9-3
end

def start_loop(loop_mode = true, exit_then = false)
  loop do
    puts 'Enter your words: (use --<cmd> or -<cmd> to escape)'
    input = readline
    do_if_escape input

    words = input.split /[,\s]/
    words.each { |item| eval_word item }

    break unless loop_mode
  end

  return if exit_then

  puts 'Press enter to exit'
  readline
end

start_loop @loop, @exit_immediately
