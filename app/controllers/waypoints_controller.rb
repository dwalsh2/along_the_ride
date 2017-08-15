class WaypointsController < ApplicationController
  def index
    @q = Waypoint.ransack(params[:q])
    @waypoints = @q.result(:distinct => true).includes(:route, :businesses).page(params[:page]).per(10)

    render("waypoints/index.html.erb")
  end

  def show
    @business = Business.new
    @waypoint = Waypoint.find(params[:id])

    render("waypoints/show.html.erb")
  end

  def new
    @waypoint = Waypoint.new

    render("waypoints/new.html.erb")
  end

  def create
    @waypoint = Waypoint.new

    @waypoint.business_id = params[:business_id]
    @waypoint.latitude = params[:latitude]
    @waypoint.longitude = params[:longitude]
    @waypoint.route_id = params[:route_id]

    save_status = @waypoint.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/waypoints/new", "/create_waypoint"
        redirect_to("/waypoints")
      else
        redirect_back(:fallback_location => "/", :notice => "Waypoint created successfully.")
      end
    else
      render("waypoints/new.html.erb")
    end
  end

  def edit
    @waypoint = Waypoint.find(params[:id])

    render("waypoints/edit.html.erb")
  end

  def update
    @waypoint = Waypoint.find(params[:id])

    @waypoint.business_id = params[:business_id]
    @waypoint.latitude = params[:latitude]
    @waypoint.longitude = params[:longitude]
    @waypoint.route_id = params[:route_id]

    save_status = @waypoint.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/waypoints/#{@waypoint.id}/edit", "/update_waypoint"
        redirect_to("/waypoints/#{@waypoint.id}", :notice => "Waypoint updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Waypoint updated successfully.")
      end
    else
      render("waypoints/edit.html.erb")
    end
  end

  def destroy
    @waypoint = Waypoint.find(params[:id])

    @waypoint.destroy

    if URI(request.referer).path == "/waypoints/#{@waypoint.id}"
      redirect_to("/", :notice => "Waypoint deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Waypoint deleted.")
    end
  end
end
