class MessagesController < ApplicationController
  def index
    @messages = Message.includes(chat: [:sender, :receiver]).all
  end

  def show
    @message = Message.includes(chat: [:sender, :receiver]).find(params[:id])
  end
end