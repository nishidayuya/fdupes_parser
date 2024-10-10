require "fdupes_parser"

class FdupesParser::Entry < Data.define(:size, :paths)
  class << self
    def parse(s_entry)
      bytes_each_line, *paths = *s_entry.each_line(chomp: true)
      md = /\A(?<size>\d+) bytes each:\z/.match(bytes_each_line)
      if !md
        raise FdupesParser::Error.new("Malformed line is detected: line=#{bytes_each_line.inspect}")
      end

      size = md[:size].to_i
      new(size:, paths:)
    end
  end

  def to_s
    s = +"#{size} bytes each:\n"
    paths.each do |path|
      s << path << "\n"
    end
    s << "\n"
    return s
  end
end
