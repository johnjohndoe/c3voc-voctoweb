require 'test_helper'

class RecordingsApiTest < ActionDispatch::IntegrationTest
  FILE = 'test.mp3'.freeze

  setup do
    @key = create(:api_key)
    @event = create(:event)
    @file = create_test_file FILE
    @json = get_json
  end

  def get_json
    json = '{'
    json += '"api_key":"'
    json += @key.key
    json += '",'
    json += '"guid":"' + @event.guid + '",'
    json += '"recording":'
    d = '{"filename":"some.mp4","folder":"","mime_type":"audio/ogg","size":"12","length":"30"}'
    json += d
    json += '}'
    json
  end

  test 'should create recording via json' do
    assert JSON.parse(@json)
    assert_difference('Recording.count') do
      post_json '/api/recordings.json', @json
    end
    assert @event.recordings.last
  end
end
