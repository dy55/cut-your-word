# frozen_string_literal: true

# Word part class
#
# @author dy55
class WordPart
  attr_reader :features, :meaning, :examples, :source

  # Initializer
  #
  # @param features [Array<String>] Word part contents
  # @param meaning [String] Meaning of this word part
  # @param examples [String] Example words
  # @param source [String] Word part source
  def initialize(features, meaning, examples = NIL, source = NIL)
    @features = features
    @meaning = meaning
    @examples = examples
    @source = source
  end

  # Whether input word contains this word part
  #
  # @param word [String | Word] Input word
  # @return [Boolean] Is this is a part of input word
  def part_of?(word)
    @features.each { |item| return true if word.include? item }
    false
  end
end
