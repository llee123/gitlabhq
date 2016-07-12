module Gitlab
  module Ci
    class Config
      module Node
        ##
        # Factory class responsible for fabricating node entry objects.
        #
        class Factory
          class InvalidFactory < StandardError; end

          def initialize(node)
            @node = node
            @attributes = {}
          end

          def value(value)
            @value = value
            self
          end

          def parent(parent)
            @parent = parent
            self
          end

          def with(attributes)
            @attributes.merge!(attributes)
            self
          end

          def create!
            raise InvalidFactory unless defined?(@value)
            raise InvalidFactory unless defined?(@parent)

            attributes = { parent: @parent, global: @parent.global }
            attributes.merge!(@attributes)

            ##
            # We assume that unspecified entry is undefined.
            # See issue #18775.
            #
            if @value.nil?
              Node::Undefined.new(fabricate_undefined(attributes))
            else
              @node.new(@value, attributes)
            end
          end

          private

          def fabricate_undefined(attributes)
            if @node.default.nil?
              Node::Null.new(nil, attributes)
            else
              @node.new(@node.default, attributes)
            end
          end
        end
      end
    end
  end
end
