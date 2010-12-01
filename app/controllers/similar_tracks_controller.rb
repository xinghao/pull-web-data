class SimilarTracksController < ApplicationController
  # GET /users
  # GET /users.xml
  def index
    #@ptracks = AggregateSimilarTracksStat.find(:all,  :limit => 1, :conditions =>["status = 1"])
    sql = "select tracks.id, tracks.name as track_name, artists.name as artist_name from aggregate_similar_tracks_stats, tracks,albums,artists where aggregate_similar_tracks_stats.status = 1 and aggregate_similar_tracks_stats.altnet_id =  tracks.id and  tracks.album_id = albums.id and albums.artist_id = artists.id limit 50000"
    @tracks =  Track.find_by_sql(sql)
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ptracks }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    #@remote_ip = request.env["HTTP_X_FORWARDED_FOR"]
    @track = Track.find(params[:id])
    #@similar_tracks = SimilarTrack.find(:all, :conditions =>["altnet_id = ?", params[:id]])
    sql = "select tracks.id, tracks.name as track_name, artists.name as artist_name, score from similar_tracks, tracks,albums,artists where altnet_id = " + params[:id] + " and similar_track_id = tracks.id and  tracks.album_id = albums.id and albums.artist_id = artists.id order by score desc"
    @similar_tracks =  Track.find_by_sql(sql) 

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @similar_tracks }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to(@user, :notice => 'User was successfully created.') }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
end
