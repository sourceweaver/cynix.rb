require_relative 'spec_helper'

describe Cynix do
    before(:all) do
        env = Environment.new({ 'version' => '0.1.0',
                                'nil' => nil,
                                'true' => true,
                                'false' => false })
        @cynix = Cynix.new(env)
    end

    describe '.evaluate' do
        context 'in the global environment' do
            it 'can access the built-in variables' do
                expect(@cynix.evaluate('nil')).to eq(nil)
                expect(@cynix.evaluate('true')).to eq(true)
                expect(@cynix.evaluate('false')).to eq(false)
                expect(@cynix.evaluate('version')).to eq('0.1.0')
            end
        end

        context 'given a string' do
            it 'evaluates to a string' do
                expect(@cynix.evaluate('"hello"')).to eq('hello')
            end
        end

        context 'given a number' do
            it 'evaluates to a number' do
                expect(@cynix.evaluate(42)).to eq(42)
            end
        end

        context 'given an addition operator' do
            it 'performs addition accurately' do
                expect(@cynix.evaluate(['+', 40, 2])).to eq(42)
            end

            it 'performs nested additions accurately' do
                expect(@cynix.evaluate(['+', ['+', 10, 2], 30])).to eq(42)
            end
        end

        context 'given an subtraction operator' do
            it 'performs subtraction accurately' do
                expect(@cynix.evaluate(['-', 44, 2])).to eq(42)
            end

            it 'performs nested subtractions accurately' do
                expect(@cynix.evaluate(['-', ['-', 64, 10], 12])).to eq(42)
            end
        end

        context 'given an multiplication operator' do
            it 'performs multiplication accurately' do
                expect(@cynix.evaluate(['*', 21, 2])).to eq(42)
            end

            it 'performs nested multiplications accurately' do
                expect(@cynix.evaluate(['*', ['*', 7, 2], 3])).to eq(42)
            end
        end

        context 'given an division operator' do
            it 'performs division accurately' do
                expect(@cynix.evaluate(['/', 84, 2])).to eq(42)
            end

            it 'performs nested divisions accurately' do
                expect(@cynix.evaluate(['/', ['/', 336, 4], 2])).to eq(42)
            end
        end

        context 'given a let expression' do
            it 'creates a variable and assigns value' do
                expect(@cynix.evaluate(['let', 'x', 42])).to eq(42)
            end
        end

        context 'given a variable' do
            it 'returns the value of the variable' do
                expect(@cynix.evaluate('x')).to eq(42)
            end

            it 'returns the values of nested variables' do
                expect(@cynix.evaluate(['let', 'is_user', 'true'])).to eq(true)
                expect(@cynix.evaluate(['let', 'z', ['*', 21, 2]])).to eq(42)
            end
        end

        context 'given an assignment expression' do
            it 'assigns a value to a variable' do
                expect(@cynix.evaluate(['let', 'sample1', 42])).to eq(42)
                expect(@cynix.evaluate(['set', 'sample1', 42])).to eq(42)
            end

            it 'assigns a value to a variable that is defined in the parent scopee' do
                exp = [
                    'begin',
                    ['let', 'sample2', 10],
                    ['begin', ['set', 'sample2', 100]]
                ]
                expect(@cynix.evaluate(exp)).to eq(100)
            end
        end

        context 'given a block expression' do
            it 'creates a block and correctly evaluates in it\'s environment' do
                exp = [
                    'begin',
                    ['let', 'x', 10],
                    ['let', 'y', 20],

                    ['+', ['*', 'x', 'y'], 30]
                ]
                expect(@cynix.evaluate(exp)).to eq(230)
            end

            it 'creates a block and shadows a global variable without overriding it in the global environment' do
                exp = [
                    'begin',
                    ['let', 'x', 42],
                    ['begin',
                     ['let', 'x', 12], 'x'],
                    'x'
                ]
                expect(@cynix.evaluate(exp)).to eq(42)
            end

            it 'creates a block and a nested block and the nested block can lookup a value on the outer block' do
                exp = [
                    'begin',
                    ['let', 'outer', 42],
                    ['let', 'result',
                     ['begin',
                      ['let', 'inner', ['+', 'outer', 10]],
                      'inner']],
                    'result'
                ]
                expect(@cynix.evaluate(exp)).to eq(52)
            end
        end

        context 'given an if expression' do
            it 'evaluates the condition and runs the correct branch' do
                exp = [
                    'begin',
                    ['let', 'if_sample1', 10],
                    ['let', 'if_sample2', 0],
                    ['if', ['>', 'if_sample1', 10],
                     ['set', 'if_sample2', 20],
                     ['set', 'if_sample2', 30]],
                    'if_sample2'
                ]

                expect(@cynix.evaluate(exp)).to eq(30)
            end
        end

        context 'given a while expression' do
            it 'runs the while loop until the condition is evaluated to true' do
                # exp = [
                #     'begin',
                #     ['let', 'while_sample_counter', 0],
                #     ['let', 'while_sample_result', 0],
                #     ['while', ['<', 'while_sample_counter', 10],
                #      ## result++
                #      ## implement ++
                #      ['begin',
                #       ['set', 'while_sample_result', ['+', 'while_sample_result', 1]],
                #       ['set', 'while_sample_counter', ['+', 'while_sample_counter', 1]]
                #      ],
                #     ],
                #      'while_sample_result'
                #     # 'while_sample_result'
                # ]
                exp = [
                    'begin',
                    ['let', 'counter', 0],
                    ['while',
                     ['<', 'counter', 10],
                     ['set', 'counter',
                      ['+', 'counter', 1]]],
                    'counter'
                ]

                expect(@cynix.evaluate(exp)).to eq(10)
            end
        end
    end
end
