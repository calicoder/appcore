config_file = "#{::Rails.root.to_s}/config/facebooker.yml"
FACEBOOK_CONFIG = YAML.load(ERB.new(File.read(config_file)).result)[::Rails.env]