require 'spec_helper'

RSpec.describe LoweredExpectations do
  let(:tool) { 'curl' }

  describe '.expect' do
    it 'returns true when the executable exists and the version matches' do
      expect(LoweredExpectations.expect(tool, "~> 7.0")).to be_truthy
    end

    it 'raises an error when the version pattern cannot be found in executable output' do
      expect{LoweredExpectations.expect(tool, "~> 0.1", vpattern: 'notvalid')}.to raise_error
    end

    it 'raises an error when the version of the tool does not meet expectations' do
      expect{LoweredExpectations.expect(tool, "~> 1000.0")}.to raise_error
    end
  end

  describe '.which' do
    it 'returns true when the executable is on the PATH' do
      expect(LoweredExpectations.which tool).to be_truthy
    end

    it 'raises an error when the executable is not on the PATH' do
      expect{LoweredExpectations.which 'sometoolthatdoesnotexist'}.to raise_error(LoweredExpectations::MissingExecutableError)
    end
  end
end
