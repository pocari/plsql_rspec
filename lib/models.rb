require 'composite_primary_keys'

def define_model(table_name, keys)
  model_class = Class.new(ActiveRecord::Base)
  model_class.module_eval do
    self.table_name = table_name.downcase.to_s
    if keys.size == 1
      self.primary_key = keys[0]
    else
      self.primary_keys = *keys
    end
  end
  Object.const_set(table_name.to_s, model_class)
end

define_model :Test_2, [:key1]
define_model :Test_3, [:key1, :key2]
