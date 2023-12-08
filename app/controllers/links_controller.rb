class LinksController < ApplicationController
  before_action :authenticate_user!, except: [ :redirect_to_original, :verify_password ]
  before_action :set_link, only: [ :show, :edit, :update, :destroy, :redirect_to_original, :verify_password ]
  before_action :only_owner, only: [ :show, :edit, :update, :destroy ]

  # GET /links or /links.json
  def index
    @links = current_user.links
  end

  # GET /links/1 or /links/1.json
  def show
    @error_message = flash[:error]
  end

  # GET /links/new
  def new
    @link = current_user.links.build
  end

  # GET /links/1/edit
  def edit
    @link = Link.find(params[:id])
  end

  # POST /links or /links.json
  def create
    @link = Link.new(link_params)
    respond_to do |format|
      if @link.save
        format.html { redirect_to links_path, notice: "Link was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /links/1 or /links/1.json
  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to link_url(@link), notice: "Link was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1 or /links/1.json
  def destroy
    @link.destroy!

    respond_to do |format|
      format.html { redirect_to links_path, notice: "Link was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # GET /links/r/slug
  def redirect_to_original
    if @link.type == "PrivateLink"
      render "links/password_form" and return
    end
    res = @link.redirect
    if res[:success]
      register_access
      redirect_to @link.url, allow_other_host: true
    else
      flash[:error] = res[:message]
      render file: "#{Rails.root}/public/#{res[:status]}.html", layout: false
    end
  end

  # POST /links/r/passwd/slug
  def verify_password
    res = @link.redirect(params[:password])

    if res[:success]
      redirect_to @link.url, allow_other_host: true
    else
      flash.now[:error] = res[:message]
      render "links/password_form"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      if params[:id]
        @link = Link.find(params[:id])
      elsif params[:slug]
        @link = Link.find_by(slug: params[:slug])
      end
    end

    # Only allow a list of trusted parameters through.
    def link_params
      params.require(:link).permit(:url, :type, :name, :expiration_date, :password, :entered, :user_id)
    end

    def only_owner
      @link = Link.find(params[:id])
      unless @link.user == current_user
        render file: "#{Rails.root}/public/403.html", layout: false
      end
    end

    def register_access
      Access.create(link_id: @link.id, ip_address: request.remote_ip)
    end
end
