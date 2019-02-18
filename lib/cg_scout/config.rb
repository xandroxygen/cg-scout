module CgScout
  class Config
    def initialize
      data = YAML.load_file(Pathname.getwd.join('cloudgate.yml')) || {}
      deploy_dir_name = data['deploy_dir'] || 'deploy'
      @deploy_dir = Pathname.getwd.join(deploy_dir_name)
    end

    def get_environments
      files = Pathname.glob(@deploy_dir.join('environments', '*.yml'))
      environment_files = files.reject { |p| p.to_s.end_with?('_secrets.yml') }
      environment_files.map { |p| p.basename('.yml').to_s }
    end

    def get_cg_version
      common_config = YAML.load_file(@deploy_dir.join('common.yml'))
      common_config.fetch('cloudgate', {}).fetch('required_version', '>= 0.0.0')
    end
  end
end