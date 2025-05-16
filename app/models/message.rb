class Message < ApplicationRecord
    belongs_to :chat
    belongs_to :user

  validates :body, 
    presence: { message: "Message cannot be empty" }
    
  validates :chat_id, :user_id, 
    presence: { message: "Message must be part of a chat and have a sender"  }
end
