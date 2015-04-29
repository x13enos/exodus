class User
  include Mongoid::Document
  include Mongoid::Ids

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
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

  field :name, :type => String

  token :token, :length => 6

  has_and_belongs_to_many :friends, class_name: 'User'

  def add_friend(user_id)
    user = User.find_by_token(user_id)
    if self.id != user_id && !self.friends.include?(user)
      self.friends << user
    end
  end

  def remove_friend(user_id)
    user = User.find_by_token(user_id)
    self.friends.delete(user)
  end

end
