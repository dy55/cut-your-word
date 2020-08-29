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

  def to_s
    content
  end
end
