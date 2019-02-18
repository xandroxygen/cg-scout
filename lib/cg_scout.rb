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
          commit_id, tag_info = cloudgate.run_command(options[:e])
          raise CommitIdNotFound unless commit_id
          
          self.print_section("TAG INFO", tag_info)
          self.print_section("COMMIT_INFO", Git.commit_info(commit_id))
          self.print_section("UNDEPLOYED COMMITS", Git.undeployed_commits(commit_id))
          self.print_section("DEPLOYED COMMITS", Git.deployed_commits(commit_id))
        else
          # all environments requested
          # not implemented yet
          raise EnvironmentNotProvided
        end
      end

      def self.print_section(title,data)
        puts "\n*** #{title} ***\n"
        puts data
      end
    end
end

require_relative 'cg_scout/version'
require_relative 'cg_scout/exceptions'
require_relative 'cg_scout/checks'
require_relative 'cg_scout/config'
require_relative 'cg_scout/cloudgate'
require_relative 'cg_scout/git'