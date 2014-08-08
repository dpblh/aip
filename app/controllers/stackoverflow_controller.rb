class StackoverflowController < ApplicationController
	include StackoverflowHelper
	def index
		@users = get_api 'users', filter_params
		@users = @users['items'].paginate(page: params[:page], total_entries: total_users / filter_params[:pagesize].to_i, :per_page => 10)
	end
	def show
		@questions = get_api("users/#{params[:id]}/questions")['items']
	end

	private

		def total_users
			get_api('users', filter: :total, inname: params[:inname])['total']
		end
		def filter_params
      		temp = params.permit(:page, :inname, :pagesize)
      		temp[:page] = 1 unless temp[:page]
      		temp[:pagesize] = PAGESIZE unless temp[:pagesize]
      		temp
    	end
end
