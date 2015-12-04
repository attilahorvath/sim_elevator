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

    def add_floor(code)
      raise ArgumentError.new('Floor with code already exists') if index_of(code)
      @floors << Floor.new(code)
    end

    def add_floor_above(base, code)
      base_index = index_of base
      raise ArgumentError.new('Floor does not exist') unless base_index
      @floors.insert base_index + 1, Floor.new(code)
    end

    def add_floor_below(base, code)
      base_index = index_of base
      raise ArgumentError.new('Floor does not exist') unless base_index
      @floors.insert base_index, Floor.new(code)
    end

    def get_floor_by_code(code)
      @floors.find { |floor| floor.code == code }
    end

    def press_up_on(code)
      floor = @floors.find { |floor| floor.code == code }
      raise ArgumentError.new('Floor does not exist') unless floor
      floor.press_up!
    end

    def press_down_on(code)
      floor = @floors.find { |floor| floor.code == code }
      raise ArgumentError.new('Floor does not exist') unless floor
      floor.press_down!
    end

    def move(code)
      index = index_of code
      raise ArgumentError.new('Floor does not exist') unless index
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

      floor.code
    end

    private

    def index_of(code)
      @floors.index { |floor| floor.code == code }
    end

    def set_direction
      case @direction
      when :up
        # If there are no floors above the current with queued commands
        # And the up button is not pressed on the current floor
        if @floors.map.with_index
           .none? { |floor, index| index > @index && floor.elevator_called? } &&
           !floor.up_pressed?
          # Then we change direction (if there are requests below) or stay put
          @direction = @floors.any? { |floor| floor.elevator_called? } ? :down : nil
        end
      when :down
        # If there are no floors below the current with queued commands
        # And the down button is not pressed on the current floor
        if @floors.map.with_index
           .none? { |floor, index| index < @index && floor.elevator_called? } &&
           !floor.down_pressed?
          # Then we change direction (if there are requests above) or stay put
          @direction = @floors.any? { |floor| floor.elevator_called? } ? :up : nil
        end
      else
        # Figure out the index of the closest floor with queued commands
        next_floor = @floors.map.with_index
                     .select{ |floor, index| floor.elevator_called? }
                     .min{ |a, b| (a.last - @index).abs <=> (b.last - @index).abs }
                     .last
        if next_floor
          if next_floor == @index
            @direction = floor.up_pressed? ? :up : :down
          else
            @direction = next_floor < @index ? :down : :up
          end
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

      floor.code
    end
  end
end
