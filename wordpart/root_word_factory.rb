require_relative 'root_word'
require_relative 'prefix'
require_relative 'suffix'

##
# Root word factory
class RootWordFactory

  ##
  # Get root word
  def get_root(features, meanings, examples)
    return Prefix.new features, meanings, examples if /^[^-]+-$/.match? features[0]

    return Suffix.new features, meanings, examples if /^-[^-]+$/.match? features[0]

    RootWord.new features, meanings, examples
  end
end