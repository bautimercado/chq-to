require 'digest/sha2'
require 'base64'

class LinksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_link, only: %i[ show edit update destroy ]

  # GET /links or /links.json
  def index
    @links = current_user.links
  end

  # GET /links/1 or /links/1.json
  def show
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
        @link.update(slug: encode_url(@link.url))
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
        @link.update(slug: "l/#{encode_url(@link.url)}")
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def link_params
      params.require(:link).permit(:url, :type, :name, :expiration_date, :password, :entered, :user_id)
    end

    def encode_url(url)
      #utf8_url = url.force_encoding('UTF-8')
      hashed_url = Digest::SHA2.hexdigest(url)
      short_hash = Base64.urlsafe_encode64(hashed_url)[0, 8]
      slug = "#{Rails.application.routes.default_url_options[:host]}l/#{short_hash}"
    end

end
