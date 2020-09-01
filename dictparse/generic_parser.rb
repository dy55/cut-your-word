# frozen_string_literal: true

require 'json'
require 'csv'

##
# Generic Parser
class GenericParser

  protected

  ##
  # Get column map
  # Override this method to change the column map
  #
  # @return [Hash] Column map
  def column_map
    {
      features: 0,
      meaning: 1,
      examples: 2
    }
  end

  ##
  # Get process map
  # Override this method to change the process map
  #
  # @return [Hash] Process map
  def process_map
    {
      features: ->(input) { return input.split /,\s?/ },
      meaning: ->(input) { return input.split /,\s?/ },
      examples: ->(input) { return input.split /,\s?/ }
    }
  end

  public

  ##
  # Parse CSV raw dict to JSON
  #
  # @param csv_string [String] CSV String
  # @param prettify [Boolean] Whether prettify JSON string
  # @return [String] JSON String
  def parse_string(csv_string, prettify = true)
    obj_arr = []

    CSV.parse csv_string do |row|
      obj = {}
      column_map.each do |key, value|
        obj[key] = process_map[key].call row[value]
      end

      obj_arr.append obj
    end

    return JSON.pretty_generate obj_arr if prettify

    JSON.generate obj_arr
  end

  ##
  # Read CSV from file and parse it into JSON
  #
  # @param csv_file_path [String] CSV file path
  # @param prettify [Boolean] Whether prettify JSON string
  #
  # @return [String] JSON String
  def parse_file(csv_file_path, prettify = true)
    parse_string (File.read csv_file_path), prettify
  end

  ##
  # Read CSV and parse/save it into JSON
  #
  # @param source_file_path [String] Source file path
  # @param target_file_path [String] Target file path
  # @param prettify [Boolean] Whether prettify JSON string
  def parse_into(source_file_path, target_file_path, prettify = true)
    File.open target_file_path, 'w' do |file|
      file.write parse_file source_file_path, prettify
    end
  end
end
