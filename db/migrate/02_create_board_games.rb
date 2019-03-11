class CreateBoardGames < ActiveRecord::Migration[5.0]
  def change
    create_table :board_games do |t|
      t.string :name
      t.string :type
      t.string :playtime
      t.string :playercount
    end
  end
end
