require 'test_helper'

class FloorTest < Minitest::Test
  def setup
    @floor = SimElevator::Floor.new
  end

  def test_that_its_code_is_empty_by_default
    assert_equal '', @floor.code
  end

  def test_that_it_can_be_initilaized_with_a_code
    @floor = SimElevator::Floor.new 'B'

    assert_equal 'B', @floor.code
  end

  def test_that_its_code_can_be_changed
    @floor.code = 'G'

    assert_equal 'G', @floor.code
  end

  def test_that_up_button_is_not_pressed_by_default
    assert_equal false, @floor.up_pressed?
  end

  def test_that_down_button_is_not_pressed_by_default
    assert_equal false, @floor.down_pressed?
  end

  def test_that_up_button_can_be_pressed
    @floor.press_up!

    assert_equal true, @floor.up_pressed?
  end

  def test_that_down_button_can_be_pressed
    @floor.press_down!

    assert_equal true, @floor.down_pressed?
  end

  def test_that_up_button_can_be_reset
    @floor.press_up!
    @floor.reset_up!

    assert_equal false, @floor.up_pressed?
  end

  def test_that_down_button_can_be_reset
    @floor.press_down!
    @floor.reset_down!

    assert_equal false, @floor.down_pressed?
  end

  def test_that_elevator_is_not_called_by_default
    assert_equal false, @floor.elevator_called?
  end

  def test_that_elevator_is_called_if_up_button_is_pressed
    @floor.press_up!

    assert_equal true, @floor.elevator_called?
  end

  def test_that_elevator_is_called_if_down_button_is_pressed
    @floor.press_down!

    assert_equal true, @floor.elevator_called?
  end
end
