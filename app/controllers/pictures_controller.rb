class PicturesController < ApplicationController
    
    
#    def new
#       @picture = Picture.new 
#    end
    
#    def create
#       @picture = Picture.new
#        @picture.create(params_pict)
#    end
##    
##    
##    
##    private
##    
    def params_pict
    params.require(:picture).permit(:picture, :picture_cache)
    end
#    
end
