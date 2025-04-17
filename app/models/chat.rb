class Chat < ApplicationRecord
    has_many :messages, dependent: :destroy
    belongs_to :sender, class_name: 'User'
    belongs_to :receiver, class_name: 'User'
    
    validates :sender_id, :receiver_id, presence: true
    validate :cannot_chat_with_self

    private
    
    def cannot_chat_with_self
      errors.add(:receiver_id, "can't be the same as sender") if sender_id == receiver_id
    end
end    