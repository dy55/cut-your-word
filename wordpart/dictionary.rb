# frozen_string_literal: true

require 'json'
require 'root_word'
require 'root_word_factory'

# Root word dictionary
class Dictionary
  attr_accessor :dict

  ##
  # Instantiate a new Dictionary object with a dict structure
  #
  # @param dict_struct [Array<RootWord>] dict struct
  def initialize(dict_struct)
    self.dict = dict_struct
  end

  ##
  # Read from file
  #
  # @param path [String] Path of dictionary file
  # @return [Dictionary] New instance
  def self.read_from(path)
    dict_obj =  JSON.parse path
    obj_arr = []

    root_factory = RootWordFactory.new

    dict_obj.each do |item|
      obj_arr.append root_factory.get_root item[:features], item[:meaning], item[:examples]
    end

    Dictionary.new obj_arr
  end

  ##
  # Find parts from input word
  #
  # @param input_word [String | Word] Input word
  # @return Found word parts
  def find(input_word)
    word_part = input_word.to_s

    loop do
      break_halfway = false

      @dict.each do |item|
        if item.part_of? word_part
          yield item

          if item.is_a? Prefix
            word_part = word_part[item.content.length..-1]
          elsif item.is_a? Suffix
            word_part = word_part[(0 until -item.content.length)]
          else
            next
          end

          break_halfway = true
          break
        end
      end

      break unless break_halfway
    end
  end
end
