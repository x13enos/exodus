class Notification
  include Mongoid::Document

  INVITE_SUBSPECIES = 1

  field :user_id, :type => :integer
  field :subspecies, :type => :integer
  field :was_read, :type => :boolean, :default => false

  belongs_to :user
  belongs_to :sender, :class_name => 'User', :foreign_key => :sender_id

  def broadcast
    Exodus::BroadcastDataToUser.new({ :method => :post,
                                      :channel => "/#{user.token}/notifications",
                                      :data => { :type => subspecies, :sender => sender.token } }).perform
  end
end
