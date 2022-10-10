class MessagesController < ApplicationController
  def create
    @conversation = Conversation.find(params[:conversation_id])
    @conversation.increment_unread(current_user)
    @message = @conversation.messages.create(message_params)

    redirect_to conversation_path(@conversation)
  end

  private

  def message_params
    {
      author: current_user,
      content: params[:message][:content]
    }
  end
end
