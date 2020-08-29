# frozen_string_literal: true

require 'json'

# Root word dictionary
class Dictionary
  attr_accessor :dict

  ##
  # Instantiate a new Dictionary object with a dict structure
  #
  # @param dict_struct [Array] dict struct
  def initialize(dict_struct)
    self.dict = dict_struct
  end

  ##
  # Read from file
  #
  # @param path [String] Path of dictionary file
  # @return [Dictionary] New instance
  def self.read_from(path)
    Dictionary.new JSON.parse path
  end

  ##
  # Find parts from input word
  #
  # @param input_word [String | Word] Input word
  # @return [Array] Found word parts
  def find(input_word)
    # TODO: 2020-8-29
  end
end