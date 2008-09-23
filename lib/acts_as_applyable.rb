module ActiveRecord
  module Acts
    module Applyable
      def self.included(base)
        base.class_eval do
          include ActiveRecord::Acts::Applyable::InstanceMethods
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
          
          # initialize attribute list if empty
          if attribute_list.empty?
            if self.respond_to?(:applyable_fields)
              attribute_list = self.applyable_fields
            else
              Rails.logger.error("\n\n-------\n\nNO APPLYABLE FIELDS FOUND FOR #{self.class.to_s}\n"+
                                 "Define a method called applyable_fields and return the array fields to apply by default\n\n-------\n\n")
            end
          end

          # build attributes hash
          attributes = {}
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