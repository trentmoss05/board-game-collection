class User < ActiveRecord::Base
  has_many :board_games
  has_secure_password
end
