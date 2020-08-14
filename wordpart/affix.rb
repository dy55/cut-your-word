# frozen_string_literal: true

# Affix class
class Affix < WordPart
  @pattern = /.+/

  def initialize(features, meaning, examples = nil, source = nil)
    super

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
end