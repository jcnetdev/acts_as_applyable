require 'acts_as_applyable'

ActiveRecord::Base.send :include, ActiveRecord::Acts::Applyable
