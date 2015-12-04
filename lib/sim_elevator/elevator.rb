require 'sim_elevator/floor'

module SimElevator
  class Elevator
    attr_reader :floors
    attr_reader :direction

    def initialize(codes = %w{ B G 1 2 3 }, floor = 'G', direction = nil)
      @floors = []
      codes.each { |code| add_floor code }
      @index = index_of floor
      @direction = direction
    end

    def floor
      @floors[@index]
    end

    def get_floor_by_code(code)
      @floors.find { |floor| floor.code == code }
    end

    def add_floor(code)
      raise ArgumentError('Floor with code already exists') if index_of(code)
      @floors << Floor.new(code)
    end

    def add_floor_above(base, code)
      base_index = index_of base
      raise ArgumentError('Floor does not exist') unless base_index
      @floors.insert base_index + 1, Floor.new(code)
    end

    def add_floor_below(base, code)
      base_index = index_of base
      raise ArgumentError('Floor does not exist') unless base_index
      @floors.insert base_index, Floor.new(code)
    end

    def move(code)
      index = index_of code
      raise ArgumentError('Floor does not exist') unless index
      @index = index
    end

    def step!
      set_direction
      reset_button
      change_floor
    end

    def run!
      begin
        step!
      end while @floors.any? { |floor| floor.elevator_called? }
    end

    private

    def index_of(code)
      @floors.index { |floor| floor.code == code }
    end

    def set_direction
      case @direction
      when :up
        if @floors.map.with_index.none? { |floor, index| index > @index && floor.elevator_called? }
          @direction = floor.down_pressed? ? :down : :up
        end
      when :down
        if @floors.map.with_index.none? { |floor, index| index < @index && floor.elevator_called? }
          @direction = floor.up_pressed? ? :up : :down
        end
      else
        # TODO Move towards the closest one
        next_floor = @floors.index { |floor| floor.elevator_called? }
        if next_floor
          @direction = next_floor < @index ? :down : :up
        else
          @direction = nil
        end
      end
    end

    def reset_button
      case direction
      when :up
        floor.reset_up!
      when :down
        floor.reset_down!
      end
    end

    def change_floor
      case direction
      when :up
        @index += 1
        @index = @floors.length - 1 if @index >= @floors.length
      when :down
        @index -= 1
        @index = 0 if @index < 0
      end
    end
  end
end
