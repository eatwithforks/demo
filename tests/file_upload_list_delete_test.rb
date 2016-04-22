# encoding: utf-8
require_relative '../lib/helpers/test_helper'

def file_exists_in_list?(file_id)
  Timeout.timeout(@time_allotted) do
    begin
      loop do
        @data = @api.get('files.list', 'types=images')
        assert @data['ok']

        break if @data['files'].detect { |f| f['id'].eql? file_id }
      end
    rescue Timeout::Error
      puts "uploaded file: #{file_id} was not found in list after #{@time_allotted}"
    end
  end
  @data['files'].detect { |f| f['id'].eql? file_id }
end

class TestFileUploadListDelete < Minitest::Test
  def setup
    @api = Api.new
    @time_allotted = 60
    @known_url_params = %w(
      id url_private url_private_download
      thumb_64 thumb_80 thumb_360 thumb_480
      thumb_160 permalink permalink_public
     )

    @known_thumbnail_urls = %w(
      url_private url_private_download
      thumb_64 thumb_80 thumb_360 thumb_480
      thumb_160 permalink
    )
  end

  def test_upload_list_delete
    # Upload file
    upload_response = @api.post('files.upload', '../lib/data/slack-logo.jpg')
    upload_data = JSON.parse(upload_response)
    name = upload_data['file']['name'].split('.').first.downcase
    assert upload_data['ok'], "upload did not return ok = true: #{upload_data}"

    # assert file object with a file ID and all expected thumbnail URLs
    missing_urls = @known_url_params - upload_data['file'].keys
    assert_empty missing_urls, "upload data is missing url links: #{missing_urls}"

    # the filename will be a lowercase version of the original upload
    thumbnail_urls = []
    @known_thumbnail_urls.each { |url| thumbnail_urls << upload_data['file'][url] }
    assert thumbnail_urls.all? { |url| url.split('/').last.match(name).to_s.eql? name }, "thumbnail_urls not downcased: #{thumbnail_urls}"

    file_id = upload_data['file']['id']
    # File id exists in Files.list, filtering by types=images
    assert_equal file_id, file_exists_in_list?(file_id)['id']

    # Delete a file you uploaded and confirm it is deleted
    delete_response = @api.delete('files.delete', "file=#{file_id}")
    assert delete_response['ok'], "delete did not return ok = true: #{delete_response}"

    confirm_deleted = @api.get('files.list', 'types=images')
    assert confirm_deleted['ok']
    assert_nil confirm_deleted['files'].detect { |f| f['id'].eql? file_id }, "file #{file_id} still exists in files.list"

    # Delete a file that doesn't exist and confirm that the correct error message appears
    invalid_delete = @api.delete('files.delete', 'file=foobar')
    refute invalid_delete['ok']
    assert_equal 'file_not_found', invalid_delete['error']
  end
end
