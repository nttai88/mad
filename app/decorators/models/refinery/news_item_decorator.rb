Refinery::News::Item.class_eval do
  unless defined?(CATEGORIES)
    CATEGORIES = [ "from_madlab", "news", "competitions", "press" ]
  end

  def self.recent(page = 1, per_page = 5)
    self.order("created_at DESC").paginate(:page => page, :per_page => per_page)
  end

end
