class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @own_topics = Topic.where(user_id: current_user.id).reverse_order
    @topic = Topic.new
    @comment = @topic.comments.build
  end

end
