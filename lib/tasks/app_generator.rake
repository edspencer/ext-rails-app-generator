namespace :app_generator do
  
  desc "Creates database entries for default plugins"
  task :create_default_plugins => :environment do
    Plugin.create!(:name       => 'HAML',
                   :remote_url => 'git://github.com/nex3/haml.git',
                   :local_path => 'vendor/plugins/haml')
                  
    Plugin.create!(:name       => 'Will Paginate',
                   :remote_url => 'git://github.com/mislav/will_paginate.git',
                   :local_path => 'vendor/plugins/will_paginate',
                   :selected_by_default => true)
                  
    Plugin.create!(:name       => 'Exception Notification',
                   :remote_url => 'git://github.com/rails/exception_notification.git',
                   :local_path => 'vendor/plugins/exception_notification', 
                   :selected_by_default => true)
    
    Plugin.create!(:name       => 'SSL Requirement',
                   :remote_url => 'git://github.com/rails/ssl_requirement.git',
                   :local_path => 'vendor/plugins/ssl_requirement')
                  
    Plugin.create!(:name       => 'RSpec',
                   :remote_url => 'git://github.com/dchelimsky/rspec.git',
                   :local_path => 'vendor/plugins/rspec')
                  
    Plugin.create!(:name       => 'RSpec on Rails',
                   :remote_url => 'git://github.com/dchelimsky/rspec-rails.git',
                   :local_path => 'vendor/plugins/rspec_rails')
                  
    Plugin.create!(:name       => 'RSpec on Rails Matchers',
                   :remote_url => 'git://github.com/joshknowles/rspec-on-rails-matchers.git',
                   :local_path => 'vendor/plugins/rspec_on_rails_matchers')
                   
    Plugin.create!(:name       => 'Attachment Fu',
                   :remote_url => 'git://github.com/technoweenie/attachment_fu.git',
                   :local_path => 'vendor/plugins/attachment_fu')
                   
    Plugin.create!(:name       => 'Paperclip',
                   :remote_url => 'git://github.com/thoughtbot/paperclip.git',
                   :local_path => 'vendor/plugins/paperclip')
                   
    Plugin.create!(:name       => 'Restful Authentication',
                   :remote_url => 'git://github.com/technoweenie/restful-authentication.git',
                   :local_path => 'vendor/plugins/restful_authentication')
  end
end