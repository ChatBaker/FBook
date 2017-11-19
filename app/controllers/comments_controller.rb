class CommentsController < ApplicationController
  # コメントを保存、投稿するためのアクションです。
def create
  # topicをパラメータの値から探し出し,topicに紐づくcommentsとしてbuildします。
  @comment = current_user.comments.build(comment_params)
  @topic = @comment.topic
  # クライアント要求に応じてフォーマットを変更
  respond_to do |format|
    if @comment.save
      # format.html { redirect_to topics_path(@topic), notice: 'コメントを投稿しました。' }
      format.js {render :index}
    else
      format.html { render :new }
    end
  end
end

def edit
    # binding.pry
    @comment = Comment.find(params[:id])
    @topic = @comment.topic
   end



  def update
    #binding.pry

    @comment = Comment.find(params[:id])
    @topic = @comment.topic
    @comment.update(comment_params)
     if @comment.save
       redirect_to topics_path(@topic), notice: "コメントを編集しました！"
     else
         render 'edit'
      end
  end

def destroy
      @comment = Comment.find(params[:id])
      @comment.destroy
      @topic = @comment.topic
      respond_to do |format|
          # format.html { redirect_to topic_comment_path(@topic, @comment), notice: 'コメントを削除しました。' }
          format.js { render :index }
      end
    end

private
  # ストロングパラメーター
  def comment_params
    params.require(:comment).permit(:topic_id, :content)
  end
end
