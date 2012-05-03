module SongsHelper

	BUCKET = "uri-test-blog"

	# Replaces \ with _?
	def sanitize_filename(file_name)  
	    just_filename = File.basename(file_name)  
	    just_filename.sub(/[^\w\.\-]/,'_')  
	end  

	def download_url_for(song_key)
		AWS::S3::S3Object.url_for(song_key, BUCKET, :authenticated => false)
	end

	def torrent_url_for song_key
		"#{download_url_for song_key}?torrent"
	end
end
