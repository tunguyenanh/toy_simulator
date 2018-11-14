#file: app/simulator.rb
load 'enums/toy_enums.rb'
class Simulator
  def initialize()
    @position_x = nil
    @position_y = nil
    @failed = 0
    @current_rotation = nil
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
        ToyEnums::NORTH => ToyEnums::WEST,
        ToyEnums::WEST => ToyEnums::SOUTH,
        ToyEnums::SOUTH => ToyEnums::EAST,
        ToyEnums::EAST => ToyEnums::NORTH
    }
  end
  #
  def right_directions
    {
        ToyEnums::NORTH => ToyEnums::EAST,
        ToyEnums::EAST => ToyEnums::SOUTH,
        ToyEnums::SOUTH => ToyEnums::WEST,
        ToyEnums::WEST => ToyEnums::NORTH
    }
  end
  def report
    puts [@position_x, @position_y, @current_rotation].join(',')


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

    end
  end
=begin
Validate place is format PLACE x,x,WEST|SOUTH|EAST|NORTH
=end
  def validate_place place
    result = false
    if place.is_a? String
      direction = [ToyEnums::NORTH,ToyEnums::EAST,ToyEnums::WEST,ToyEnums::SOUTH].join('|')
      pattern = "^"+ToyEnums::PLACE+" ["+ToyEnums::MIN_X.to_s+"-"+ToyEnums::MAX_X.to_s+"]{1},["+ToyEnums::MIN_Y.to_s+"-"+ToyEnums::MAX_Y.to_s+"]{1},("+direction+")"
      result =  place.scan(/#{pattern}/) ? true : false
    end
    return result
  end
  def load_current_location(position_x,position_y,current_rotation)
    @position_x = Integer(position_x)
    @position_y = Integer(position_y)
    @current_rotation = current_rotation
  end
  def run data
    if data.is_a? Array
      data.each_with_index do |cmd, index|
        if index == 0
          check_first = validate_place cmd
          if !check_first
            raise "INVALID DATA INPUT"
          end
        end
        if cmd[ToyEnums::PLACE]
          result = validate_place cmd
          if result
            parsing_place cmd
          end
        end
        if cmd == ToyEnums::MOVE
          move
        end
        if cmd == ToyEnums::LEFT
          left
        end
        if cmd == ToyEnums::RIGHT
          right
        end
        if cmd == ToyEnums::REPORT
          report
        end
      end
    else
      raise "INVALID DATA INPUT"
    end

  end

  def parsing_place place
    place_cmd = place.split(' ')
    params = place_cmd[1].split(',')
    @position_x =  params[0].to_i
    @position_y =  params[1].to_i
    @current_rotation = params[2]
  end
end

