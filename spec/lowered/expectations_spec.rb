require 'spec_helper'

RSpec.describe LoweredExpectations do
  let(:tool) { 'curl' }
  let(:version) { '0.1.2' }
  let(:curl_version) do
'curl 0.1.2 (x86_64-apple-darwin13.0) libcurl/7.30.0 SecureTransport zlib/1.2.5
Protocols: dict file ftp ftps gopher http https imap imaps ldap ldaps pop3 pop3s rtsp smtp smtps telnet tftp
Features: AsynchDNS GSS-Negotiate IPv6 Largefile NTLM NTLM_WB SSL lib'
  end

  describe '.expect' do
    it 'returns true when the executable exists and the version matches' do
      expect(LoweredExpectations).to receive(:which).once.with(tool).and_return(tool)
      expect(LoweredExpectations).to receive(:run!).once.and_return(curl_version)
      expect(LoweredExpectations).to receive(:verify_version).once.with(version, '~> 0.1').and_return(true)
      expect(LoweredExpectations.expect(tool, '~> 0.1')).to be_truthy
    end

    it 'raises an error when the executable does not exist' do
      expect(LoweredExpectations).to receive(:which).once.with(tool).and_raise(LoweredExpectations::MissingExecutableError)
      expect { LoweredExpectations.expect(tool, '~> 0.1') }.to raise_error(LoweredExpectations::MissingExecutableError)
    end

    it 'raises an error when the version cannot be extracted from executable' do
      expect(LoweredExpectations).to receive(:which).once.with(tool).and_return(tool)
      expect(LoweredExpectations).to receive(:run!).once.and_raise(LoweredExpectations::CommandExecutionError)
      expect { LoweredExpectations.expect(tool, '~> 0.1') }.to raise_error(LoweredExpectations::CommandExecutionError)
    end

    it 'raises an error when the version pattern cannot be found in executable output' do
      expect(LoweredExpectations).to receive(:which).once.with(tool).and_return(tool)
      expect(LoweredExpectations).to receive(:run!).once.and_return(curl_version)
      expect { LoweredExpectations.expect(tool, '~> 0.1', vpattern: 'notvalid') }.to raise_error(LoweredExpectations::VersionPatternError)
    end

    it 'raises an error when the version of the tool does not meet expectations' do
      expect(LoweredExpectations).to receive(:which).once.with(tool).and_return(tool)
      expect(LoweredExpectations).to receive(:run!).once.and_return(curl_version)
      expect(LoweredExpectations).to receive(:verify_version).once.with(version, '~> 0.1').and_raise(LoweredExpectations::IncompatibleVersionError)
      expect { LoweredExpectations.expect(tool, '~> 0.1') }.to raise_error(LoweredExpectations::IncompatibleVersionError)
    end
  end

  describe '.which' do
    it 'returns true when the executable is on the PATH' do
      expect(LoweredExpectations.which(tool)).to be_truthy
    end

    it 'raises an error when the executable is not on the PATH' do
      expect { LoweredExpectations.which 'sometoolthatdoesnotexist' }.to raise_error(LoweredExpectations::MissingExecutableError)
    end
  end

  describe '.verify_version' do
    it 'returns true when the version string matches the version pattern' do
      expect(LoweredExpectations.verify_version(version, '~> 0.1')).to        be_truthy
      expect(LoweredExpectations.verify_version(version, '~> 0')).to          be_truthy
      expect(LoweredExpectations.verify_version(version, '> 0.1.1')).to       be_truthy
      expect(LoweredExpectations.verify_version(version, '< 1')).to           be_truthy
      expect(LoweredExpectations.verify_version(version, '> 0')).to           be_truthy
      expect(LoweredExpectations.verify_version(version, "= #{version}")).to  be_truthy
    end

    it 'raise an error when the version string does not match the version pattern' do
      expect { LoweredExpectations.verify_version version, '~> 0.2' }.to        raise_error(LoweredExpectations::IncompatibleVersionError)
      expect { LoweredExpectations.verify_version version, '~> 1' }.to          raise_error(LoweredExpectations::IncompatibleVersionError)
      expect { LoweredExpectations.verify_version version, '> 0.1.3' }.to       raise_error(LoweredExpectations::IncompatibleVersionError)
      expect { LoweredExpectations.verify_version version, '< 0' }.to           raise_error(LoweredExpectations::IncompatibleVersionError)
      expect { LoweredExpectations.verify_version version, '> 1' }.to           raise_error(LoweredExpectations::IncompatibleVersionError)
      expect { LoweredExpectations.verify_version version, "!= #{version}" }.to raise_error(LoweredExpectations::IncompatibleVersionError)
    end
  end
end
