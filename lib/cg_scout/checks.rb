module CgScout
  class Checks
    def self.run_all
      self.is_cloudgate?
      self.is_git?
      self.has_aws_creds?
    end

    def self.is_cloudgate?
      config_file = Pathname.getwd.join('cloudgate.yml')
      raise ProjectNotFound unless config_file.exist?
    end

    def self.is_git?
      raise NotGitRepo unless system('git rev-parse')
    end

    def self.has_aws_creds?
      aws_creds = ENV.select { |k,_| k.match(/AWS/) }
      raise NotAuthenticated if aws_creds.empty?
    end
  end
end