module SAXMachine
  class SAXConfig
    
    class ElementConfig
      attr_reader :name, :setter, :data_class, :collection
      
      def initialize(name, options)
        @name = name.to_s
        
        if options.has_key?(:with)
          # for faster comparisons later
          @with = options[:with].to_a.map { |pair| pair.map { |o| o.to_s } }
        else
          @with = nil
        end
        
        if options.has_key?(:value)
          @value = options[:value].to_s
        else
          @value = nil
        end
        
        @as = options[:as]
        @collection = options[:collection]
        
        if @collection
          @setter = "add_#{options[:as]}"
        else
          @setter = "#{@as}="
        end
        @data_class = options[:class]
        @required = options[:required]
      end

      def column
        @as || @name.to_sym
      end

      def required?
        @required
      end

      def value_from_attrs(attrs)
        Hash[attrs][@value]
      end
      
      def attrs_match?(attrs)
        if @with
          @with == (@with & attrs)
        else
          true
        end
      end
      
      def has_value_and_attrs_match?(attrs)
        !@value.nil? && attrs_match?(attrs)
      end
      
      def collection?
        @collection
      end
    end
    
  end
end
