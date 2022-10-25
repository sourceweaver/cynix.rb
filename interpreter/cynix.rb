require_relative 'environment'

class Cynix
    def initialize(global = Environment.new)
        @global = global
    end

    def evaluate(exp, env = @global)
        case
        # Literals:
        when number?(exp) then exp
        when string?(exp) then exp[1..-2]

        # Arithmetic Ops:
        when addition?(exp)       then evaluate(exp[1], env) + evaluate(exp[2], env)
        when subtraction?(exp)    then evaluate(exp[1], env) - evaluate(exp[2], env)
        when multiplication?(exp) then evaluate(exp[1], env) * evaluate(exp[2], env)
        when division?(exp)       then evaluate(exp[1], env) / evaluate(exp[2], env)

        # Variables:
        # let assigns a value to name
        when let?(exp)
            _, name, value = exp
            env.define(name, evaluate(value, env))

        when set?(exp)
            _, name, value = exp
            env.assign(name, evaluate(value, env))

        # variable_name reads a value
        when variable_name?(exp) then env.lookup(exp)

        # Block:
        when block?(exp)
            # A block creates a new Environment:
            # 1. It sets it's environment to an empty hash
            # 2. It sets it's parent environment to the global environment.
            block_env = Environment.new({}, env)
            evaluate_block(exp, block_env)

        else puts 'unimplemented'
        end
    end

    private

    def number?(exp)
        exp.is_a?(Integer)
    end

    def string?(exp)
        exp.is_a?(String) && exp[0] == '"' && exp[-1] == '"'
    end

    def addition?(exp)
        exp[0] == '+'
    end

    def subtraction?(exp)
        exp[0] == '-'
    end

    def multiplication?(exp)
        exp[0] == '*'
    end

    def division?(exp)
        exp[0] == '/'
    end

    def block?(exp)
        exp[0] = 'begin'
    end

    def let?(exp)
        exp[0] == 'let'
    end

    def set?(exp)
        exp[0] == 'set'
    end

    def variable_name?(exp)
        accepted_pattern = /^[a-zA-Z][a-zA-Z0-9_]*$/
        exp.is_a?(String) && exp.match?(accepted_pattern)
    end

    def evaluate_block(block, env)
        _tag, *expressions = block

        result = nil

        expressions.each do |exp|
            result = evaluate(exp, env)
        end
        result
    end
end
