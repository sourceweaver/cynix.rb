Cynix = require './main'
Environment = require './environment'

cyn = null

beforeAll ->
  # Fire up an environment with built-ins
  env = new Environment({
    nil: null,
    true: true,
    false: false,
    VERSION: '0.1.0'
   })
  cyn = new Cynix(env)

it 'evaluates a number to itself', ->
  expect(cyn.eval(1)).toBe(1)

it 'evaluates a string to itself', ->
  expect(cyn.eval('"hello"')).toBe("hello")

it 'performs nested additions correctly', ->
  expect(cyn.eval(['+', ['+', 10, 2], 30])).toBe(42)

it 'performs nested substractions correctly', ->
  expect(cyn.eval(['-', ['-', 64, 10], 12])).toBe(42)

it 'performs nested multiplications correctly', ->
  expect(cyn.eval(['*', ['*', 7, 2], 3])).toBe(42)

it 'performs nested divisions correctly', ->
  expect(cyn.eval(['/', ['/', 336, 4], 2])).toBe(42)

it 'creates a variable', ->
  expect(cyn.eval(['let', 'x', 42])).toBe(42)

it 'reads the value of a variable', ->
  expect(cyn.eval('x')).toBe(42)

it 'reads the value of a variable in a nested expression', ->
  expect(cyn.eval(['let', 'is_user', 'true'])).toBe(true)

it 'can read the values of built-in variables', ->
  expect(cyn.eval('nil')).toBe(null)
  expect(cyn.eval('true')).toBe(true)
  expect(cyn.eval('false')).toBe(false)
  expect(cyn.eval('VERSION')).toBe('0.1.0')
