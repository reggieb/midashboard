class WidgetsController < ApplicationController
  # GET /widgets
  def index
    @widgets = Widget.all
  end

  # GET /widgets/1
  # GET /widgets/1.json
  def show
    @widget = Widget.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @widget.data }
    end
  end

  # GET /widgets/new
  def new
    @widget = Widget.new
  end

  # GET /widgets/1/edit
  def edit
    @widget = Widget.find(params[:id])
  end

  # POST /widgets
  def create
    @widget = Widget.new(params[:widget])


    if @widget.save
      redirect_to @widget, notice: 'Widget was successfully created.'
    else
      render action: "new"
    end

  end

  # PUT /widgets/1
  def update
    @widget = Widget.find(params[:id])

    if @widget.update_attributes(params[:widget])
      redirect_to @widget, notice: 'Widget was successfully updated.' 
    else
      render action: "edit"
    end

  end

  # DELETE /widgets/1
  def destroy
    @widget = Widget.find(params[:id])
    @widget.destroy
    redirect_to widgets_url
  end
end
