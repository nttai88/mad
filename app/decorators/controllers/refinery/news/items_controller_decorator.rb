Refinery::News::ItemsController.class_eval do
  def index
    if (category = params[:category]).present?
      @items = Refinery::News::Item.where(:category => category).paginate(:page => params[:page])
    end
  end
end
