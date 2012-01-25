Refinery::NewsItem.class_eval do
  unless defined?(CATEGORIES)
    CATEGORIES = [ "from_madlab", "news", "competitions", "press" ]
  end
end
