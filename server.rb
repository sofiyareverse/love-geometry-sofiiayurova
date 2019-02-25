require 'sinatra'
require "sinatra/namespace"
require'mongoid'

Mongoid.load! "mongoid.config"

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
  'Welcome to LoveStory!'
end

namespace '/api/v1 ' do

  before do
    content_type 'application/json'
  end

  get '/lovestories' do
    DecryptData.new('A loves B but B hates A.')
  end
end
