class Base
  def initialize(args)
    check_ruby_version
    args.each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
  end

  private
  def check_ruby_version
    if RUBY_VERSION < '1.9'
      abort("This program requires Ruby version 1.9. Abort.")
    end
  end
  
  def check_file(file)
    if File.exist?(file)
    else
      abort("File #{file} does not exist. Abort.")
    end
  end
end