class DosesController < ApplicationController
  def index
    @doses = Dose.all
  end

  def new
    @dose = Dose.new
  end

  def show
  end

  def create
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.new(dose_params)
    @dose.cocktail_id = params['cocktail_id'].to_i
    @dose.ingredient_id = params['dose']['ingredient_id'].to_i
    if @dose.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  def destroy
    @cocktail = params[:cocktail_id]
    @dose = Dose.find(params[:id])
    @dose.destroy
    # no need for app/views/restaurants/destroy.html.erb
    redirect_to cocktail_path(@cocktail)
  end

  private

  def dose_params
    # *Strong params*: You need to *whitelist* what can be updated by the user
    # Never trust user data!
    params.require(:dose).permit(:description)
  end
end
