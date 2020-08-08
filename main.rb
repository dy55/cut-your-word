# frozen_string_literal: true

require 'json'

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

def has_root?(root, word)

end

def eval_word(word)
  puts
  puts word

  printf "Evaluating...\r"
  @word_dict.each { |key, val| puts "#{key}\n#{val}" if has_root? key, word }
end

def do_if_escape(input)
  return unless /-.*/.match input

  is_alias = /-[^-]*/.match input

  cmd = input.delete '-'
  cmd = @alias_escapes[cmd] if is_alias

  @escapes[cmd]['exec'] unless cmd.empty?
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
