module ActiveRecord
  module Acts
    module Applyable
      def self.included(base)
        base.extend ClassMethods
        base.class_eval do
          include ActiveRecord::Acts::Applyable::InstanceMethods
        end
      end
      
      module ClassMethods
        def acts_as_applyable(*accessible_attributes)
          cattr_accessor :accessible_attribute_list
          self.accessible_attribute_list = accessible_attributes
        end
      end
      
      module InstanceMethods
        def params
          @params ||= {}
          @params
        end
        
        def params=(new_params)
          @params = new_params
        end
        
        def apply_set_attributes(*attribute_list)
          self.params.stringify_keys!
          @@accessible_attribute_list ||= []
          
          # build attributes hash
          attributes = {}
          attribute_list = @@accessible_attribute_list if attribute_list.empty?
          attribute_list.each do |attribute|
            attributes[attribute] = self.params[attribute.to_s]
          end
          
          # set attributes, ignoring protected
          send :attributes=, attributes, false
        end
        
        def apply(*attributes)
          apply_set_attributes(*attributes)
          save
        end
        
        def apply!(*attributes)
          apply_set_attributes(*attributes)
          save!
        end
        
        # alias for save
        def apply_all
          self.attributes = params
          save
        end
        
        # alias for save!
        def apply_all!
          self.attributes = params
          save!
        end
        
      end
    end
  end
end