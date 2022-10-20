class Cynix
  eval: (exp) ->
    switch
      ###
        self-evaluating expressions
      ###
      when @is_number exp         then exp
      when @is_string exp         then exp.substring(1, exp.length - 1)

      ###
        arithmetic operations
      ###
      when @is_addition exp       then @eval(exp[1]) + @eval(exp[2])
      when @is_subtraction exp    then @eval(exp[1]) - @eval(exp[2])
      when @is_multiplication exp then @eval(exp[1]) * @eval(exp[2])
      when @is_division exp       then @eval(exp[1]) / @eval(exp[2])
      else throw "unimplemented case"

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


module.exports = Cynix
