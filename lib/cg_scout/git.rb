module CgScout
  class Git
    def self.commit_info(commit_id)
      `git show -s --format=medium #{commit_id}`
    end

    def self.undeployed_commits(commit_id)
      `git log --oneline master...#{commit_id}`
    end

    def self.deployed_commits(commit_id)
      `git log --oneline -n 10 #{commit_id}`
    end
  end
end