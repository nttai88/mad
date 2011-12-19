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
            categories << category
          end
        end
        profile.categories = categories
        regions = []
        params[:regions].each do |reg|
          region = Region.find_by_country_and_state(reg["country"], (reg["state"] || ""))
          regions << region if region
        end if params[:regions]
        profile.regions = regions
        profile.save
        value = params[:expired_date].blank? ? "null":"'#{params[:expired_date]}'"
        CategorySelection.update_all("expired_date= #{value}", "parent_id = #{profile.id} and parent_type = 'Profile'")
        RegionSelection.update_all("expired_date=#{value}", "parent_id = #{profile.id} and parent_type = 'Profile'")
      end
      
    end
  end
end
