module Codebreaker
  class Game
    HINTS_COUNT = 2
    DEF_MAX_SCORE = 500

    attr_reader :round_number

    def initialize
      @secret_code = ""
      @round_number = 0
      @hints_used = 0
    end
 
    def start
      4.times {
      	@secret_code += (Random.rand(6) + 1).to_s
      } if @secret_code.empty?
      @round_number += 1
    end

    def check (gues)
      raise ArgumentError, 'argument length must be equal 4' unless gues.to_s.length == 4
      raise ArgumentError, 'argument must contain only numbers from 1 to 6' unless gues.to_s[/[1-6]{4}/] == gues.to_s
      
      pluses = minuses = '' 
      sc_array = @secret_code.split('')
      gues_array = gues.to_s.split('')

      gues_array.each_with_index do |val, index|
        if (val == sc_array[index]) 
          sc_array[index] = '0'
          gues_array[index] = '+'
          pluses += '+'
        end
      end

      gues_array.each_with_index do |val, index|
        if (sc_array.include?(val))
          sc_array[sc_array.find_index(val)] = '-'
          minuses += '-'
        end
      end

      result = pluses + minuses
    end

    def hint
      raise 'Called hint to many times' unless @hints_used < HINTS_COUNT
      @hints_used += 1     
      @secret_code[Random.rand(4)]
    end

    def score
      DEF_MAX_SCORE - @hints_used*50 - @round_number*10
    end

    def save

    end

    def getScoreBoard

    end

  end
end