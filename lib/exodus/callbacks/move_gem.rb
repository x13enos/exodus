class Exodus::Callbacks::MoveGem
  attr_accessor :broadcast_data, :second_player_token
  def initialize(gems_index, delete_data, token)
    @broadcast_data = { :gems_index => gems_index, :result => delete_data  }
    @second_player_token = token
  end

  def perform
    broadcast_data_to_second_player
  end

  private

  def broadcast_data_to_second_player
    Exodus::BroadcastDataToUser.new({
      :channel => "/#{second_player_token}/game/move_two_gems",
      :data => broadcast_data
    }).perform
  end
end
