class Exodus::Game::CreateForTwoPlayers
  attr_accessor :first_player, :second_player, :players
  def initialize(first_player_token, second_player_token)
    @first_player = User.find_by_token(first_player_token)
    @second_player = User.find_by_token(second_player_token)
    @players = [first_player, second_player]
  end

  def perform
    game = create_game
    add_players_to_game(game)
    create_board_with_starting_gems(game)
    send_callback_to_second_user
  end

  private

  def create_game
    ::Game.create(game_options)
  end

  def game_options
    active_player_token = players.map(&:token).sample
    inactive_player_token = (players.map(&:token) - [active_player_token]).first
    {
      :status => ::Game::ACTIVE_STATUS,
      :active_player_token => active_player_token,
      :inactive_player_token => inactive_player_token,
      :players_data => players_data
    }
  end

  def players_data
    players.each_with_object({}) do |player, data_hash|
      data_hash[player.token] = {
        :hp => player.hp,
        :max_blue_mana => player.blue_mana,
        :max_alchemy => player.alchemy,
        :max_gear => player.gear,
        :max_green_mana => player.green_mana,
        :max_piston => player.piston,
        :blue_mana => 0,
        :alchemy => 0,
        :green_mana => 0,
        :piston => 0,
        :gear => 0,
        :expirience => 0
      }
      data_hash[player.token][:hp] = player.hp
    end
  end

  def add_players_to_game(game)
    game.players << players
  end

  def create_board_with_starting_gems(game)
    gems_position = Exodus::Algorithms::StartingGemsPosition.new.perform
    game.create_board(:gems_position => gems_position)
  end

  def send_callback_to_second_user
    Exodus::BroadcastDataToUser.new({ :channel => "/#{second_player.token}/game/new" }).perform
  end
end
