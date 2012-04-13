I18n.locale = :en
unless ::Refinery::Page.by_title("My Page").any?
  my_page = ::Refinery::Page.create(:title => "My Page", :show_in_menu => false)
  page_part = my_page.parts.create({
      :title => "Body",
      :body => "<p>Number of new emails: $new_emails </p><p>Number of projects: $projects </p>",
      :position => 0
    })
  I18n.locale = :nb
  my_page.title = "Min Side"
  my_page.save
  page_part.title = "Body"
  page_part.body = "<p>Antall nye eposter: $new_emails </p><p>Antall prosjekter: $projects </p>"
  page_part.save
end