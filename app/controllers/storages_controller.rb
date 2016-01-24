class StoragesController < ApplicationController

  before_action :set_storage, only: [:destroy]

  # GET /storages
  def index

    if !session[:user_id]

      ## https://docs.mongodb.org/ecosystem/tutorial/ruby-mongoid-tutorial/#map-reduce
      map = %Q{
        function() {
          emit(this.user, 1);
        }
      }

      reduce = %Q{
        function(key, count) {
          var result = 0
          count.forEach(function(c) {
              result += c
          });
          return result;
          // parseInt(result);
        }
      }

      #Storage.map_reduce(map,reduce).out(inline: 1).sort_by{|h| h[:value]}.reverse.each do |document|
      #    Rails.logger.info "group_by: " + document.to_s
      #end

      @users = Storage.map_reduce(map,reduce).out(inline: 1).sort_by{|h| h[:value]}.reverse

      # Change floats to integers
      @users.each do |u|
        u[:value] = u[:value].to_i
      end

    else

      # for form_for tag in view
      @storage = Storage.new

      # To list uploaded files
      @storages = Storage.all.where( user: session[:user_id] ).sort( _id:-1 )

      # Discard filtering. For debug
      #@storages = Storage.all.sort( _id:-1 )

    end
  end

  # GET /storages/new
  def new
    @storage = Storage.new
  end

  def create
    @storage = Storage.new(storage_params)

    if @storage.save
      redirect_to "/", notice: "The file '#{File.basename(@storage.file.to_s)}' has been uploaded."
    else

      # Approach to pass error message to non-native action and view
      flash[:creation_error] = @storage.errors.full_messages
      redirect_to root_path # instead new_storage_path

    end
 
  end

  def destroy
    @storage.destroy

    redirect_to "/", notice: "File '#{File.basename(@storage.file.to_s)}' was successfully destroyed."

  end



  private

    # Use callbacks to share common setup or constraints between actions.
    def set_storage
      @storage = Storage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def storage_params

      params.require(:storage).permit(:user, :file, :description)
            .merge(user: session[:user_id])
    end

end

