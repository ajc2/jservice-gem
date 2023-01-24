# -*- coding: utf-8 -*-
# frozen_string_literal: true

require 'json'
require 'net/http'

require_relative "jservice/version"

class Jservice
  class Error < StandardError; end

  def initialize(**config)
    @config = {
      # base URL of API
      url: 'jservice.io',
      # length of one "page" for pagination
      # a maximum of 100 is allowed
      page_length: 100,
      # use https
      use_ssl: true,
      # port to use for API (`nil` for default)
      port: nil,
      # ignore clues above the given invalid_count (`nil` ignored)
      invalid_filter: nil
    }
    @config.merge!(config)
    @config[:port] ||= @config[:use_ssl] ? 443 : 80

    @http = Net::HTTP.new(@config[:url], @config[:port])
    @http.use_ssl = @config[:use_ssl]
    @http.start()
  end

  # request a page of clues
  # = options =
  #    value ( int): the value of the clue in dollars
  # category ( int): the id of the category you want to return
  # min_date (date): earliest date to show, based on original air date
  # max_date (date): latest date to show, based on original air date
  #   offset ( int): offsets the returned clues. Useful in pagination
  #     page ( int): get page n of clues, based on page_length
  def clues(**options)
    # validate input
    filter_keys(options, :value, :category, :min_date, :max_date, :offset, :page)
    
    result = nil
    begin
      result = api_request('clues', options)
    rescue ex
      raise ex
    else
      return result
    end
  end
  
  # request random clues
  def random_clues(count = 1)
    result = nil
    begin
      result = api_request('random', count: count)
    rescue ex
      raise ex
    else
      return result
    end
  end
  
  # request random final jeopardy clues
  def random_finals(count = 1)
    result = nil
    begin
      result = api_request('final', count: count)
    rescue ex
      raise ex
    else
      return result
    end
  end
  
  # request a list/page of categories
  # = options =
  #  count (int): amount of categories to return, limited to 100 at a time
  # offset (int): offsets the starting id of categories returned. Useful in pagination.
  def categories(**options)
    # validate input
    filter_keys(options, :count, :offset)
    
    result = nil
    begin
      result = api_request('categories', options)
    rescue ex
      raise ex
    else
      return result
    end
  end
  
  # request a specific category
  def category(id)
    result = nil
    begin
      result = api_request('category', id: id)
    rescue ex
      raise ex
    else
      return result
    end
  end
  

  private def filter_keys(options, *keys)
    bad_keys = options.except(*keys).keys
    unless bad_keys.empty?
      # build error message
      msg = "Unrecognized options: #{bad_keys.join(', ')}"
      raise Jservice::Error.new(msg)
    end
  end
  
  private def api_request(endpoint, options)
    uri_hash = {
      host: @config[:url],
      path: "/api/#{endpoint}",
      port: @config[:port],
      query: URI.encode_www_form(options)
    }
    uri = nil
    if @config[:use_ssl]
      uri = URI::HTTPS.build(uri_hash)
    else
      uri = URI::HTTP.build(uri_hash)
    end
    
    req = @http.get(uri)
  
    unless req.code == '200'
      raise Jservice::Error.new("HTTP response #{req.code}")
    end
    
    JSON.parse(req.body)
  end
end
