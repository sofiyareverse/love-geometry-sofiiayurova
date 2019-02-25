require 'sinatra'
require "sinatra/namespace"

class DecryptData
  attr_reader :data, :result

  def initialize(data)
    @data = data
    @result = []
  end

  def call
    @data.each do |s|
      s_arr = s.split(/(.)(,)/).map(&:split).flatten
      for i in (0..s_arr.length).step(4) do
        @result << {
          s_arr[i] => { s_arr[i + 1]&.to_sym => s_arr[i + 2] }
        }
      end
    end
    @result
  end
end

get '/' do
  'Welcome to lovestories!'
end

post '/lovestories' do
  result = DecryptData.new(JSON.parse(request.body.read)['data']).call
  result.to_json
end
