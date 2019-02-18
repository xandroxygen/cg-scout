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
end