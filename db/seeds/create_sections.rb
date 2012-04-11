en_titles = ["Business Idea", "Product Description", "Summary", "Market Analysis", "Competitors Analysis", "Strategy", "Progression Plan", "Finances"]
nb_titles = ["Forretningside", "Produktbeskrivelse", "Sammendrag", "Markedsanalyse", "Konkurrentanalyse", "Strategi", "Progresjonsplan", "Finanser"]
if SectionType.limit(10).count > 0
  for i in 0..(nb_titles.size-1)
    I18n.locale = :en
    section = HtmlSectionType.new(:title => en_titles[i])
    section.save
    I18n.locale = :nb
    section.title = nb_titles[i]
    section.save
  end
end