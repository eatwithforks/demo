# encoding: utf-8
require 'rest_client'
require 'yaml'
require 'json'

class Api
  def initialize
    config = YAML.load(File.open(File.expand_path('../../configs/production.yml', __FILE__)))
    @token = config['token']
    @base_url = "#{config['environment']}/"
  end

  def get(url, options = nil)
    RestClient.get("#{@base_url}/#{url}?token=#{@token}&#{options}&pretty=1") { |response| JSON.parse(response) }
  end

  def post(url, body)
    `curl -s -F file=@#{body} -F token=#{@token} #{@base_url}/#{url}`
  end

  def delete(url, options = nil)
    RestClient.delete("#{@base_url}/#{url}?token=#{@token}&#{options}&pretty=1") { |response| JSON.parse(response) }
  end
end
