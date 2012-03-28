unless ::Refinery::Page.by_title("My Page").any?
  my_page = ::Refinery::Page.create(:title => "My Page",
    :deletable => false)
  my_page.parts.create({
      :title => "Body",
      :body => "<p>Number of new emails: $new_emails </p><p>Number of projects: $projects </p>",
      :position => 0
    })
  my_page.parts.create({
      :title => "Side Body",
      :body => "<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus fringilla nisi a elit. Duis ultricies orci ut arcu. Ut ac nibh. Duis blandit rhoncus magna. Pellentesque semper risus ut magna. Etiam pulvinar tellus eget diam. Morbi blandit. Donec pulvinar mauris at ligula. Sed pellentesque, ipsum id congue molestie, lectus risus egestas pede, ac viverra diam lacus ac urna. Aenean elit.</p>",
      :position => 1
    })
end