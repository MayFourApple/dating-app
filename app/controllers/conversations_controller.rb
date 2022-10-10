class ConversationsController < ApplicationController
  def index
    @conversations = Conversation.where(user_1: current_user).or(user_2: current_user)
  end

  def new
    @conversation = Conversation.create(user_1: current_user, user_2_id: params[:recipient_id])
    
    redirect_to conversation_path(@conversation)
  end

  def show
    @conversations = Conversation.where(user_1: current_user).or(Conversation.where(user_2: current_user))
    @conversation = Conversation.find(params[:id])
    @message = Message.new
  end
end
