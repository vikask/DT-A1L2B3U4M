class PicturesController < ApplicationController
  # GET /pictures
  # GET /pictures.json
  def index

    @gallery = Gallery.find(params[:gallery_id])

    @pictures = @gallery.pictures

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pictures }
    end
  end

  # GET /pictures/1
  # GET /pictures/1.json
  def show
    @picture = Picture.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @picture }
    end
  end

  # GET /pictures/new
  # GET /pictures/new.json
  def new
    @gallery = Gallery.find(params[:gallery_id])
    @picture = @gallery.pictures.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @picture }
    end
  end

  # GET /pictures/1/edit
  def edit
    @gallery = Gallery.find(params[:gallery_id])

    @picture = @gallery.pictures.find(params[:id])
    # @picture = Picture.find(params[:id])
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @picture }
    end
  end

  # POST /pictures
  # POST /pictures.json
  def create
    temp = 0
    p_attr = params[:picture]
    p_attr[:image] = params[:picture][:image].first if params[:picture][:image].class == Array

    @gallery = Gallery.find(params[:gallery_id])
    @picture = @gallery.pictures.build(p_attr)

    if @picture.save
      Rails.logger.debug"************TestnewID #{@picture.id}****************"
      @gallery.cover = @picture.id
      @gallery.save

      Rails.logger.debug"************Test3 #{@picture.id}****************"
      respond_to do |format|
        format.html {
          render :json => [@picture.to_jq_upload].to_json,
                 :content_type => 'text/html',
                 :layout => false
        }
        format.json {
          render :json => [@picture.to_jq_upload].to_json
        }
      end
    else
      render :json => [{:error => "custom_failure"}], :status => 304
    end
  end

  # PUT /pictures/1
  # PUT /pictures/1.json
  def update

    @gallery = Gallery.find(params[:gallery_id])

    @picture = @gallery.pictures.find(params[:id])

    respond_to do |format|
      if @picture.update_attributes(params[:picture])
        format.html { redirect_to gallery_path(@gallery), notice: 'Picture was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    @gallery = Gallery.find(params[:gallery_id])
    @picture = @gallery.pictures.find(params[:id])

    Rails.logger.debug"************test12 #{@gallery.cover}****************"
    Rails.logger.debug"************test13 #{params[:id]}****************"


    if (@gallery.cover.to_i == params[:id].to_i)
      Rails.logger.debug"************test14 #{@gallery.cover}****************"
      Rails.logger.debug"************test15 #{params[:id]}****************"

      @picture.destroy

      @pictures = @gallery.pictures.last
      #Rails.logger.debug"************test16 #{@pictures.id}****************"
      if !@pictures.id.nil? or !@pictures.id.empty?
        Rails.logger.debug"************test17 #{@pictures.id}****************"
        @gallery.cover = @pictures.id
        @gallery.save
      end
    else
      @picture.destroy
    end



    respond_to do |format|
      format.html { redirect_to gallery_pictures_url }
      format.js
    end
  end

  def make_default
    @picture = Picture.find(params[:id])
    @gallery = Gallery.find(params[:gallery_id])

    @gallery.cover = @picture.id
    @gallery.save

    respond_to do |format|
      format.js
    end
  end
end
