class DashboardsController < ApplicationController

  before_filter :get_dashboard, only: [:show, :edit, :update, :destroy]
  before_filter :get_widgets, only: [:edit, :update, :create, :new]

  def index
    @dashboards = Dashboard.all
  end

  def show

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
    if @dashboard.update_attributes(params[:dashboard])
      remove_unselected_widgets
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

  def remove_unselected_widgets
    @dashboard.widgets.each{|w| @dashboard.widgets.destroy(w) unless widget_ids_params_include?(w.id)}
  end

  def widget_ids_params_include?(id)
    params[:dashboard][:widget_ids] and params[:dashboard][:widget_ids].include?(id.to_s)
  end
end
