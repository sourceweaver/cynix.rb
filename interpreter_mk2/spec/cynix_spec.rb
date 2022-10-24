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
            it 'it can access the built-in variables' do
                expect(@cynix.evaluate('nil')).to eq(nil)
                expect(@cynix.evaluate('true')).to eq(true)
                expect(@cynix.evaluate('false')).to eq(false)
                expect(@cynix.evaluate('version')).to eq('0.1.0')
            end
        end

        context 'given a string' do
            it 'it evaluates to a string' do
                expect(@cynix.evaluate('"hello"')).to eq('hello')
            end
        end

        context 'given a number' do
            it 'it evaluates to a number' do
                expect(@cynix.evaluate(42)).to eq(42)
            end
        end

        context 'given an addition operator' do
            it 'it performs addition accurately' do
                expect(@cynix.evaluate(['+', 40, 2])).to eq(42)
            end

            it 'it performs nested additions accurately' do
                expect(@cynix.evaluate(['+', ['+', 10, 2], 30])).to eq(42)
            end
        end

        context 'given an subtraction operator' do
            it 'it performs subtraction accurately' do
                expect(@cynix.evaluate(['-', 44, 2])).to eq(42)
            end

            it 'it performs nested subtractions accurately' do
                expect(@cynix.evaluate(['-', ['-', 64, 10], 12])).to eq(42)
            end
        end

        context 'given an multiplication operator' do
            it 'it performs multiplication accurately' do
                expect(@cynix.evaluate(['*', 21, 2])).to eq(42)
            end

            it 'it performs nested multiplications accurately' do
                expect(@cynix.evaluate(['*', ['*', 7, 2], 3])).to eq(42)
            end
        end

        context 'given an division operator' do
            it 'it performs division accurately' do
                expect(@cynix.evaluate(['/', 84, 2])).to eq(42)
            end

            it 'it performs nested divisions accurately' do
                expect(@cynix.evaluate(['/', ['/', 336, 4], 2])).to eq(42)
            end
        end

        context 'given a let expression' do
            it 'it creates a variable and assigns value' do
                expect(@cynix.evaluate(['let', 'x', 42])).to eq(42)
            end
        end

        context 'given a variable' do
            it 'it returns the value of the variable' do
                expect(@cynix.evaluate('x')).to eq(42)
            end

            it 'it returns the values of nested variables' do
                expect(@cynix.evaluate(['let', 'is_user', 'true'])).to eq(true)
                expect(@cynix.evaluate(['let', 'z', ['*', 21, 2]])).to eq(42)
            end
        end
    end
end
