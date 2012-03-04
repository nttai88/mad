module Mailboxer 
  module Models
    autoload :Messageable, 'mailboxer/models/messageable'
  end  
  
  mattr_accessor :default_from
  mattr_accessor :uses_emails
  mattr_accessor :search_enabled
  mattr_accessor :email_method
  @@email_method = :mailboxer_email
  mattr_accessor :name_method
  @@name_method = :name
  
   class << self
    def setup
      yield self
    end
   end
   
end
# reopen ActiveRecord and include all the above to make
# them available to all our models if they want it
require 'mailboxer/engine' 
