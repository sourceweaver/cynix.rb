class Environment
    def initialize(record = {}, parent = nil)
        @record = record
        @parent = parent
    end

    # define creates a variable with the given key
    # and value.
    def define(name, value)
        @record[name] = value
        value
    end

    # assign finds the variable with the given key
    # and updates it's value.
    def assign(name, value)
        # puts "DEBUG -> CMD: SET #{name} to #{value}"
        @record[name] = value
        # puts "DEBUG -> VAR #{name} has the value #{@record[name]}"
        value
    end

    def lookup(key)
        resolve(key)
    end

    def resolve(name)
        if @record.key?(name)
            return @record[name]
        elsif @parent.nil?
            raise Exception.new "undefined variable: #{name}"
        end

        @parent.lookup(name)
    end
end
