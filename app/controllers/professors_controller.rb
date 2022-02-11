class ProfessorsController < ApplicationController

  def index
    @professors = Professor.all.alphabetical_order
  end

  def show
    @professor = Professor.find(params[:id])
    @students = @professor.students
  end
end
