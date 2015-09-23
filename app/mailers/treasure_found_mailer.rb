class TreasureFoundMailer < ActionMailer::Base
  def treasure_found(email)
    @number_of_treasure_hunted = Position.treasure_hunted.count
    mail from: 'info@treasurehunt.com', to: email, subject: 'Treasure Found'
  end
end
