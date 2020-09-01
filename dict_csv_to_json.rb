require_relative './dictparse/generic_parser'
require_relative './dictparse/dict1_parser'
require_relative './dictparse/dict2_parser'

parser_arr = [
  Dict1Parser.new,
  Dict2Parser.new
]

source_arr = %w[./raw/dict-raw1.csv ./raw/dict-raw2.csv]

target_arr = %w[./dict/dict1.json ./dict/dict2.json]

parser_arr.each_index do |index|
  parser_arr[index].parse_into source_arr[index], target_arr[index]
end