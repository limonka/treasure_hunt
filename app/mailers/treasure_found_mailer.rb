class TreasureFoundMailer < ActionMailer::Base
  def treasure_found(user)
    @number_of_treasure_hunted = User.treasure_hunted.count
    mail from: 'info@treasure_hunt.com', to: user.email, subject: 'Treasure Found'
  end
end
