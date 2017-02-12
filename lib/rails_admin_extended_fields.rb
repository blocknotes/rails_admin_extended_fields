require "rails_admin_extended_fields/engine"

module RailsAdminExtendedFields
end

require 'rails_admin/config/fields'
require 'rails_admin/config/fields/base'

RailsAdmin::Config::Fields::Base.class_eval do
  # Load field css classes from model (as hash)
  #
  # # Example:
  # def css_class
  #   @css_class ||= { abstract: 'hide' }
  # end
  register_instance_option :css_class do
    ( defined?( bindings[:object].css_class ) && bindings[:object].css_class[name] ) ? bindings[:object].css_class[name] : "#{name}_field"
  end
end

# module RailsAdmin
#   module Config
#     module Fields
#       module Types
#         class ExtendedFields < RailsAdmin::Config::Fields::Base
#           RailsAdmin::Config::Fields::Types::register(self)
#         end
#       end
#     end
#   end
# end

# RailsAdmin::Config::Fields.register_factory do |parent, properties, fields|
#   if properties[:name] == :extended_fields
#     fields << RailsAdmin::Config::Fields::Types::ExtendedFields.new(parent, properties[:name], properties)
#     true
#   else
#     false
#   end
# end
