Mailboxer.setup do |config|
  
  #Configures if you applications uses or no the email sending for Notifications and Messages
  config.uses_emails = true
  
  #Configures the default from for the email sent for Messages and Notifications of Mailboxer
  config.default_from = "no-reply@mailboxer.com"
  
  #Configures the methods needed by mailboxer
  #config.email_method = :mailboxer_email
  #config.name_method = :name

  config.search_enabled = true
end
