class ShowmeController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_post, only: [:show, :edit, :update, :destroy, :reconum]
  def index
    @posts = Post.all.order('id desc').
      paginate(page: params[:page], per_page: 3)
  end

  def listdetail

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
    # 클릭당 조회수 1 증가
    @post.hit = @post.hit + 1
    @post.save
  end

  # 추천수
  def reconum
    #@post = Post.find(params[:post_id])
    #@user = User.find(params[:id])
      respond_to do |format|
        if current_user.email == @post.user.email # 자신의 글인지 아닌지 판단
          format.html { redirect_to "/showme/index", notice: '자신의 글은 추천할 수 없습니다.'}
        else
          @post.reconum = @post.reconum + 1  # 추천수 증가
          @post.save
          format.html { redirect_to "/showme/index", notice: '추천 성공!' }
        end
      end
  end

  # 글의 수정이 이루어 지는 곳
  def update
    authorize_action_for @post

    @post.title = params[:update_title]
    @post.video_url = params[:update_video_url]
    @post.content = params[:update_content]
    @post.singer = params[:update_singer]
    @post.song = params[:update_song]
    @post.save

    redirect_to "/showme/index"
  end

  def destroy
    authorize_action_for @post
    @post.destroy

    redirect_to "/showme/index"
  end

  def reply
    new_reply = Reply.new
    new_reply.content = params[:reply_content]
    new_reply.post_id = params[:id_of_post]
    new_reply.save

    redirect_to :back
  end

  # 댓글 지우는 부분
  def reply_destroy
     @one_reply = Reply.find(params[:reply_id])
     @one_reply.destroy

     redirect_to :back
  end

  # 업데이트 하는 곳
  def reply_edit
    @one_reply = Reply.find(params[:reply_id])
  end

  # 업데이트 처리 되는 부분
  def real_update
    real_update_post = Reply.find(params[:reply_id])
    real_update_post.content = params[:update_content]
    real_update_post.save

    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end
end
