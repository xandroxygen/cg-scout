module CgScout
  class ProjectNotFound < RuntimeError
    def message
      "Couldn't find a cloudgate.yml, is this a cloudgate app?"
    end
  end
end