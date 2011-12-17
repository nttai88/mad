module Refinery
  module Projects
    class Project < ActiveRecord::Base
      set_table_name :refinery_projects

    
      acts_as_indexed :fields => [:owner_name, :name, :title, :usage, :solves, :idea, :description, :market, :competitors, :strategy, :progression, :finances, :summary, :marked_geographic, :marked_size, :developed, :partners, :suppliers, :distributors, :patenting, :competitors2, :origin]

      validates :owner_name, :presence => true, :uniqueness => true
              
    end
  end
end