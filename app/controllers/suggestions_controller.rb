class SuggestionsController < ApplicationController
  def index
    @suggestions = Suggestion.all
    authorize @suggestions
  end

  def show
    @suggestion = Suggestion.find(params[:id])
    authorize @suggestion
  end

  def new
    @suggestion = Suggestion.new
    authorize @suggestion
  end

  def create
    @suggestion = current_user.suggestions.build(params.require(:suggestion).permit(:title, :body))
    if @suggestion.save
      flash[:notice] = "Your suggestion was posted. Thank you for your ideas!"
      redirect_to @suggestion
    else
      flash[:error] = "There was an error posting your suggestion.  Please try again."
      render :new
    end
  end

  def edit
    @suggestion = Suggestion.find(params[:id])
  end

  def update
    @suggestion = Suggestion.find(params[:id])
    if @suggestion.update_attributes(params.require(:suggestion).permit(:title, :body))
      flash[:notice] = "Your suggestion has been updated."
      redirect_to @suggestion
    else
      flash[:error] = "There was a proble updating your suggestion. Please try again."
      render :edit
    end
  end

  def destroy
    @suggestion = Suggestion.find(params[:id])
    if @suggestion.destroy
      flash[:notice] = "Your suggestion was removed."
      redirect_to suggestions_path
    else
      flash[:notice] = "Your suggestion was not removed. Please try again."
      redirect_to :back
    end
  end
end
