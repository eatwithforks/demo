# encoding: utf-8
require_relative '../lib/helpers/test_helper'

class TestFileList < Minitest::Test
  parallelize_me!

  def setup
    @api = Api.new
  end

  def test_one
    resp = @api.get('channels.list')
    puts resp
  end
end
