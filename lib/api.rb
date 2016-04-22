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

  # def post(url, body)
  #   RestClient.post("#{@base_url}#{url}", body, @header) { |response| response }
  # end

  # def put(url, body)
  #   RestClient.put("#{@base_url}#{url}", body, @header) { |response| response }
  # end

  # def delete(url)
  #   RestClient.delete("#{@base_url}#{url}", @header) { |response| response }
  # end

  # def pget(url)
  #   RestClient.get("#{@base_url}#{url}", @header) { |response| [response, JSON.parse(response)] }
  # end

  # def ppost(url, body)
  #   RestClient.post("#{@base_url}#{url}", body, @header) { |response| [response, JSON.parse(response)] }
  # end
end
