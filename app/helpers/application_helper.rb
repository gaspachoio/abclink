module ApplicationHelper
  def application_name
    'ABClink'
  end
  def application_title
    'ABClink'
  end

  def bold_search_words(snippet, words)
    snippet.split.collect { |w|
      words.include?(w.downcase.delete('.()",')) ? "<b>#{w}</b>" : w
    }.join(' ').html_safe
  end
end
