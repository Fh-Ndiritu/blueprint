class Message < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates_presence_of :content
  has_ancestry touch: true

  # we can trigger an event on messages that allows us to update a count/cache counter then fire an event when that changes
  # it ensures we don't send events on edit/update events for messages
  after_create_commit :broadcast_update


  # now that changing or creating a message will trigger an event here
  # we can stream updates via action cable

  # this will broadcast all events we send

  def broadcast_update
    # we can update the specific group using the dom_id
    # This is the same syntax used in controllers but now we need to create our own channels
    # we can send to group_id,

    # broadcast_update is fine but broadcast_update_later is recommended to avoid slow execution
    # syntax channel_id, partial, locals, target_to_update
    broadcast_replace_later_to("groups",  target: "group_#{group_id}", partial: "groups/group_preview", locals: { group:  group, current_user: user })

    # Now we also need to update the messages for those watching the channel
    # we are saying render the new message using the partial, then look for an id called messages in the dom and insert it at the end of that element while using the group_id channel to send this
    broadcast_append_later_to("groups", target: "messages", partial: "messages/message", locals: { message: self, current_user: user })
  end
  # message.broadcast_append_later_to("group_#{message.group_id}", partial: "messages/message", locals: { message: , current_user: message.user}, target: "messages")
end
