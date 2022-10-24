class Environment
    def initialize(record = {})
        @record = record
    end

    def define(key, value)
        @record[key] = value
        value
    end

    def lookup(key)
        raise Exception.new "undefined variable: #{key}" unless @record.key?(key)

        @record[key]
    end
end
