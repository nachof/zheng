module Ratings
  module Util

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def sequel_accessor *params
        params.each do |method|
          class_eval <<-end_eval
            def #{method.to_s}
              @values[:#{method.to_s}]
            end
            def #{method.to_s}= v
              @values[:#{method.to_s}] = v
            end
          end_eval
        end
      end
    end

  end
end
