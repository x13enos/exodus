class Game
  include Mongoid::Document
  include Mongoid::Timestamps

  GEMS_NUMBER = (0..6).to_a
  ACTIVE_STATUS = 1
  CLOSE_STATUS = 2

  field :status, :type => Integer
  field :active_player_token, :type => String

  scope :active, -> { where(:status => ACTIVE_STATUS) }

  has_one :board
  has_and_belongs_to_many :players, :class_name => 'User'

  def change_active_player
    second_player_token = (players.map(&:token) - [active_player_token]).first
    update(:active_player_token => second_player_token)
  end

end
