require 'rails/generators/migration'
require 'generators/komposer/helpers'

module Komposer
  module Generators
    class BlockGenerator < Rails::Generators::NamedBase
      include Rails::Generators::Migration
      include Komposer::Generators::Helpers

      source_root File.expand_path('../templates', __FILE__)

      argument :attributes, :type => :array, :default => [], :banner => "field:type field:type"
      class_option :locales, :type => :array, :default => %w( en fr ), :desc => "Locales to generate"
      class_option :migration, :type => :boolean, :default => true

      def create_migration_file
        return unless migration?
        migration_template(
          "migrations/migration.rb", 
          "db/migrate/create_#{block_migration_name.underscore}.rb", 
        )
      end

      def create_model_file
        template(
          "models/model.rb.erb",
          File.join("app", "models", block_name_singular + ".rb")
        )
      end

      def create_locale_files
        return unless locales.any?
        locales.each do |locale|
          @locale = locale
          template(
            "locales/#{locale}.yml",
            "config/locales/#{block_name_singular}.#{locale}.yml"
          )
        end
      end

      def create_view_files
        template(
          "views/admin.html.slim",
          File.join("frontend", "components", block_name_singular, "_block_form.html.slim")
        )
        template(
          "views/show.html.slim",
          File.join("frontend", "components", block_name_singular, "_#{block_name_singular}.html.slim")
        )
      end

      def create_js_file
        template(
          "js.erb",
          File.join("frontend", "components", block_name_singular, "#{block_name_singular}.js")
        )
      end

      def create_css_file
        template(
          "css.erb",
          File.join("frontend", "components", block_name_singular, "#{block_name_singular}.css")
        )
      end

      def append_packs
        append_to_file("frontend/components/index.js", "import \"components/#{block_name_singular}/#{block_name_singular}\";\n")
      end

      def self.next_migration_number(dirname)
        if ActiveRecord::Base.timestamped_migrations
          Time.new.utc.strftime('%Y%m%d%H%M%S')
        else
          '%.3d' % (current_migration_number(dirname) + 1)
        end
      end

      private

      def migration?
        options[:migration]
      end

      def locales
        options[:locales]
      end

      def block_name_singular
        name.underscore
      end

      def block_name_plural
        block_name_singular.pluralize
      end

      def block_class_name
        block_name_singular.camelize
      end

      def block_migration_name
        block_name_plural.camelize
      end
    end
  end
end
