class Exodus::Callbacks::MoveGem
  attr_accessor :broadcast_data, :second_player_token
  def initialize(gems_index, delete_data, token)
    @broadcast_data = { :gems_index => gems_index, :result => delete_data  }
    @second_player_token = token
  end

  def perform
    change_broadcast_data_if_user_lose
    broadcast_data_to_second_player
  end

  private

  def change_broadcast_data_if_user_lose
    if broadcast_data[:result][:status] == 'end'
      broadcast_data[:result][:sub_status] = 'lose'
    end
  end

  def broadcast_data_to_second_player
    Exodus::BroadcastDataToUser.new({
      :channel => "/#{second_player_token}/game/move_two_gems",
      :data => broadcast_data
    }).perform
  end
end
