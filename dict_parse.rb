# frozen_string_literal: true

require 'csv'
require 'json'
require 'pathname'

# Dict Parse Module
module DictParse
  # CSV dict file to hash
  def to_hash(source)
    result = {}
    load_dict(source).each { |key, value| append result, key, value }
    result
  end

  # Parse CSV dict file to JSON
  def parse(source, destination)
    write_dict destination, to_hash(source)
  end

  # Parse CSV dict with roots and affix to JSON
  #
  # @param source [String] Source
  # @param destinations [Array<String>] Destinations
  def parse_combined_dict(source, destinations)
    # roots, prefix, suffix
    dict_array = [{}, {}, {}]
    patterns = [/[^-]+/, /[^-]+-$/, /^-[^-]/]

    load_dict(source).each do |key, value|
      patterns.each_index do |index|
        if patterns[index].match? key
          append dict_array[index], key, value
          break
        end
      end
    end

    destinations.each_index do |index|
      write_dict destinations[index], dict_array[index]
    end
  end

  # Load dict file
  def load_dict(path)
    CSV.foreach(path.to_s.strip) do |row|
      row[0].split(', ').each do |root|
        yield Hash[root, row[1]]
      end
    end
  end

  # Write dict file
  def write_dict(destination, hash_content)
    File.open(destination, 'w+') do |file|
      file.write(JSON.pretty_generate(hash_content))
    end
  end

  def append(hash_dict, key, value)
    if hash_dict.key?(key)
      hash_dict[key] += "; #{value}"
    else
      hash_dict[key] = value
    end
  end
end
