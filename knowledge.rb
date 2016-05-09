class Module
  def attribute(arg, &block)
    value = nil
    variable = if arg.is_a? Hash
                  value = arg.values.first
                  arg.keys.first
               else
                  arg
               end

    puts "variable: #{variable}, value: #{value}"
    puts "block: #{!!block}"

    # instance_variable_set("@#{variable}", value)

    define_method :initialize do
      if block
        puts "fortytwo: #{self.class.instance_methods.grep /forty/}"
        value = instance_eval(&block)
      end
      puts "Initialized with value #{value}"
      instance_variable_set("@#{variable}", value)
    end

    # puts "@#{variable}: #{instance_variable_get("@#{variable}").inspect}"
    # puts "@#{variable} defined?: #{instance_variable_defined?("@#{variable}")}"
    
    define_method "#{variable}" do
      # puts "Inside define_method @#{variable}"
      # puts instance_variable_get("@#{variable}")
      instance_variable_get("@#{variable}")
    end

    define_method "#{variable}=" do |value|
      instance_variable_set("@#{variable}", value)
    end

    define_method "#{variable}?" do
      # instance_variable_defined?("@#{variable}")
      !!send("#{variable}")
    end

    # puts "instance methods: #{instance_methods.sort.grep /^#{variable}[=?]?$/}"
    # puts "@#{variable}: #{self.send("#{variable}")}"
    # puts "@#{variable}?: #{self.send("#{variable}?")}"
    # puts self.inspect
  end
end