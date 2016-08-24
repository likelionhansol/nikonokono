class ShowmeController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  def index
    @posts = Post.all.reverse
  end

  def board

  end

  # 글 만드는 과정
  def create
    @post = Post.new
    @post.title = params[:title]
    @post.video_url = params[:video_url]
    @post.content = params[:content]
    @post.singer = params[:singer]
    @post.song = params[:song]
    @post.user = current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to "/showme/index", notice: 'Post was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # 글을 쓰는 곳
  def new

  end

  # 글을 수정하는 곳
  def edit
    authorize_action_for @post
  end

  def show
    @post = Post.find(params[:id])
  end

  def update
    authorize_action_for @post
  end

  def destroy
    authorize_action_for @post
    @post.destroy

    redirect_to "/showme/index"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end
end
