class ProgramEmployeesController < ApplicationController
	
	def create
		@employee = User.all

		@case = ProgramEmployee.new({
			user_id: params[:program_employee][:user_id],
			programable_id: params[:programable_id],
			programable_type: params[:programable_type]
			})
    if @case.save
		  flash[:success] = "Employee Assigned"
			redirect_to "/"		
		else
		  render :clients
		end
	end

	def show
		@order = ProgramEmployee.find(params[:id])
	end

end
