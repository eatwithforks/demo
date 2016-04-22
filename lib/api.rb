# encoding: utf-8
require 'rest_client'
require 'yaml'

class Api
  def initialize
    config = YAML.load(File.open(File.expand_path('../../configs/production.yml', __FILE__)))
    @token = config['token']
    @base_url = "#{config['environment']}/"
  end

  def get(url)
    RestClient.get("#{@base_url}/#{url}?token=#{@token}&pretty=1") { |response| response }
  end

  def post(url, body)
    system("curl -F file=@#{body} -F token=#{@token} #{@base_url}/#{url}")
  end

  def delete(url, options)
    RestClient.delete("#{@base_url}/#{url}?token=#{@token}&#{options}&pretty=1") { |response| response }
  end
end
