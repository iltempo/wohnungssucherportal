class FlatsController < ApplicationController

  rescue_from 'ActiveRecord::RecordNotFound' do
    redirect_to flats_path, :alert => "The requested flat could not be found."
  end
  
  def index
    @flats = FlatDecorator.decorate(current_user.flats.for_index.ordered(params[:order]))
  end
  
  def all
    @flats = FlatDecorator.decorate(current_user.flats.all)
    render :action => 'index'
  end

  def show
    @flat = FlatDecorator.decorate(current_user.flats.find(params[:id]))
  end

  def prefill_url_form
  end
  
  def new
    if params[:url].present?
      @flat = Flat.from_url(params[:url]).with_defaults
    else
      @flat = Flat.new(:available_on => Date.today.next_month.at_beginning_of_month).with_defaults
    end
  end

  def edit
    @flat = current_user.flats.find(params[:id])
  end

  def create
    @flat = current_user.flats.new(params[:flat])

    if @flat.save
      flash[:created_flat_id] = @flat.id
      redirect_to flats_path, :notice => 'Flat created.'
    else
      flash[:error] = @flat.errors
      render :action => "new"
    end
  end

  def update
    @flat = current_user.flats.find(params[:id])

    respond_to do |format|
      if @flat.update_attributes(params[:flat])
        flash[:notice] = 'Flat updated.'
        format.html { redirect_to(flats_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @flat.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @flat = current_user.flats.find(params[:id])
    @flat.destroy

    respond_to do |format|
      format.html { redirect_to(flats_path) }
      format.xml  { head :ok }
    end
  end
end
