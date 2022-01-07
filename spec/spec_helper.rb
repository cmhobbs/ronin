require 'rspec'
require 'simplecov'
SimpleCov.start

require 'classes/my_script'
require 'helpers/repositories'

require 'ronin/spec/ui/printing'

include Ronin

RSpec.configure do |spec|
  spec.before(:suite) do
    Repository.create(
      path: File.join(Helpers::Repositories::DIR,'local'),
      name: 'local',
      domain: Repository::LOCAL_DOMAIN
    )

    Repository.create(
      path: File.join(Helpers::Repositories::DIR,'remote'),
      uri: 'git@example.com/path/to/remote.git',
      name: 'remote',
      domain: 'example.com'
    )

    Repository.create(
      path: File.join(Helpers::Repositories::DIR,'installed'),
      uri: 'git@github.com/path/to/installed.git',
      installed: true,
      name: 'installed',
      domain: 'github.com'
    )

    Repository.create(
      path: File.join(Helpers::Repositories::DIR,'scripts'),
      uri: 'git@github.com/path/to/scripts.git',
      name: 'scripts',
      domain: 'github.com'
    )
  end
end
