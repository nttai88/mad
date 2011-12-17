require 'refinerycms-core'

module Refinery
  autoload :ProjectsGenerator, 'generators/refinery/projects_generator'

  module Projects
    require 'refinery/projects/engine' if defined?(Rails)

    class << self
      def table_name_prefix
        'refinery_'
      end

      attr_writer :root

      def root
        @root ||= Pathname.new(File.expand_path('../../../', __FILE__))
      end

      def factory_paths
        @factory_paths ||= [ root.join("spec/factories").to_s ]
      end
    end
  end
end
