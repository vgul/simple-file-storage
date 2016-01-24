
class Storage 
  include Mongoid::Document
  mount_uploader :file, FileUploader

  before_save :set_unique_id

  field :user, type: String
  field :description, type: String
  field :file, type: String
  field :unique_id, type: String

  validates :file, presence: true # Make sure the owner's name is present.

  def extension
    File.extname(file.to_s)
  end

  #def set_user
  #  self.user = session[:user_id]
  #end

  def set_unique_id

    @mixed_array = ('A'..'Z').to_a.shuffle

    begin
     
      @str1 = @mixed_array[0..2].join
      @str2 = @mixed_array[3..5].join
      @str3 = @mixed_array[6..8].join
      @hex1 = (sprintf "%02x", rand(255)).upcase
      @hex2 = (sprintf "%02x", rand(255)).upcase

      @candidate_for_id = "#{@str1}-#{@hex1}-#{@str2}-#{@hex2}-#{@str3}"

    end while Storage.where("unique_id": @candidate_for_id).first

    self.unique_id = @candidate_for_id

  end

end
