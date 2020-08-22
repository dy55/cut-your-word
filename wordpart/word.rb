# frozen_string_literal: true

# Word class
class Word
  attr_reader :content

  def initialize(word_string)
    @content = word_string
  end

  # Whether this word includes the input string
  #
  # @param input_string [String] Input string
  #
  # @return [Boolean] If it is included
  def include?(input_string)
    @content.include? input_string
  end

  # Cut the word into parts according to dictionaries
  #
  # @param root_dict [hash<String, String>] Root dictionary
  # @param prefix_dict [hash<String, String>] Prefix dictionary
  # @param suffix_dict [hash<String, String>] Suffix dictionary
  #
  # @return [Array<WordPart>] Word parts
  def cut(root_dict, prefix_dict, suffix_dict)
    # TODO
  end
end
