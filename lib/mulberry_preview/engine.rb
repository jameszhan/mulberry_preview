module MulberryPreview
  class Engine < ::Rails::Engine
    initializer "mimes" do |app|
      MIMES = YAML.load_file("#{self.class.root}/config/mimes.yml")
      MIMES.each do|ext, mime|
        Mime.fetch(ext) do|fallback|          
          Mime::Type.register mime, ext
        end  
      end
    end
  end
end
