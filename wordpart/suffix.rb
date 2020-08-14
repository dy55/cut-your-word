# frozen_string_literal: true

# Suffix class
class Suffix < Affix
  @pattern = /^-?[^-]+$/

  def initialize(features, meaning, examples = nil, source = nil)
    super
  end

  def affix_of?(word, offset = 0)
    @features.each do |item|
      return true if /.+#{item}$/.match? word[offset..-1]
    end
    false
  end
end
