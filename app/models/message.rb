class Message < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates_presence_of :content
  has_ancestry touch: true

  # we can trigger an event on messages that allows us to update a count/cache counter then fire an event when that changes
  # it ensures we don't send events on edit/update events for messages
  # after_save_commit :broadcast_update

  # run filter only on content change to prevent infinite loops
  after_create_commit :insert_message
  after_save_commit :filter_profanity, if: :saved_change_to_content?
  # after_save_commit :remove_message, if: :saved_change_to_profane?


  # we add a validated scope here
  # we could apply this as a default scope but it's shrunned upon due to complexities in maintenance

  scope :validated, -> { where(profane: false) }

  private


  # https://guides.rubyonrails.org/action_cable_overview.html#rebroadcasting-a-message
  # now that changing or creating a message will trigger an event here
  # we can stream updates via action cable
  # this will broadcast all events we send
  def insert_message
    # we can update the specific group using the dom_id
    # This is the same syntax used in controllers but now we need to create our own channels
    # we can send to group_id,

    # broadcast_update is fine but broadcast_update_later is recommended to avoid slow execution
    # syntax channel_id, target_to_update,  partial, locals
    broadcast_replace_later_to("groups",  target: "group_#{group_id}", partial: "groups/group_preview", locals: { group:  group, current_user: user })

    # Now we also need to update the messages for those watching the channel
    # we are saying render the new message using the partial, then look for an id called messages in the dom and insert it at the end of that element while using the group_id channel to send this
    broadcast_append_later_to("groups", target: "messages", partial: "messages/message", locals: { message: self, current_user: user })
  end


  def filter_profanity
    # ProfanityFilter.perform_later(id)

    # This job is fast, we need to delay it a bit
    ProfanityFilterJob.set(wait: 1.seconds).perform_later(id)

    #this will block execution
    # ProfanityFilterJob.perform_now(id)
  end

  def remove_message
    # we need to reduce message count
    # and remove message from display
    broadcast_replace_later_to("groups",  target: "group_#{group_id}", partial: "groups/group_preview", locals: { group:  group, current_user: user })
    broadcast_remove_to("groups", target: "messages_#{id}")
  end
end
