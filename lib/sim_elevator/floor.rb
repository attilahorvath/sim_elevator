module SimElevator
  class Floor
    attr_accessor :code

    def initialize(code = '')
      @code = code

      @up_pressed = false
      @down_pressed = false
    end

    def up_pressed?
      @up_pressed
    end

    def down_pressed?
      @down_pressed
    end

    def elevator_called?
      @up_pressed || @down_pressed
    end

    def press_up!
      @up_pressed = true
    end

    def press_down!
      @down_pressed = true
    end

    def reset_up!
      @up_pressed = false
    end

    def reset_down!
      @down_pressed = false
    end
  end
end
