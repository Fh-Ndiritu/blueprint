class FilterSchema < RubyLLM::Schema
  boolean :relevant, required: true, description: "Does the user content contain relevant content?"
end

class ProfanityFilter
  def initialize(message)
    @message = message
  end

  def self.perform(*args)
    new(*args).filter
  end

  def filter
    # here we shall filter out jokes
    response = fetch_llm_response
    # profane = response.content.with_indifferent_access[:relevant]
    profane = response.content["relevant"]
    @message.update! profane: !profane
  rescue StandardError => e
    raise "ProfanityFilter failed: #{e.message}"
  end

  private

  def fetch_llm_response
    # we utilize RubyLLM and Gemini API

    chat = RubyLLM.chat
    # response = chat.ask "Some text"
    chat.with_schema(FilterSchema).ask("Your task is to analyze messages posted by users on our platform and ban content that is not related to #{@message.group.title} and
     topics such as #{@message.group.description}.
    Analyze the content for content related to #{@message.group.title} and return true if relevant.
    <user_content>
    #{@message.content} #{@message.parent.content if @message.has_parent?}
    </user_content>
    ")
  rescue StandardError => e
    raise "#{__method__} failed with error: #{e.message}"
  end
end
