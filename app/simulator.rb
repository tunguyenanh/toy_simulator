#file: app/simulator.rb
load 'enums/toy_enums.rb'
class Simulator
  def initialize()
    @position_x = nil
    @position_y = nil
    @failed = 0
    @current_rotation = nil
  end
  #rotate for left
  def left
    @current_rotation = left_directions.fetch(@current_rotation)
  end
  #rotate for right
  def right
    @current_rotation = right_directions.fetch(@current_rotation)
  end
  #define rotate for left
  def left_directions
    {
        ToyEnums::NORTH => ToyEnums::WEST,
        ToyEnums::WEST => ToyEnums::SOUTH,
        ToyEnums::SOUTH => ToyEnums::EAST,
        ToyEnums::EAST => ToyEnums::NORTH
    }
  end
  #define rotate for right
  def right_directions
    {
        ToyEnums::NORTH => ToyEnums::EAST,
        ToyEnums::EAST => ToyEnums::SOUTH,
        ToyEnums::SOUTH => ToyEnums::WEST,
        ToyEnums::WEST => ToyEnums::NORTH
    }
  end
  #output data with format x,x(WEST|SOUTH|EAST|NORTH)
  # @return string|raise error message
  def report
    if (@position_x.is_a? Integer) && (@position_x.is_a? Integer) && (ToyEnums::ALL_DIRECTION.include? @current_rotation)
      puts [@position_x, @position_y, @current_rotation].join(',')
    else
      raise ToyEnums::MSG_ERROR
    end
  end
  # call when cmd = MOVE
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
  # Validate place is format PLACE x,x,WEST|SOUTH|EAST|NORTH
  # @return boolean
  def validate_place place
    result = false
    if place.is_a? String
      direction = ToyEnums::ALL_DIRECTION.join('|')
      pattern = "^"+ToyEnums::PLACE+" ["+ToyEnums::MIN_X.to_s+"-"+ToyEnums::MAX_X.to_s+"]{1},["+ToyEnums::MIN_Y.to_s+"-"+ToyEnums::MAX_Y.to_s+"]{1},("+direction+")"
      result =  place.scan(/#{pattern}/) ? true : false
    end
    return result
  end
  #execute data
  def run data
    if data.is_a? Array
      data.each_with_index do |cmd, index|
        cmd = cmd.strip
        if index == 0
          check_first = validate_place cmd
          if !check_first
            raise ToyEnums::MSG_ERROR
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
      raise ToyEnums::MSG_ERROR
    end
  end

  def parsing_place(place, first=false)
    begin
      validate = validate_place place
      if(validate)
        place_cmd = place.split(' ')
        params = place_cmd[1].split(',')
        @position_x =  params[0].to_i
        @position_y =  params[1].to_i
        @current_rotation = params[2]
      elsif !validate && first
        raise ToyEnums::MSG_ERROR
      end
    rescue
      if first
        raise ToyEnums::MSG_ERROR
      end
    end

  end
end

