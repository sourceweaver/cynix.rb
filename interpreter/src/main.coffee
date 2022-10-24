Environment = require './environment'

class Cynix
  # Cynix needs an `Environment` to get going, if it's not supplied
  # we'll create one and store it in the @global ivar.
  constructor: (@global = new Environment) ->

  # eval accepts an expression and environment, if the environment
  # is not supplied, we'll use the one that already exists.
  eval: (exp, env = @global) ->
    switch
      ###
        self-evaluating expressions:
      ###
      when @is_number exp         then exp
      when @is_string exp         then exp.substring(1, exp.length - 1)

      ###
        arithmetic operations:
      ###
      when @is_addition exp       then @eval(exp[1]) + @eval(exp[2])
      when @is_subtraction exp    then @eval(exp[1]) - @eval(exp[2])
      when @is_multiplication exp then @eval(exp[1]) * @eval(exp[2])
      when @is_division exp       then @eval(exp[1]) / @eval(exp[2])

      ###
        assign/read/set variables:
      ###
      when @is_let exp
        [_, name, value] = exp
        env.define(name, @eval(value))
      when @is_variable_name exp then env.lookup(exp)

      ###
        block:
      ###
      when @is_block exp then @eval_block(exp, env)

      ###
        not implemented:
      ###
      else throw "unimplemented case #{JSON.stringify(exp)}"

  eval_block: (block, env) ->
    [tag, ...expressions] = block

    result = null
    for exp in expressions
      result = @eval(exp, env)

    result



  is_number: (exp) ->
    typeof exp == 'number'

  is_string: (exp) ->
    typeof exp == 'string' and exp[0] == '"' and exp[exp.length - 1] == '"'

  is_addition: (exp) ->
    exp[0] == '+'

  is_subtraction: (exp) ->
    exp[0] == '-'

  is_multiplication: (exp) ->
    exp[0] == '*'

  is_division: (exp) ->
    exp[0] == '/'

  is_let: (exp) ->
    exp[0] == 'let'

  # TODO: fix regex
  is_variable_name: (exp) ->
    typeof exp == 'string'
    # and /^[a-zA-Z] [a-zA-Z0-9_]*$/.test(exp)

  is_block: (exp) ->
    exp[0] == 'begin'


module.exports = Cynix
