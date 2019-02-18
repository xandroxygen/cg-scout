module CgScout
  class ProjectNotFound < RuntimeError
    def message
      "Couldn't find a cloudgate.yml, is this a cloudgate app?"
    end
  end

  class NotGitRepo < RuntimeError
    def message
      "This directory isn't a git repository, is this a cloudgate app?"
    end
  end

  class NotAuthenticated < RuntimeError
    def message
      "There are no AWS credentials loaded, did you use `vaulted`?"
    end
  end

  class EnvironmentNotFound < RuntimeError
    def initialize(env, possible_envs)
      @env = env
      @possible_envs = possible_envs
    end

    def message
      "Environment `#{@env}` does not exist. Possible environments: #{@possible_envs.join(', ')}"
    end
  end

  class EnvironmentNotProvided < RuntimeError
    def message
      "Asking `cg-scout` for data about all environments isn't implemented yet. Please provide an environment."
    end
  end

  class VersionMismatch < RuntimeError
    def initialize(required, installed)
      @required = required
      @installed = installed
    end

    def message
      "This cloudgate app requires version #{@required} of cloudgate, but only versions #{@installed} are installed."
    end
  end
end