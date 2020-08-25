# frozen_string_literal: true

##
# Generic Parser
class GenericParser
  include DictParse

  column_map = {
    features: 0,
    meaning: 1,
    examples: 2
  }

  ##
  # Split root word
  # Override this method to change the split mechanism
  #
  # @param root_words [String] Root word
  # @return [Array<String>] Split root words
  def split(root_words)
    root_words.split /,\s?/
  end

  ##
  # Parse CSV raw dict to JSON (Abstract)
  #
  # @param csv_string [String] CSV String
  # @return [String] JSON String
  def parse_string(csv_string)
    # TODO
  end

  ##
  # Read CSV from file and parse it into JSON
  #
  # @param csv_file_path [String] CSV file path
  #
  # @return [String] JSON String
  def parse_file(csv_file_path)
    parse_string File.read csv_file_path
  end

  ##
  # Read CSV and parse/save it into JSON
  #
  # @param source_file_path [String] Source file path
  # @param target_file_path [String] Target file path
  def parse_into(source_file_path, target_file_path)
    File.open target_file_path, 'w' do |file|
      file.write parse_file source_file_path
    end
  end
end
