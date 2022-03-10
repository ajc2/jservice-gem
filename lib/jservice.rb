# -*- coding: utf-8 -*-
# frozen_string_literal: true

require 'json'
require 'net/http'

require_relative "jservice/version"

module Jservice
  class Error < StandardError; end

  def initialize(**config)
    @config = {
      # base URL of API
      url: 'jservice.io',
      # length of one "page" for `clues` pagination
      # a maximum of 100 is allowed
      page_length: 100,
      # use https
      use_ssl: true,
      # port to use for API (`nil` for default)
      port: nil,
      # ignore clues above the give invalid_count (`nil` ignored)
      invalid_filter: nil
    }
    @config.merge!(config)

    @http = Net::HTTP.new(@config[:url], @config[:port])
  end
end
