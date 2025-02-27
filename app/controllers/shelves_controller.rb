class ShelvesController < ApplicationController
  before_action :set_shelf, only: %i[show edit update destroy]

  # GET /shelves
  def index
    @public_shelves = Shelf.where(public: true)
    @my_shelves = current_user&.shelves || []
  end

  # GET /shelves/:id
  def show
    @shelf = Shelf.find(params[:id])
    unless @shelf.public || current_user == @shelf.user
      redirect_to shelves_path, alert: "You are not authorized to view this shelf."
    end
  end

  # GET /shelves/new
  def new
    @shelf = current_user.shelves.build
  end

  # POST /shelves
  def create
    @shelf = current_user.shelves.build(shelf_params)
    if @shelf.save
      redirect_to @shelf, notice: "Shelf created successfully."
    else
      render :new
    end
  end

  # GET /shelves/:id/edit
  def edit
    @shelf = Shelf.find(params[:id])
  end

  # PATCH/PUT /shelves/:id
  def update
    if @shelf.update(shelf_params)
      redirect_to @shelf, notice: "Shelf updated successfully."
    else
      render :edit
    end
  end

  # DELETE /shelves/:id
  def destroy
    @shelf.destroy
    redirect_to shelves_path, notice: "Shelf deleted successfully."
  end

  private

  # Find shelf by ID and ensure it belongs to the current user for sensitive actions
  def set_shelf
    @shelf = current_user.shelves.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to shelves_path, alert: "Shelf not found."
  end

  # Strong parameters for shelf creation and updates
  def shelf_params
    params.require(:shelf).permit(:title, :description, :public)
  end
end
