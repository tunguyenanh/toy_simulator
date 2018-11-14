#file: app/simulater.rb
load 'enums/toy_enums.rb'
class Simulator

  attr_accessor :position_x, :position_y, :current_rotation
  def initialize(position_x = 0, position_y = 0, current_rotation = 'NORTH')
    @position_x = Integer(position_x)
    @position_y = Integer(position_y)
    @failed = 0
    @current_rotation = current_rotation
  end

  def left
    @current_rotation = left_directions.fetch(@current_rotation)
  end

  def right
    @current_rotation = right_directions.fetch(@current_rotation)
  end
  #
  def left_directions
    {
        "NORTH" => ToyEnums::WEST,
        "WEST" => ToyEnums::SOUTH,
        "SOUTH" => ToyEnums::EAST,
        "EAST" => ToyEnums::NORTH
    }
  end
  #
  def right_directions
    {
        "NORTH" => ToyEnums::EAST,
        "EAST" => ToyEnums::SOUTH,
        "SOUTH" => ToyEnums::WEST,
        "WEST" => ToyEnums::NORTH
    }
  end
  def report
    return [@position_x, @position_y, @current_rotation]
  end

  def move
    case @current_rotation
    when ToyEnums::NORTH
      @position_y +=1
    when ToyEnums::SOUTH
      @position_y -=1
    when ToyEnums::EAST
      @position_x +=1
    when ToyEnums::WEST
      @position_x -=1
    else
      "You gave me #{x} -- I have no idea what to do with that."
    end
  end

  def validate(data)

  end

  def load_data(file_name)

  end


end