Refinery::Page.class_eval do
  def self.my_page_url
    title = (I18n.locale == :en ? "My Page" : "Min Side")
    my_page = self.by_title(title).first
    my_page.url
  end
end
