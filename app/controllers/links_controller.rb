class LinksController < ApplicationController
  before_action :authenticate_user!, except: [ :redirect_to_original, :verify_password ]
  before_action :set_link, only: [ :show, :edit, :update, :destroy, :redirect_to_original, :verify_password, :access_per_day, :access_details ]
  before_action :only_owner, only: [ :show, :edit, :update, :destroy ]

  # GET /links or /links.json
  def index
    @links = current_user.links.page params[:page]
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
  end

  # POST /links or /links.json
  def create
    @link = Link.new(link_params)
    if @link.save
      redirect_to links_path, notice: "Link was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /links/1 or /links/1.json
  def update
    if @link.update(link_params)
      redirect_to link_url(@link), notice: "Link was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /links/1 or /links/1.json
  def destroy
    @link.destroy!

    redirect_to links_path, notice: "Link was successfully destroyed."
  end

  # GET /l/slug
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
      register_access
      redirect_to @link.url, allow_other_host: true
    else
      flash.now[:error] = res[:message]
      render "links/password_form"
    end
  end

  # GET /links/1/access_per_day
  def access_per_day
    @access_counts = @link.accesses.group("DATE(created_at)").count.to_a
    @access_counts = Kaminari.paginate_array(@access_counts).page params[:page]
  end

  # GET /links/1/access_details
  def access_details
    @access_details = @link.accesses

    start_date = params[:start_date]
    end_date = params[:end_date]
    ip = params[:ip]

    if start_date.present? && end_date.present?
      if start_date > end_date
        flash[:error] = 'Start date must be before end date.'
        redirect_to access_details_path(@link)
      end
      start_datetime = DateTime.parse(start_date.to_s).beginning_of_day
      end_datetime = DateTime.parse(end_date.to_s).end_of_day
      @access_details = @access_details.where(created_at: start_datetime..end_datetime)
    end

    @access_details = @access_details.where(ip_address: ip) if ip.present?

    @access_details = @access_details.page params[:page]
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
      params.require(:link).permit(
          :url, :type, :name, :expiration_date, :password, :entered,
          :user_id, :start_date, :end_date, :ip, :page
      )
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
