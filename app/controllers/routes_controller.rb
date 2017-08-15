class RoutesController < ApplicationController
  before_action :current_user_must_be_route_user, :only => [:edit, :update, :destroy]

  def current_user_must_be_route_user
    route = Route.find(params[:id])

    unless current_user == route.user
      redirect_to :back, :alert => "You are not authorized for that."
    end
  end

  def index
    @q = current_user.routes.ransack(params[:q])
      @routes = @q.result(:distinct => true).includes(:user, :waypoints).page(params[:page]).per(10)

    render("routes/index.html.erb")
  end

  def show
    @waypoint = Waypoint.new
    @route = Route.find(params[:id])

    render("routes/show.html.erb")
  end

  def new
    @route = Route.new

    render("routes/new.html.erb")
  end

  def create
    @route = Route.new

    @route.user_id = params[:user_id]
    @route.starting_latitude = params[:starting_latitude]
    @route.starting_longitude = params[:starting_longitude]
    @route.ending_latitude = params[:ending_latitude]
    @route.ending_longitude = params[:ending_longitude]

    save_status = @route.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/routes/new", "/create_route"
        redirect_to("/routes")
      else
        redirect_back(:fallback_location => "/", :notice => "Route created successfully.")
      end
    else
      render("routes/new.html.erb")
    end
  end

  def edit
    @route = Route.find(params[:id])

    render("routes/edit.html.erb")
  end

  def update
    @route = Route.find(params[:id])
    @route.starting_latitude = params[:starting_latitude]
    @route.starting_longitude = params[:starting_longitude]
    @route.ending_latitude = params[:ending_latitude]
    @route.ending_longitude = params[:ending_longitude]

    save_status = @route.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/routes/#{@route.id}/edit", "/update_route"
        redirect_to("/routes/#{@route.id}", :notice => "Route updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Route updated successfully.")
      end
    else
      render("routes/edit.html.erb")
    end
  end

  def destroy
    @route = Route.find(params[:id])

    @route.destroy

    if URI(request.referer).path == "/routes/#{@route.id}"
      redirect_to("/", :notice => "Route deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Route deleted.")
    end
  end
end
