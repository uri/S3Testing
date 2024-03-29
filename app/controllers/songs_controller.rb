class SongsController < ApplicationController
  include SongsHelper

  def index
    @songs = AWS::S3::Bucket.find(BUCKET).objects
  end

  def upload  
      begin  
          # Store the object
          AWS::S3::S3Object.store(sanitize_filename(
            params[:mp3file].original_filename), 
            params[:mp3file].read, BUCKET, 
            :access => :public_read)  
          
          redirect_to root_path  
      rescue  
          render :text => "Couldn't complete the upload"  
      end  
  end 

  def delete
    if params[:song]
      AWS::S3::S3Object.find(params[:song], BUCKET).delete
    else
      render :text => "No song was found!"
    end

  end



  
end
