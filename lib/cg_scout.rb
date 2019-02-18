require 'pathname'
require 'yaml'

module CgScout
    class CLI
      def self.run(options)
        Checks.run_all
        config = Config.new

        if options[:e]
          envs = config.get_environments
          raise EnvironmentNotFound.new(options[:e], envs) unless envs.include? options[:e]
          
          cloudgate = Cloudgate.new(config.get_cg_version)
          commit_id, tag_info = cloudgate.run_command options[:e]
          raise CommitIdNotFound unless commit_id

          commit_info = `git show -s --format=medium #{commit_id}`
          undeployed_commits = `git log --oneline master...#{commit_id}`
          recent_commits = `git log --oneline -n 10 #{commit_id}`
          
          puts "\n*** TAG INFO ***\n"
          puts tag_info

          puts "\n*** COMMIT INFO ***\n"
          puts commit_info

          puts "\n*** UNDEPLOYED COMMITS ***\n"
          puts undeployed_commits

          puts "\n*** DEPLOYED COMMITS ***\n"
          puts recent_commits
        else
          # all environments requested
          # not implemented yet
          raise EnvironmentNotProvided
        end
      end
    end
end

require_relative 'cg_scout/version'
require_relative 'cg_scout/exceptions'
require_relative 'cg_scout/checks'
require_relative 'cg_scout/config'
require_relative 'cg_scout/cloudgate'