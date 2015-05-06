class Exodus::Game::CreateForTwoPlayers
  attr_accessor :first_player, :second_player
  def initialize(first_player_token, second_player_token)
    @first_player = User.find_by_token(first_player_token)
    @second_player = User.find_by_token(second_player_token)
  end

  def perform
    game = create_game
    add_players_to_game(game)
    set_starting_game_positions(game)
    send_callback_to_second_user
  end

  private

  def create_game
    ::Game.create({
      :status => ::Game::ACTIVE_STATUS,
      :active_player_token => [first_player.token, second_player.token].sample
    })
  end

  def add_players_to_game(game)
    game.players << [first_player, second_player]
  end

  def set_starting_game_positions(game)
    Exodus::Algorithms::StartingGemsPosition.new(game.id).perform
  end

  def send_callback_to_second_user
    Exodus::BroadcastDataToUser.new({ :channel => "/#{second_player.token}/game/new" }).perform
  end
end
