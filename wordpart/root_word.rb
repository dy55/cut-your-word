# frozen_string_literal: true

# Root word class
#
# @author dy55
class RootWord
  attr_reader :features, :meaning, :examples, :source

  # Initializer
  #
  # @param features [Array<String>] Word part contents
  # @param meaning [Array<String>] Meaning of this word part
  # @param examples [Array<String>] Example words
  # @param source [String] Word part source
  def initialize(features, meaning, examples = nil, source = nil)
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
