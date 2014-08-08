require 'net/http'

module StackoverflowHelper
	PAGESIZE = 10
	def get_api (path, params = {})
		uri = URI("http://api.stackexchange.com/2.2/#{path}")
		params[:site] = 'stackoverflow'
		uri.query = URI.encode_www_form(params)
		response = JSON.parse(Net::HTTP.get uri)
		response
	end
end

class Array
	def paginate(options = {})
		page = options[:page] || 1
		per_page = options[:per_page] || WillPaginate.per_page
		total = options[:total_entries] || self.length
		WillPaginate::Collection.create(page, per_page, total) do |pager|
			pager.replace self
		end
	end
end
