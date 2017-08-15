class BusinessesController < ApplicationController
  def index
    @q = Business.ransack(params[:q])
    @businesses = @q.result(:distinct => true).includes(:waypoint).page(params[:page]).per(10)

    render("businesses/index.html.erb")
  end

  def show
    @business = Business.find(params[:id])

    render("businesses/show.html.erb")
  end

  def new
    @business = Business.new

    render("businesses/new.html.erb")
  end

  def create
    @business = Business.new

    @business.waypoint_id = params[:waypoint_id]
    @business.name = params[:name]
    @business.image_url = params[:image_url]
    @business.url = params[:url]
    @business.phone = params[:phone]
    @business.rating = params[:rating]
    @business.location = params[:location]
    @business.yelp_api_return = params[:yelp_api_return]

    save_status = @business.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/businesses/new", "/create_business"
        redirect_to("/businesses")
      else
        redirect_back(:fallback_location => "/", :notice => "Business created successfully.")
      end
    else
      render("businesses/new.html.erb")
    end
  end

  def edit
    @business = Business.find(params[:id])

    render("businesses/edit.html.erb")
  end

  def update
    @business = Business.find(params[:id])

    @business.waypoint_id = params[:waypoint_id]
    @business.name = params[:name]
    @business.image_url = params[:image_url]
    @business.url = params[:url]
    @business.phone = params[:phone]
    @business.rating = params[:rating]
    @business.location = params[:location]
    @business.yelp_api_return = params[:yelp_api_return]

    save_status = @business.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/businesses/#{@business.id}/edit", "/update_business"
        redirect_to("/businesses/#{@business.id}", :notice => "Business updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Business updated successfully.")
      end
    else
      render("businesses/edit.html.erb")
    end
  end

  def destroy
    @business = Business.find(params[:id])

    @business.destroy

    if URI(request.referer).path == "/businesses/#{@business.id}"
      redirect_to("/", :notice => "Business deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Business deleted.")
    end
  end
end
