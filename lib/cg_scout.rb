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
          
          required_cg_version = config.get_cg_version
          installed_cg_versions = Gem::Specification.find_all_by_name('cloudgate').map &:version
          cg_version_to_use = installed_cg_versions.find { |v| Gem::Requirement.create(required_cg_version).satisfied_by?(v)}
          raise VersionMismatch.new(required_cg_version, installed_cg_versions) if cg_version_to_use.nil?
          
          result = `cg _#{cg_version_to_use}_ run -q -e #{options[:e]} env | grep 'CG_GIT'`
          parsed_result = result.split("\r\n").map { |r| r.split('=') }.to_h
          
          commit_id = parsed_result["CG_GIT_COMMIT_ID"]
          raise CommitIdNotFound unless commit_id

          tag_info = parsed_result["CG_GIT_TAG"]
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