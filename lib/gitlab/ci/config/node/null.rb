module Gitlab
  module Ci
    class Config
      module Node
        ##
        # This class represents an undefined and unspecified node.
        #
        # Implements the Null Object pattern.
        #
        class Null < Entry
          def value
            nil
          end

          def valid?
            true
          end

          def errors
            []
          end

          def specified?
            false
          end

          def relevant?
            false
          end
        end
      end
    end
  end
end
