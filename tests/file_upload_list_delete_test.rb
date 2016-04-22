# encoding: utf-8
require_relative '../lib/helpers/test_helper'

class TestFileUploadListDelete < Minitest::Test
  def setup
    @api = Api.new
  end

  def test_upload_list_delete
    # upload = @api.post('files.upload', '../lib/data/slack-logo.jpg')
    # puts upload
    delete = @api.delete('files.delete', 'file=F133P728Z')
    puts delete
  end
end
