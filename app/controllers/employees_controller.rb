class EmployeesController < ApplicationController

  def show
    @employee = Employee.find(params[:id])
    binding.pry
  end
  
end