# frozen_string_literal: true

require 'csv'

# Merge two rows
#
# @param row1 [Array<String>]
# @param row2 [Array<String>]
# @return [Array<String>]
def merge(row1, row2)
  if row1.length < row2.length
    source_arr = row1
    new_row = row2.dup
  else
    source_arr = row2
    new_row = row1.dup
  end

  source_arr.each_index do |index|
    new_row[index] += source_arr[index] unless source_arr[index].nil?
  end

  new_row
end

path = './raw/dict-raw2.csv'

rows = CSV.read path

new_table = []

print 'Start concatenating...'

replaced_hash = {
  "Latin, Greek": /(LatinGreek|GreekLatin)/,
  "Latin?, Greek?": /(Latin\??Greek|Greek\??Latin)\?/
}

rows.each do |row|
  if row[0].nil? || row[1].nil? || row[3].nil?
    new_table[-1] = merge new_table[-1], row

    replaced_hash.each do |key, value|
      if value.match? new_table[-1][2]
        new_table[-1][2] = key
        break
      end
    end
  else
    new_table.append row
  end
end

CSV.open(path, 'w') do |csv|
  new_table.each { |row| csv << row }
end

puts ' done'
