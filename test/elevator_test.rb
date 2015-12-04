require 'test_helper'

class ElevatorTest < Minitest::Test
  def setup
    @elevator = SimElevator::Elevator.new
  end

  def test_that_it_has_five_associated_floor_by_default
    assert_equal 5, @elevator.floors.length
  end

  def test_the_default_floor_codes
    assert_equal %w{ B G 1 2 3 }, @elevator.floors.map(&:code)
  end

  def test_that_it_can_be_initialized_with_a_set_of_floors
    @elevator = SimElevator::Elevator.new %w{ 0 1 2 }

    assert_equal %w{ 0 1 2 }, @elevator.floors.map(&:code)
  end

  def test_that_it_starts_on_the_ground_floor_by_default
    assert_equal 'G', @elevator.floor.code
  end

  def test_that_it_can_be_initialized_with_a_starting_floor
    @elevator = SimElevator::Elevator.new %w{ 0 1 2 }, '2'

    assert_equal '2', @elevator.floor.code
  end

  def test_that_it_doesnt_move_by_default
    assert_nil @elevator.direction
  end

  def test_that_it_can_be_initialized_with_a_direction
    @elevator = SimElevator::Elevator.new %w{ 0 1 2 }, '2', :down

    assert_equal :down, @elevator.direction
  end

  def test_that_it_can_return_a_floor_by_its_code
    floor = @elevator.get_floor_by_code '1'

    assert_equal '1', floor.code
  end

  def test_that_it_can_accept_a_new_floor
    @elevator.add_floor '4'

    assert_equal %w{ B G 1 2 3 4 }, @elevator.floors.map(&:code)
  end

  def test_that_it_doesnt_accept_a_floor_with_a_code_already_in_use
    assert_raises { @elevator.add_floor '1' }
  end

  def test_that_it_can_add_a_floor_above_another_one
    @elevator.add_floor_above '1', '1.5'

    assert_equal %w{ B G 1 1.5 2 3 }, @elevator.floors.map(&:code)
  end

  def test_that_it_cannot_add_a_floor_above_another_with_a_code_already_in_use
    assert_raises { @elevator.add_floor_above '1' }
  end

  def test_that_it_can_add_a_floor_below_another_one
    @elevator.add_floor_below 'B', 'B2'

    assert_equal %w{ B2 B G 1 2 3 }, @elevator.floors.map(&:code)
  end

  def test_that_it_cannot_add_a_floor_below_another_with_a_code_already_in_use
    assert_raises { @elevator.add_floor_below '1' }
  end

  def test_that_it_can_move_to_a_floor_instantly
    @elevator.move '2'

    assert_equal '2', @elevator.floor.code
  end

  def test_that_it_raises_if_destination_floor_does_not_exist
    assert_raises { @elevator.move '100' }
  end

  def test_that_it_starts_to_move_up_if_called_from_a_floor_above_the_current
    @elevator.get_floor_by_code('2').press_down!
    @elevator.step!

    assert_equal :up, @elevator.direction
  end

  def test_that_it_will_move_down_if_called_down_from_a_floor_above_the_current
    @elevator.get_floor_by_code('3').press_down!
    @elevator.run!

    assert_equal :down, @elevator.direction
  end

  def test_that_it_will_reset_buttons_while_moving_up
    @elevator.get_floor_by_code('G').press_up!
    @elevator.get_floor_by_code('1').press_up!
    @elevator.get_floor_by_code('2').press_up!

    @elevator.step!
    @elevator.step!
    @elevator.step!

    assert_empty @elevator.floors.select(&:elevator_called?)
  end
end
