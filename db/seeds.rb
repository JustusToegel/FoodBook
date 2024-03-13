require 'faker'
require 'net/http'
require 'json'
require 'nokogiri'
require 'open-uri'

case Rails.env
when 'development'
  require_relative 'seeds_development'
when 'production'
  require_relative 'seeds_production'
end
