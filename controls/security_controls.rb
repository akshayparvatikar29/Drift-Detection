control 'ssh-root-login-disabled' do
  impact 1.0
  title 'Disable SSH root login'

  describe sshd_config do
    its('PermitRootLogin') { should cmp 'no' }
  end
end

control 'telnet-not-installed' do
  impact 1.0
  title 'Telnet should not be installed'

  describe package('telnet') do
    it { should_not be_installed }
  end
end

control 'password-min-length' do
  impact 1.0
  title 'Password minimum length'

  describe file('/etc/login.defs') do
    its('content') { should match /PASS_MIN_LEN\s+12/ }
  end
end

control 'firewall-port-check' do
  impact 1.0
  title 'Unauthorized firewall port'

  describe command("ufw status") do
    its('stdout') { should_not match /3306/ }
  end
end
