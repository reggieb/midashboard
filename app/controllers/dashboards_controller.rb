class DashboardsController < ApplicationController

  before_filter :get_dashboard, only: [:show, :edit, :update, :destroy]
  before_filter :get_widgets, only: [:edit, :update, :create, :new]

  def index
    @dashboards = Dashboard.indulgence(current_user, :read)
  end

  def show
    @dashboard.widgets.each do |widget|
      widget.before(params[:before]) if params[:before]
      widget.after(params[:after]) if params[:after]
    end
  end

  def new
    @dashboard = Dashboard.new
  end

  def create
    @dashboard = Dashboard.new(params[:dashboard])
    if @dashboard.save
      redirect_to @dashboard, notice: 'Dashboard was successfully created.'
    else
      render action: "new"
    end
  end

  def edit

  end


  def update
    ensure_widget_ids_in_params
    if @dashboard.update_attributes(params[:dashboard])
      redirect_to @dashboard, notice: 'Dashboard was successfully updated.' 
    else
      render action: "edit"
    end
  end


  def destroy
    @dashboard.destroy
    redirect_to dashboards_url 
  end

  private
  def get_dashboard
    @dashboard = Dashboard.find(params[:id])
  end

  def get_widgets
    @widgets = Widget.all
  end

  def ensure_widget_ids_in_params
    params[:dashboard][:widget_ids] = [] unless params[:dashboard][:widget_ids]
  end


end
