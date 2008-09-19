module ValidateOptions
  def self.disable!
    undef_method :validate_options if method_defined?(:validate_options)

    def validate_options(hash, *keys)
      # no-op
    end
  end

  def self.enable!
    undef_method :validate_options if method_defined?(:validate_options)

    def validate_options(hash, *keys)
      return unless hash
      extra = hash.keys - keys
      raise ArgumentError, "Invalid options provided: #{extra.map {|k| k.inspect }.join(', ')}." unless extra.empty?

      if block_given?
        begin
          yield(hash)
        rescue ArgumentError
          raise
        rescue Exception => e
          raise ArgumentError, e
        end
      end
    end
  end

  def self.included(base)
    base.class_eval <<-EOS
    def validate_options_for(method, *args)
      alias_method "\#{method}_without_options_validation".to_sym, method

      module_eval <<-EOIS
        def \#{method}(*args)
          validate_options(args.last, *\#{args.inspect})
          \#{method}_without_options_validation(*args)
        end
      EOIS
    end
    EOS
  end

  # Disable by default.
  disable!
end

Object.send(:include, ValidateOptions)
