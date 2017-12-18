module Komposer
  module Block
    extend ActiveSupport::Concern
    class_methods do
      def has_blocks(block_names)
        if block_names.is_a?(Hash)
          names = block_names.values.flatten
        else
          names = block_names
        end

        names.each do |block_name|
          has_many block_name, dependent: :destroy, as: :parent, inverse_of: :parent
          accepts_nested_attributes_for block_name, allow_destroy: true
        end

        define_singleton_method "block_permitted_attributes" do
          names.map do |block_name|
            { "#{block_name}_attributes" => block_name.to_s.singularize.classify.constantize.permitted_attributes }
          end
        end

        define_method "blocks" do
          names.map do |block_name|
            send(block_name)
          end.flatten.sort_by { |block| block.position || 0 }
        end

        define_method "block_names" do
          names
        end

        define_method "block_buttons" do
          if block_names.is_a?(Hash)
            block_names
          else
            names
          end
        end
      end
    end
  end
end
