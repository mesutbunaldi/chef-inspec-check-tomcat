# copyright: 2018, The Authors

title "Tomcat Correctness"

control 'tomcat-01' do
  impact 1.0
  title 'Verify Tomcat is running on the default port'
  desc 'Tomcat runs on a specific port by default'

  describe host('localhost', port: 8080, protocol: 'tcp') do
    it { should be_reachable }
  end

  describe port(8080) do
    it { should be_listening }
    its ('protocols') { should cmp('tcp') }
    its ('addresses') { should cmp('::') }
  end
end


control 'tomcat-02' do
  impact 1.0
  title 'Tomcat default home page talks about Tomcat'
  desc 'The default page displays information about using Tomcat'
  
  describe http('http://localhost:8080') do
    its('body') { should match /Tomcat/ }
  end
end


control 'tomcat-03' do
  impact 1.0
  title 'Tomcat runs a service on the system'
  desc 'The service is important for the health of Tomcat'
  
  describe service('tomcat') do
    it { should (be_running) }
  end
end


