module ValidateOptions
  module Spec
    module Matchers
      class ValidateOptionsMatcher #:nodoc:
        def initialize(accepted_options)
          @accepted_options = accepted_options
        end

        def matches?(target)
          accepted = @accepted_options.all? do |opt|
            begin
              target.call(opt => nil)
              true
            rescue ArgumentError
              false
            end
          end
          
          rejected = begin
                       target.call("___very_odd_probably_invalid_key" => nil)
                       false
                     rescue ArgumentError
                       true
                     end
          
          accepted && rejected
        end

        def failure_message
          "expected block to validate options."
        end
      end
      
      # :call-seq:
      #   should validate_options(:color)
      #
      # == Examples
      #
      #   lambda {|options| Formatter.text('Hello', options) }.should validate_options(:color)
      def validate_options(*accepted_options)
        ValidateOptionsMatcher.new(accepted_options)
      end
    end
  end
end
