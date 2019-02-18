require 'pathname'

module CgScout
    class CLI
      def self.run(options)
        # check if working folder is a cg app and a git repo, and if aws creds are loaded
        config_file = Pathname.getwd.join('cloudgate.yml')
        raise CgScout::ProjectNotFound unless config_file.exist?
        # fetch all environment possibilities from `deploy_dir/environments`
        # check if provided environment is a match
        # run command for env and store output
          # will need to know which pool to run
          # will need to run the right version of cloudgate
        # parse output to find commit id
        # display info about commit
      end
    end
end

require_relative 'cg_scout/version'
require_relative 'cg_scout/exceptions'