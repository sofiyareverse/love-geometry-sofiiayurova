require File.expand_path '../spec_helper.rb', __FILE__

describe "Love Stories App" do
  let(:context) { DecryptData.new(data) }

  it "should show greetings" do
    get '/'
    expect(last_response.body).to eq('Welcome to lovestories!')
  end

  it "should parse love stories" do
    get '/lovestories', data:  ['asdasd', 'asdasd']
    expect(last_response.body).to eq(['asdasd', 'asdasd'])
  end
end
