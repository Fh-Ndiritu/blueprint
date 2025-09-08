# https://guides.rubyonrails.org/active_job_basics.html

class ProfanityFilterJob < ApplicationJob
  queue_as :urgent

  # delegate :perform, to: "ProfanityFilter"
  def perform(id)
    # puts "Starting JOB filter verification for message: #{id}"
    # or listen to log file     tail -f log/development.log
    @message = Message.find(id)
    ProfanityFilter.perform(@message)
    if @message.reload.profane?
      remove_from_messages_list
      remove_from_message_count
    end
  end


  private

  def remove_from_messages_list
    @message.broadcast_remove_to("groups", target: "message_#{@message.id}")
  end

  def remove_from_message_count
    @message.broadcast_replace_later_to("groups",
    target: "group_#{@message.group_id}",
    partial: "groups/group_preview",
    locals: { group:  @message.group, current_user: @message.user }
    )
  end
end
