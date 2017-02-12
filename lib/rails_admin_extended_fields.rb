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

module RailsAdmin::Config::Fields::Types
  class NestedList < RailsAdmin::Config::Fields::Association
    RailsAdmin::Config::Fields::Types::register(self)

    register_instance_option :partial do
      nested_form ? ( accordion ? :nested_accordion : :nested_list ) : :form_filtering_multiselect
    end

    register_instance_option :accordion do
      false
    end

    register_instance_option :sortable do
      false
    end

    register_instance_option :inline_add do
      true
    end

    def method_name
      nested_form ? "#{super}_attributes".to_sym : "#{super.to_s.singularize}_ids".to_sym # name_ids
    end

    # Reader for validation errors of the bound object
    def errors
      bindings[:object].errors[name]
    end
  end

  class NestedOne < RailsAdmin::Config::Fields::Association
    RailsAdmin::Config::Fields::Types::register(self)

    register_instance_option :partial do
      nested_form ? :nested_one : :form_filtering_select
    end

    # Accessor for field's formatted value
    register_instance_option :formatted_value do
      (o = value) && o.send(associated_model_config.object_label_method)
    end

    register_instance_option :inline_add do
      true
    end

    register_instance_option :inline_edit do
      true
    end

    def editable?
      (nested_form || abstract_model.model.new.respond_to?("#{name}_id=")) && super
    end

    def selected_id
      value.try :id
    end

    def method_name
      nested_form ? "#{name}_attributes".to_sym : "#{name}_id".to_sym
    end

    def multiple?
      false
    end
  end
end

# RailsAdmin::Config::Fields.register_factory do |parent, properties, fields|
#   if properties[:name] == :extended_fields
#     fields << RailsAdmin::Config::Fields::Types::ExtendedFields.new(parent, properties[:name], properties)
#     true
#   else
#     false
#   end
# end
