module ApplicationHelper

  def thumb_picture( file_object )

    if file_object.file.thumb.present?
       "<a href=\"#{file_object.file.thumb}\"><img src=\"#{file_object.file.thumb}\"/></a>"
    else
       "&nbsp;"
    end
  end

end


