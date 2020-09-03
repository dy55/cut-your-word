# frozen_string_literal: true

require_relative 'root_word'

# Affix class
class Affix < RootWord

  def initialize(features, meaning, examples = nil, source = nil)
    super

    @pattern = /.+/
    @features.each do |item|
      raise MismatchedAffixException unless @pattern.match? item

      item.sub '-', ''
    end
  end

  # Whether this is affix of the word
  #
  # @param word {String} input word
  # @param offset {Integer} offset
  # @return [Boolean] Is affix of the word
  def affix_of?(word, offset = 0)
    raise NotImplementedError
  end

  def part_of?(word)
    affix_of? word, 0
  end
end
