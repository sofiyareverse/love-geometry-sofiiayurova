require File.expand_path 'spec_helper.rb', __dir__

describe 'Love Stories App' do
  let(:context) { DecryptData.new(data) }
  let(:data) do
    {
      data:
       [
         'A loves B but B hates A.',
         'A hates B, A loves D while B loves C and D hates A.',
         'A loves B, B loves A and B loves D.',
         'A loves B but B hates A',
         'D loves B and C loves A.'
       ]
    }
  end

  let(:result) do
    [
      { "A": { "loves": 'B' } }, { "B": { "hates": 'A.' } },
      { "A": { "hates": 'B' } }, { "A": { "loves": 'D' } },
      { "B": { "loves": 'C' } }, { "D": { "hates": 'A.' } },
      { "A": { "loves": 'B' } }, { "B": { "loves": 'A' } },
      { "B": { "loves": 'D.' } }, { "A": { "loves": 'B' } },
      { "B": { "hates": 'A' } }, { "D": { "loves": 'B' } },
      { "C": { "loves": 'A.' } }
    ]
  end

  it 'should show greetings' do
    get '/'

    expect(last_response.body).to eq('Welcome to lovestories!')
  end

  it 'should be ok' do
    get '/'

    expect(last_response.status).to eq(200)
  end

  it 'must be ok' do
    post '/lovestories', data.to_json

    expect(last_response.status).to eq(200)
  end

  it 'should parse love stories' do
    post '/lovestories', data.to_json

    expect(last_response.body).to eq(result.to_json)
  end
end
