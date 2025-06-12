class Chat < ApplicationRecord
    has_many :messages, dependent: :destroy
    belongs_to :sender, class_name: 'User'
    belongs_to :receiver, class_name: 'User'
    
    validates :sender_id, :receiver_id, 
      presence: { message: "You must have a sender and a receiver" }
    validate :cannot_chat_with_self

    scope :participating, ->(user) {
      where("sender_id = ? OR receiver_id = ?", user.id, user.id)
    }
    def other_participant(current_user)
      current_user == sender ? receiver : sender
    end

    private
    
    def cannot_chat_with_self
      errors.add(:receiver_id, "can't be the same as sender") if sender_id == receiver_id
    end
end    