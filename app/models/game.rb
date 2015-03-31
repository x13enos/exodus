class Game
  include Mongoid::Document
  include Mongoid::Timestamps

  GEMS_NUMBER = (0..6).to_a

  has_one :board

end
