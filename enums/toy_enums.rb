#file: enums/toy_enums.rb
class ToyEnums
  PLACE = 'PLACE'
  REPORT = 'REPORT'
  LEFT = 'LEFT'
  RIGHT = 'RIGHT'
  MOVE = 'MOVE'

  WEST = 'WEST'
  SOUTH = 'SOUTH'
  EAST = 'EAST'
  NORTH = 'NORTH'
  MAX_X = 4
  MAX_Y = 4

  MIN_X = 0
  MIN_Y = 0
  MSG_ERROR = "INVALID DATA EXAMPLE INPUT"

  ALL_DIRECTION = [
      self::SOUTH,
      self::WEST,
      self::NORTH,
      self::EAST
  ]

end