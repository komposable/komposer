require "sass-rails"
require "jquery-rails"
require "bootstrap-sass"
require "sortable/rails"
require "tinymce-rails"
require "tinymce-rails-langs"

module Komposer
  class Engine < Rails::Engine
    ActiveSupport.on_load(:active_record) do
      require 'komposer/block'
      include Komposer::Block
    end
  end
end

require "bootstrap_form"
require "bootstrap_form/form_builder"
require "komposer/block_field"

module BootstrapForm
  class FormBuilder
    include Komposer::BlockField
  end
end
