class Environment
  constructor: (@record = {}) ->

  # define writes to the record
  define: (name, value) ->
    this.record[name] = value
    value

  # lookup attemps to look up a value by it's key
  lookup: (name) ->
    unless name of @record
      throw new ReferenceError('variable #{name} is not defined')
    @record[name]


module.exports = Environment
