if defined?(ChefSpec)
  def create_log_forward(name)
    ChefSpec::Matchers::ResourceMatcher.new(:log_forward, :create, name)
  end
end
