# frozen_string_literal: true

# Root Word class
class RootWord < WordPart
  def initialize(features, meaning, examples = nil, source = nil)
    super
  end

  # Split input word via the root word
  #
  # @param word [String] Input word
  # @return [Array<String>] Split parts
  def split(word)
    return [word.dup] unless part_of? word

    matched = []
    @features.each { |item| matched.append item if word.include? item }
    matched_max = matched.max_by &'length'
    split_arr = word.split /#{matched_max}/

    split_arr.insert 1, matched_max
  end
end
