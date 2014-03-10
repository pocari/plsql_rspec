require 'singleton'

class ConfigHelper
  include Singleton
  def initialize
    @config = YAML.load_file("../config/config.yaml")
  end
  
  def [](keys)
    keys.inject(nil) do |acc, key|
      if acc
        acc = acc[key.to_s]
      else
        acc = @config[key.to_s]
      end
      acc
    end
  end
  
  class << self
    def [](*keys)
      instance[keys]
    end
  end
end
