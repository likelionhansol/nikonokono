class ShowmeController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
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
    @post.link_select = params[:link_select]
      @post.video_url = params[:video_url]
    if @post.link_select == 'youtube'
      @post.ytb_key = @post.video_url.split("=").at(1)
    else
      @post.sc_link = @post.video_url
    end
    @post.content = params[:content]
    @post.singer = params[:singer]
    @post.song = params[:song]
    @post.user = current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to "/showme/index", notice: '성공적으로 글이 작성됬습니다.' }
      else
        format.html { render :new }
      end
    end

    # @link_sel = params[:link_select]
    # if @link_sel == 'youtube'
    #   @ytb_url = params[:video_url]
    #   @ytb_key = @ytb_url.split("=").at(1)
    #
    #   puts ("youtube ++++++++++++++++++++ " + @ytb_key)
    # else
    #   @sc_url = params[:video_url]
    #   puts ("soundcloud ++++++++++++++++++++ " + @sc_url)
    # end

  end

  # 글을 쓰는 곳
  def new

  end

  # 글을 수정하는 곳
  def edit
    authorize_action_for @post
  end

  def show
    #prev_url 세션 등록
    session[:prev_url] = request.referer
    # 클릭당 조회수 1 증가
    @post.hit = @post.hit + 1
    @post.save
  end

  def reconum
    @recommend = Recommend.new #따로 이메일은 확인하기 위한 DB
    @post.reconum = params[:reconum]

    @reco = Recommend.all
    reco_bool = 0

    #recommend에 들어있는 db와 해당 post_id 비교해서 bool값 바꾸기
    @reco.each do |r|
      if r.post_id == @post.id
        if r.email == current_user.email
          reco_bool = 1
          break
        end
      end
    end

    if current_user.email == @post.user.email # 자신의 글인지 아닌지 판단
      redirect_to "/showme/index"
    else
      if reco_bool == 0 #추천성공
        @recommend.post_id = @post.id
        @recommend.email = current_user.email
        @post.reconum = @post.reconum + 1  # 추천수 증가
        @recommend.save
        @post.save
        redirect_to "/showme/index"
      else #이미추천된것.
        redirect_to "/showme/index"
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
    new_reply.email = params[:reply_email]
    new_reply.save

    respond_to do |format|
      msg ={ :status => "ok", :message => "success"}
      format.json {render :json=>msg}

    end
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
  def reply_update
    @one_reply = Reply.find(params[:reply_id])
    @one_reply.content = params[:update_content]
    @one_reply.save

    redirect_to session[:prev_url]
    #redirect_to "/showme/index"
    #redirect_to action: "show",reply_id: :reply_id
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:post_id])
    end
end
