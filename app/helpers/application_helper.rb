module ApplicationHelper
  def new_notification(account, notice_id, notice_type)
    account.notifications.build(notice_id: notice_id, notice_type: notice_type)
    account.notice_seen = false
    account.save
    account
  end

  def notification_find(notice, type)
    Account.find(notice.notice_id) if type == 'friendRequest'

    search_notification(notice.id, type)

    return unless type == 'like-comment'

    search_comment(notice)
  end

  def search_notification(notice_id, type)
    Post.find(notice_id) if type == 'comment' || 'like-post'
  end

  def search_comment(notice)
    # Сделать в один запрос
    comment = Comment.find(notice.notice_id)
    Post.find(comment.post_id)
  end
end
