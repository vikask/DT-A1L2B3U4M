class GalleriesController < ApplicationController
  # GET /galleries
  # GET /galleries.json
  def index
    @user = current_user
    Rails.logger.debug"************Testing#{@user.inspect}"
    @users = User.find_by_id(@user)
    @galleries = @user.galleries

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @galleries }
    end
  end

  # GET /galleries/1
  # GET /galleries/1.json
  def show
    @user = current_user
    @gallery = current_user.galleries.find(params[:id])
    Rails.logger.debug"************Testing ga#{@gallery.inspect}"
    @picture = @gallery.pictures.build
    @pictures = Picture.find(:all, :conditions  => [ 'gallery_id = ?', @gallery.id ])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @gallery }
    end
  end

  # GET /galleries/new
  # GET /galleries/new.json
  def new
    @user = current_user
    @gallery = Gallery.new(:user_id => @user.id)
    render :layout => false
  end

  # GET /galleries/1/edit
  def edit
    @gallery = Gallery.find(params[:id])
  end

  # POST /galleries
  # POST /galleries.json
  def create
    @gallery = current_user.galleries.build(params[:gallery])
    Rails.logger.debug"************Testing Create#{@gallery.inspect}"
    respond_to do |format|
      if @gallery.save
        format.html { redirect_to @gallery, notice: 'Gallery was successfully created.' }
        format.json { render json: @gallery, status: :created, location: @gallery }
      else
        format.html { render action: "new" }
        format.json { render json: @gallery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /galleries/1
  # PUT /galleries/1.json
  def update

    @gallery = current_user.galleries.find(params[:id])

    respond_to do |format|
      if @gallery.update_attributes(params[:gallery])
        format.html { redirect_to @gallery, notice: 'Gallery was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @gallery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /galleries/1
  # DELETE /galleries/1.json
  def destroy
    @gallery = current_user.galleries.find(params[:id])
    @gallery.destroy
    respond_to do |format|
      format.html { redirect_to gallery_url }
      format.js { render :layout => false }
    end
  end
end
