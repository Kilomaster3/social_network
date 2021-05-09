# frozen_string_literal: true

module PostsHelper
  def status_for(post)
    return unless post.published_at?

    if post.published_at > Time.zone.now
      'Publish via'
    else
      'Publish write now'
    end
  end
end
