class ChatsController < ApplicationController
  def index
    @chats = Chat.includes(:sender, :receiver).all
  end

  def show
    @chat = Chat.includes(:sender, :receiver).find(params[:id])
  end
end
