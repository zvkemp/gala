json.(comment_thread, *%i(id card_id block_index start length
                          original_highlight_text))
json.comment_ids comment_thread.comments.map(&:id)