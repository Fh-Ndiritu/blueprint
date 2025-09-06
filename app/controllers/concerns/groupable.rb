# frozen_string_literal: true

module Groupable
  extend ActiveSupport::Concern

  def fetch_groups
    @your_groups = current_user.groups
    @other_groups = Group.excluding(@your_groups)
  end
end
