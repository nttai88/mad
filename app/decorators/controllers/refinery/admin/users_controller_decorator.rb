module Refinery
  module Admin
    UsersController.class_eval do
      after_filter :after_update, :only => :update
      
      def index
        if !params[:role] || params[:role] == "All"
          condition = {}
        else
          condition = {"refinery_roles.title" => params[:role]}
        end
        page = params[:page] || 1
        @users = Refinery::User.joins(:roles).where(condition).order("username").paginate(:page => page, :per_page => 20)
      end

      def edit
        @user = User.find params[:id]
        @selected_plugin_names = @user.plugins.collect{|p| p.name}
        @profile = @user.profile
        if @profile
          @categories = @profile.categories
          @regions = @profile.regions
        end
      end

      protected
      def after_update
        if @user.is_partner?
          update_for_partners
        end

        if @user.has_role?("AdvisorRequest")
          approve
        end
      end

      def approve
        role = Refinery::Role.find_by_title("Advisor")
        @user.roles = [role]
        @user.save
      end

      def update_for_partners
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
