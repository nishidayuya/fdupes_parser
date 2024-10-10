module FdupesParser
  class << self
    def each_entry(input)
      return to_enum(__method__, input) if !block_given?

      input.each_line("", chomp: true).lazy.each do |s_entry|
        yield(FdupesParser::Entry.parse(s_entry))
      end
    end
  end
end

require "fdupes_parser/entry"
require "fdupes_parser/error"
require "fdupes_parser/version"
