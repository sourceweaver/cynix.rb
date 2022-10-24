require_relative 'environment'

class Cynix
    def initialize(global = Environment.new({"version": '0.1.0'}))
        @global = global
    end

    def evaluate(exp, env = @global)
        case
        when number?(exp) then exp
        when string?(exp) then exp[1..-2]

        when addition?(exp) then evaluate(exp[1], env) + evaluate(exp[2], env)
        when subtraction?(exp) then evaluate(exp[1], env) - evaluate(exp[2], env)
        when multiplication?(exp) then evaluate(exp[1], env) * evaluate(exp[2], env)
        when division?(exp) then evaluate(exp[1], env) / evaluate(exp[2], env)

        # variables:
        # let/set/read:
        when let?(exp)
            _, name, value = exp
            env.define(name, evaluate(value, env))

        when variable_name?(exp) then env.lookup(exp)

        else puts 'unimplemented'
        end
    end

    private

    def number?(exp)
        exp.is_a?(Integer)
    end

    def string?(exp)
        exp.is_a?(String) and exp[0] == '"' and exp[-1] == '"'
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

    def let?(exp)
        exp[0] == 'let'
    end

    def variable_name?(exp)
        accepted_pattern = /^[a-zA-Z][a-zA-Z0-9_]*$/
        exp.is_a?(String) and exp.match?(accepted_pattern)
    end
end
