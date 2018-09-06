require 'spec_helper'

RSpec.describe LoweredExpectations do
  let(:tool) { 'curl' }

  describe '.expect' do
    it 'returns true when the executable exists and the version matches' do
      expect(LoweredExpectations.expect(tool, "~> 7.0")).to be_truthy
    end

    it 'raises an error when the version pattern cannot be found in executable output' do
      expect{LoweredExpectations.expect(tool, "~> 0.1", vpattern: 'notvalid')}.to raise_error(LoweredExpectations::VersionPatternError)
    end

    it 'raises an error when the version of the tool does not meet expectations' do
      expect{LoweredExpectations.expect(tool, "~> 1000.0")}.to raise_error(LoweredExpectations::IncompatibleVersionError)
    end
  end

  describe '.which' do
    it 'returns true when the executable is on the PATH' do
      expect(LoweredExpectations.which(tool)).to be_truthy
    end

    it 'raises an error when the executable is not on the PATH' do
      expect{LoweredExpectations.which 'sometoolthatdoesnotexist'}.to raise_error(LoweredExpectations::MissingExecutableError)
    end
  end

  describe '.run!' do
    let(:tool_path) { LoweredExpectations.which(tool) }
    let(:tool_output) { `#{tool_path} --version` }
    it 'returns stdout' do
      expect(LoweredExpectations.send('run!', tool, '--version').delete("\r")).to eq tool_output
    end

    it 'returns stdout in quiet mode' do
      expect(LoweredExpectations.send('run!', tool, '--version', quiet: true).delete("\r")).to eq tool_output
    end

    it 'raises an error when the executable returns non-zero' do
      expect{LoweredExpectations.send('run!', tool, '--versssion')}
        .to raise_error(LoweredExpectations::CommandExecutionError)
    end

    it 'raises an error when the executable returns non-zero in quiet mode' do
      expect{LoweredExpectations.send('run!', tool, '--versssion', quiet: true)}
        .to raise_error(LoweredExpectations::CommandExecutionError)
    end
  end
end
