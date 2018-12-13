require 'pp'
require 'singleton'

class Challenge
  attr_accessor :grid, :reads, :num_rows, :num_cols
  DIRECTIONS = {
    up: [-1,0],
    down: [1,0],
    left: [0,-1],
    right: [0,1]
  }.freeze
  TRUE_CHAR = '1'.freeze

  def initialize(grid)
    @grid = grid.freeze
    @num_rows = grid.length
    @num_cols = grid.first.length
    @reads = {}
  end

  def blob_bounds
    start_row, start_col = find_blob_start()
    check_surrounding(start_row, start_col)
    blob_coords = reads.select{|k, v| v == Challenge::TRUE_CHAR}.keys
    {
      top: blob_coords.map(&:first).min,
      bottom: blob_coords.map(&:first).max,
      left: blob_coords.map(&:last).min,
      right: blob_coords.map(&:last).max
    }
  end

  def total_reads
    reads.count
  end

  private

  def find_blob_start
    num_rows.times do |row|
      num_cols.times do |col|
        if read_cell(row, col) == TRUE_CHAR
          return [row, col]
        end
      end
    end
  end

  def check_surrounding(row, col)
    DIRECTIONS.values.each do |(v_row, v_col)|
      new_row = row + v_row
      new_col = col + v_col
      next unless in_bounds(new_row, new_col)
      next unless read_cell(new_row, new_col) == TRUE_CHAR

      check_surrounding(new_row, new_col)
    end
  end

  def read_cell(row,col)
    return false if reads.include?([row,col])

    value = grid[row][col]
    reads[[row,col]] = value
    return value
  end

  def in_bounds(row, col)
    row.between?(0, num_rows) && col.between?(0, num_cols)
  end

end