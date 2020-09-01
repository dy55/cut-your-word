##
# Parser for dict 2
class Dict2Parser < GenericParser
  private

  def split_features(input)
    split_arr = input.split %r{/}

    base_word = split_arr.delete_at 0
    word_arr = [base_word]

    split_arr.each do |item|
      word_arr.append base_word + item
    end

    word_arr
  end

  protected

  def column_map
    {
      features: 0,
      meaning: 1,
      examples: 3
    }
  end

  def process_map
    {
      features: method(:split_features),
      meaning: ->(input) { return input.split /,\s?/ },
      examples: ->(input) { return input.split /;\s?/ }
    }
  end

end
