icount = 0;
offset = 1000;
while(true)
  tempCount = 0
  PopularTracksLastfmTemp.find(:all, :conditions =>["id > ? and id < ?" , icount, icount+offset ]).each do |pdf|
    puts "processing: " + pdf.id
    tempa = PopularTracksLastfmTempA.find_by_altnet_id(pdf.altnet_id)
    if (tempa == nil)
      tempa = PopularTracksLastfmTempA.new
      tempa.altnet_id = pdf.altnet_id
      tempa.lastfm = pdf.lastfm
      tempa.save
    end # end of if
    tempCount = tempCount + 1
  end #end of iteration
  icount = icount + offset
  if (tempCount == 0)
    break
  end
end#end of while
