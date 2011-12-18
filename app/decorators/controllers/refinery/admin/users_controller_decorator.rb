module Refinery
  module Admin
    UsersController.class_eval do
      after_filter :after_update, :only => :update
      def edit
        @user = User.find params[:id]
        @selected_plugin_names = @user.plugins.collect{|p| p.name}
        @profile = @user.profile
        @categories = @profile.categories
        @regions = @profile.regions
      end

      protected
      def after_update
        profile = @user.profile
        categories = []
        params[:categories].each do |cat|
          unless cat["id"].blank?
            category = Category.find(cat["id"])
            category.expired_date = cat["expired_date"]
            categories << category
          end
        end
        profile.categories = categories
        regions = []
        params[:regions].each do |reg|
          region = Region.find_by_country_and_state(reg["country"], (reg["state"] || ""))
          if region
            regions << region
            region.expired_date = reg["expired_date"]
          end
        end if params[:regions]
        profile.regions = regions
        profile.save

        categories.each do |category|
          selection = profile.selection_of(category)
          selection.expired_date = category.expired_date
          selection.save
        end
        regions.each do |region|
          selection = profile.selection_of(region)
          selection.expired_date = region.expired_date
          selection.save
        end
        
      end
      
    end
  end
end
