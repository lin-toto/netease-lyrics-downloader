#!/usr/bin/env ruby
# coding: utf-8 

require 'net/http'
require 'json'

class String
    def is_i?
       !!(self =~ /\A[-+]?[0-9]+\z/)
    end
end

if ARGV.count == 0
	puts "Usage: #{__FILE__} [SongID]"
	puts ""
	puts "Multiple SongIDs can be applyed simotaniously as parameters."
	puts "Lyrics will be saved to [SongID].lrc"
else
	ARGV.each do |id|
		if !id.is_i?
			puts "#{id}: not an valid ID"
			next
		end

		uri = URI("http://music.163.com/api/song/media?id=#{id}")
		json_data = Net::HTTP.get uri
		json = JSON.parse json_data

		lyric_file = File.open "#{id}.lrc", "w"
		lyric_file << json["lyric"]
		lyric_file.close

		puts id

	end
end
	
