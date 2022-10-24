describe Environment do
    before(:all) do
        @environment = Environment.new({ 'version' => '1.0.0' })
    end

    describe '.define' do
        context 'given a key/value' do
            it 'it evaluates to the value' do
                expect(@environment.define('age', 42)).to eq(42)
            end
        end
    end

    describe '.lookup' do
        context 'within the environment' do
            it 'it retrieves the value of a built-in variable' do
                expect(@environment.lookup('version')).to eq('1.0.0')
            end
        end

        context 'given a key' do
            it 'it retrieves the value if key exists' do
                expect(@environment.lookup('age')).to eq(42)
            end

            it 'it raises an exception if key does not exist' do
                undefined_key = 'something'
                exception_msg = "undefined variable: #{undefined_key}"
                expect { @environment.lookup(undefined_key) }.to raise_error(exception_msg)
            end
        end
    end
end
