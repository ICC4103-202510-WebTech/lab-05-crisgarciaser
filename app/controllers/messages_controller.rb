class MessagesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  def index
    @messages = Message.includes(chat: [:sender, :receiver]).all
  end

  def show
    @message = Message.includes(chat: [:sender, :receiver]).find(params[:id])
  end

  def new
    @message = Message.new
  end
  
  def create
    @message = Message.new(message_params)
    if @message.save
      redirect_to @message, notice: 'Message was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @message = Message.find(params[:id])
  end

  def update
    @message = Message.find(params[:id])
    if @message.update(message_params)
      redirect_to @message
    else
      render :edit, status: :unprocessable_entity
    end
  end 
  
  private
  
  def message_params
    params.require(:message).permit(:chat_id, :user_id, :body)
  end
end