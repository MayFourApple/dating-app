class ConversationsController < ApplicationController
  def index
    @conversations = Conversation.where(user_1_id: current_user.id).or(Conversation.where(user_2_id: current_user.id))
  end

  def new
    @conversation = Conversation.create(user_1_id: current_user.id, user_2_id: params[:recipient_id])
    
    redirect_to conversation_path(@conversation)
  end

  def show
    @conversations = Conversation.where(user_1_id: current_user.id).or(Conversation.where(user_2_id: current_user.id))
    @conversation = Conversation.find(params[:id])
    @message = Message.new
  end
end
