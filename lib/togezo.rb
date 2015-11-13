require 'pty'
require 'expect'
require 'tempfile'

module Togezo
  GAUSSIAN = 0
  PEARSON = 1

  def self.init(filename, debug=false)
    unless fityk_installed?
      puts "Please install fityk at first. http://fityk.nieto.pl/"
      exit 0
    end
    Togezo.new(filename, debug)
  end

  def self.fityk_installed?
    fityk_ver = `cfityk -V 2>&1`
    if fityk_ver =~ /^fityk/
      return true
    end
    false
  end

  class Togezo
    attr_accessor :debug
    attr_reader :positives, :negatives, :peaks

    def initialize(filename, debug=false)
      @datafile = File.open(filename)
      @constant = nil
      @positives = []
      @negatives = []
      @peaks = []
    end

    def fit(function=GAUSSIAN, times=1)
      if function = GAUSSIAN
        guess = "Gaussian"
      elsif function = @PEARSON
        guess = "Pearson"
      end

      PTY.spawn("cfityk") do |r, w, pid|
        w.puts "@0 < #{@datafile.path};"
        w.puts "guess Constant;"
        w.puts "info peaks;"

        r.sync = true
        r.expect(/\%_1\s+Constant(\sx){4}\s+(\d+(\.\d+)*)\s/, 3) do |line|
          @constant = line[2].to_f
        end

        1.upto(times) do |i|
          w.puts "guess #{guess}"
        end

        w.puts "info peaks"
        2.upto(times+1) do |i|
          r.expect(/\%_#{i}\s+#{guess}(\s+\d+(\.\d+)*)(\s+\d+(\.\d+)*)\s/, 3) do |line|
            x = line[1].to_f
            y = line[3].to_f
            @positives << [x, y]
          end
        end

        w.close
        r.close
      end

      negatives = Tempfile.new("temp")
      @datafile.each_line do |line|
        x, y = line.split(/\s/).map{|m| m.to_f}
        if y < @constant
          new_y = (@constant - y) + @constant
          negatives.puts "#{x} #{new_y}"
        end
      end
      negatives.flush
      negatives.rewind

      PTY.spawn("cfityk") do |r, w, pid|
        w.puts "@0 < #{negatives.path};"
        w.puts "guess Constant(a=#{@constant});"

        1.upto(times) do |i|
          w.puts "guess #{guess}"
        end

        w.puts "info peaks"
        2.upto(times+1) do |i|
          r.expect(/\%_#{i}\s+#{guess}(\s+\d+(\.\d+)*)(\s+\d+(\.\d+)*)\s/, 3) do |line|
            x = line[1].to_f
            y = line[3].to_f
            @negatives << [x, y]
          end
        end

        w.close
        r.close
      end

      @positives.each do |x, y|
        @peaks << [x, (y+@constant).round(5)]
      end

      @negatives.each do |x, y|
        @peaks << [x, (@constant-y).round(5)]
      end

      @peaks.sort!
    end
  end
end
