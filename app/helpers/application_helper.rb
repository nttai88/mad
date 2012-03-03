module ApplicationHelper
  def states_by_country
    state_options = {}
    Carmen::country_codes.each do |country|
      states = Carmen::states(country) rescue []
      state_options[country] = options_for_select(states)
    end
    javascript_tag("var states = #{state_options.to_json}")
  end

  def has_state?(country_code)
    begin
      Carmen::states(country_code)
      return true
    rescue
      return false
    end
  end
  
  def nice_time time
    time.strftime("%b %d, %Y at %l:%m %p")
  end

  #for language selector we need same url but have a different query string for locale
  # 'url_for :locale => :en'  can do this for us, but issue is that some refinery url will break here
  # for example 'users/register' maps to 'users/new'  which will break at 'url_for' as refinery  there will be no route for
  # :action=> new & :controller =>'users'
  def current_url_with_params(*args)
    args_params = args.extract_options!
    query_params = HashWithIndifferentAccess.new
    if request.query_string.present?
      request.query_string.split('&').each do |k|
        map = k.split '='
        query_params[map[0].to_s] = map[1]
      end
    end
    
    query_params.merge! args_params
    
    url = url_for query_params rescue nil
    unless url
      query_string = query_params.keys.map{|k| "#{k}=#{query_params[k]}"}.join '&'
      url = request.path+"?#{query_string}"
    end
    url.html_safe
  end
  
end
