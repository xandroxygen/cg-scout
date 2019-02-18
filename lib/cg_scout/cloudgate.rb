module CgScout
  class Cloudgate
    def initialize(required_version)
      @cg_version = get_correct_version(required_version)
    end

    def get_correct_version(required_version)
      installed_cg_versions = Gem::Specification.find_all_by_name('cloudgate').map &:version
      correct_version = installed_cg_versions.find { |v| Gem::Requirement.create(required_version).satisfied_by?(v)}
      raise VersionMismatch.new(required_version, installed_cg_versions) if correct_version.nil?
      correct_version
    end

    def run_command(env)
      result = `cg _#{@cg_version}_ run -q -e #{env} env | grep 'CG_GIT'`
      parsed = result.split("\r\n").map { |r| r.split('=') }.to_h
      [parsed["CG_GIT_COMMIT_ID"], parsed["CG_GIT_TAG"]]
    end
  end
end
