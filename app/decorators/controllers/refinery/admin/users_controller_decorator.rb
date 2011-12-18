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
        categories = Category.find(params[:topic_ids].delete_if{|x| x.blank?})
        profile.categories = categories
        regions = []
        params[:regions].each do |reg|
          region = Region.find_by_country_and_state(reg["country"], (reg["state"] || ""))
          regions << region if region
        end if params[:regions]
        profile.regions = regions
        profile.save
      end
    end
  end
end
