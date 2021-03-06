class TopicsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_topic, only: [:show, :edit, :update, :destroy]

  # GET /topics
  # GET /topics.json
  def index
    @topics = Topic.all.includes(:user)
    @topic = Topic.new
    @comment = @topic.comments.build
  end

  # GET /topics/1
  # GET /topics/1.json
  def show

  end

  # GET /topics/new
  def new
    @topic = Topic.new
  end

  # GET /topics/1/edit
  def edit
  end

  # POST /topics
  # POST /topics.json
  def create
    @topic = Topic.new(topic_params)
    @topic.user_id = current_user.id

   if @topic.content.present? || @topic.image.present?
    respond_to do |format|
      if @topic.save
         NoticeMailer.sendmail_topic(@topic).deliver
        format.html { redirect_to @topic, notice: '投稿完了' }
        # format.json { render :show, status: :created, location: @topic }
      else
        format.html { render :edit }
        # format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
   else
    redirect_to topics_path, notice:'空の投稿はできません'
   end
  end

  # PATCH/PUT /topics/1
  # PATCH/PUT /topics/1.json
  def update
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to @topic, notice: '投稿更新完了.' }
        format.json { render :show, status: :ok, location: @topic }
      else
        format.html { render :edit }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to topics_url, notice: '投稿削除完了' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def topic_params
      params.require(:topic).permit(:content, :image)
    end
end
