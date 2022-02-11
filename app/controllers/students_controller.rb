class StudentsController < ApplicationController
  def index
    @students = Student.all.alphabetical_order
  end
end
