class EmailsController < ApplicationController

	def index
		@emails = Email.all
	end

	def create
		@email = Email.new(object: Faker::Company.buzzword, body: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false))
		if @email.save
		  respond_to do |format|
		    format.html { redirect_to root_path }
		    format.js { }
		  end
		  flash[:notice] = "Email created"
		else
		  redirect_to root_path
		  flash[:notice] = "Please try again"
		end
	end

	def show
		@email = Email.find(params[:id])
		@email.update(read:true)
		respond_to do |format|
		  format.html { redirect_to root_path }
		  format.js { }
		end
	end

	def destroy
	  @email = Email.find(params[:id])

	  if @email.destroy
	    respond_to do |format|
	      format.js { }
	    end
	  end
	end

	def update
		@email = Email.find(params[:id])
		if @email.read == false
			@email.update(read:true)
		elsif @email.read == true
			@email.update(read:false)
		end
		respond_to do |format|
		  format.html { redirect_to root_path }
		  format.js { }
		end
	end

end
