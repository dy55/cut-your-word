# frozen_string_literal: true

require 'csv'
require 'json'
require 'pathname'

puts 'Enter path of the CSV file:'
csv_path = readline

csv_path_instance = Pathname.new csv_path
destination = Pathname.new './dict/dict.json'

puts "Entered path: #{csv_path_instance}"
printf 'Processing... '
# Process start

def load_dict(path)
  CSV.foreach(path.to_s.strip) do |row|
    row[0].split(', ').each do |root|
      yield Hash[root, row[1]]
    end
  end
end

@result = {}

load_dict(csv_path_instance) do |item|
  item.each { |key, value| @result[key] = value unless @result.key?(key) }
end

File.open(destination, 'w+') do |file|
  file.write(JSON.pretty_generate(@result))
end

# Process complete
puts 'done'
puts "Target file saved as #{destination}"
puts 'Done'
