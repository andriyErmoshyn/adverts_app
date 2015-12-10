class AdsController < ApplicationController
  load_and_authorize_resource
    
  def index
    if params[:search]
      @ads = Ad.search(params[:search])
    else
      @ads = Ad.all
    end
  end
 
  def create
    @ad = current_member.ads.build(ad_params)
    if @ad.save
      flash[:success] = "The ad was successfully created!"
      redirect_to root_url
    else
      flash.now[:warning] = "Try again please."
      render 'new'
    end
  end

  def update
    if @ad.update_attributes(ad_params)
      flash[:success] = "The ad was successfully updated"
      redirect_to @ad
    else
      render 'edit'
    end
  end

  def destroy
    Ad.find_by(id: params[:id]).destroy
    flash[:warning] = "The ad was successfully destroyed."
    redirect_to root_url
  end

  private
  
    def ad_params
      params.require(:ad).permit(:ad_content, :ad_image)
    end

end
