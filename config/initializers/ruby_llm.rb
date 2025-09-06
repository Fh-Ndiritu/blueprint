# config/initializers/ruby_llm.rb (in Rails) or at the start of your script
require "ruby_llm"

RubyLLM.configure do |config|
  config.default_model ='gemini-2.5-flash'
  config.gemini_api_key = Rails.application.credentials.gemini_api_key
end
