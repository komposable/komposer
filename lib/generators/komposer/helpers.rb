require 'rails/generators/active_record/migration'

module Komposer
  module Generators
    module Helpers
      private

      def migration_class_name
        if Rails::VERSION::MAJOR >= 5
          "ActiveRecord::Migration[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]"
        else
          'ActiveRecord::Migration'
        end
      end

      def model_class_name
        if Rails::VERSION::MAJOR >= 5
          "ApplicationRecord"
        else
          "ActiveRecord::Base"
        end
      end
    end
  end
end
