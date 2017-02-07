resource_name :my_website
property :git_repo, String, default: git, name_property: true

action :create do
  execute 'ran' do
    command 'echo ran command > /var/website/command.txt'
    not_if { ::File.exist?('/var/website/command.txt') }
  end

  git 'architect' do
    destination '/var/website/architect'
    repository git
    action :nothing
    subscribes :sync, 'execute[ran]', :immediately
  end
end
