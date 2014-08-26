module MulberryPreview
  class Engine < ::Rails::Engine
    initializer 'mimes' do |_app|
      MIMES = YAML.load_file("#{self.class.root}/config/mimes.yml")
      MIMES.each do|ext, mime|
        Mime.fetch(ext) do|_fallback|
          Mime::Type.register mime, ext
        end  
      end
    end
  end
end
