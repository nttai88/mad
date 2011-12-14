Messaging::Message.class_eval do
  
  def recipients=(string='')
    @recipient_list = []
    string.split(',').each do |s|
      unless s.blank?
        recipient = Refinery::User.find_by_email(s.strip)
        @recipient_list << recipient if recipient
      end
    end
  end
end
