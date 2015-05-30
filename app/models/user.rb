class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Ids

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  field :email,              :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time
  field :remember_created_at, :type => Time
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String
  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  field :nickname, :type => String
  field :hp, :type => Integer, :default => 30
  field :green_mana, :type => Integer, :default => 10
  field :alchemy, :type => Integer, :default => 10
  field :gear, :type => Integer, :default => 10
  field :piston, :type => Integer, :default => 10
  field :blue_mana, :type => Integer, :default => 10

  token :token, :length => 6

  mount_uploader :avatar, ::UserAvatarUploader

  has_and_belongs_to_many :friends, :class_name => 'User'
  has_and_belongs_to_many :games
  has_many :notifications

  validates :nickname, :presence => true
  validates :nickname, :uniqueness => true

  def add_friend(user_id)
    user = User.find_by_token(user_id)
    if self.token != user_id && !self.friends.include?(user)
      self.friends << user
    end
  end

  def remove_friend(user_id)
    user = User.find_by_token(user_id)
    self.friends.delete(user)
  end

  def create_game_invite(sender_id)
    notification = notifications.create({ :subspecies => Notification::INVITE_SUBSPECIES, :sender_id => sender_id })
    notification.broadcast
  end

  def current_active_game
    games.active.last
  end
end
