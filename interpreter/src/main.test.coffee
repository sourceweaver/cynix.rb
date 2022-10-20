Cynix = require './main'

cyn = null

beforeAll ->
  cyn = new Cynix

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
