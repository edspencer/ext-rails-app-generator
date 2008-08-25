class GeneratedModelGenerator < Rails::Generator::NamedBase
  
  attr_reader :model
  
  def initialize(runtime_args, runtime_options = {})
    super
    @model = @args.first
  end

  def manifest
    record do |m|
      m.template '_model.rb', "app/models/#{file_path}.rb"
      # m.template '_model_spec.rb', "spec/models/#{file_path}_spec.rb"
            
      # m.migration_template 'migration_template.rb', 'db/migrate', :assigns => {
      #       :migration_name => "Create#{class_name.pluralize.gsub(/::/, '')}"
      #     }, :migration_file_name => "create_#{file_path.gsub(/\//, '_').pluralize}"
    end
  end

end
