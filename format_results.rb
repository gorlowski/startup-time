#!/usr/bin/ruby

require 'bigdecimal'

# We want to generate a markdown table like this:
#
#| Language          | version               | Intel Core i7-5600U |
#| ------------------|---------------------- | ------------------: |
#| Pascal (fpc)      | 3.0.2 / 3.0.4         |             0.08 ms |
#| C (gcc)           | 7.2.0                 |             0.26 ms |
#| Shell (dash)      | 0.5.8                 |             0.33 ms |
#| Go (go)           | 1.8.3 / 1.9.3         |             0.41 ms |

# From Makefile output like this:
#
#Run on: Intel(R) Core(TM) i7-5600U CPU @ 2.60GHz | Debian GNU/Linux 10 (buster) | 2020-11-27
#C (gcc 8.3.0):                                          0.25 ms
#C_MUSL (musl-gcc 8.3.0 / musl 1.1.21):                  0.05 ms
#C++ (g++ 8.3.0):                                        0.73 ms

input_file = ARGV[0]

if !File.exists?(input_file)
  script_name = File.basename($0)
  puts "Usage #{script_name} MAKEFILE_OUTPUT"
  exit 0
end

class Result
  attr_reader :lang_impl, :version, :time_ms
  def initialize(line)
    parts = line.split(/\s+/)
    @lang_impl = parts.shift
    parts.pop
    @time_ms = BigDecimal.new(parts.pop)
    if parts.first.start_with?(/\([a-zA-Z]+/)
      sub_impl = parts.first + ')'
      @lang_impl += ' ' + sub_impl
    end
    @lang_impl = @lang_impl.tr('_','-')
    m = parts.join(' ').scan(/[-.0-9p]+/)
    @version = '' if m.nil?

    ver = m.select {|s| s.size > 2}.last
    @version = ver
  end

  def <=>(other)
    self.time_ms <=> other.time_ms
  end

  def time_str
    sprintf('%.2f ms', time_ms)
  end

  def to_s
    "#{lang_impl} #{version} #{time_str}"
  end
end

lines = File.readlines(input_file).select {|l| l =~ /[0-9]\s+ms$/}

results = lines.map {|l| Result.new(l)}.sort

longest_lang = results.map {|r| r.lang_impl.size}.sort.last
longest_ver = results.map {|r| r.version.size}.sort.last + 4

fmt = "| %-#{longest_lang}s | %-#{longest_ver}s | %20s |\n"

printf(fmt, "Language", "Version", "Intel Core i7-5600U")

printf("|%s|%s|%s|\n", 
  ':' + ('-' * (longest_lang+1)),
  ':' + ('-' * (longest_ver+1)),
  ('-' * 21) + ':')

results.each do |r|
  printf(fmt, r.lang_impl, r.version, r.time_str)
end
