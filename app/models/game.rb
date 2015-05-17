class Game
  include Mongoid::Document
  include Mongoid::Timestamps

  GEMS_NUMBER = (0..6).to_a
  ACTIVE_STATUS = 1
  CLOSE_STATUS = 2

  field :status, :type => Integer
  field :active_player_token, :type => String
  field :inactive_player_token, :type => String
  field :players_data, :type => Hash

  scope :active, -> { where(:status => ACTIVE_STATUS) }

  has_one :board
  has_and_belongs_to_many :players, :class_name => 'User'

  def change_active_player
    update({ :active_player_token => inactive_player_token, :inactive_player_token => active_player_token })
  end

  def opponent(user)
    (players - [user]).first
  end

  def close
    update(:status => CLOSE_STATUS)
  end
end
