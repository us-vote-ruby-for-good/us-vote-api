# remember, folks, it ain't monkeypatching if you're swapping in a parallel adapter
# and that makes everything okay (?)

require 'active_model/serializer/adapter/json_api/fragment_cache'

module ActiveModel
  class Serializer
    class Adapter
      class ActualJsonApi < JsonApi
        def attributes_for_serializer(serializer, options)
          raw    = super
          result = {
            id:   raw.delete(:id),
            type: raw.delete(:type)
          }
          result[:attributes] = raw

          result
        end
      end
    end
  end
end
