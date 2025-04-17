class Message < ApplicationRecord
    belongs_to :chat
    belongs_to :user

    validates :chat_id, :user_id, :body, presence: true
end
