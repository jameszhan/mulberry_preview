module MulberryPreview
  Languages = [:ruby, :python, :java, :js, :scss, :sass, :haml, :html, :json, :go, :sql, :yaml, :c, :coffee, :properties]

  module ActionViewExtension
    def preview(r)
      type = r.content_type[/^[^\/]+/].to_sym
      ext = r.content_type[/(?<=\/)(x-)?(.+)/, 2].to_sym
      case type
      when :text
        if Languages.include?(ext)
          raw CodeRay.scan(r.content, ext).div(:line_numbers => :table, :css => :class)
        else
          raw "<div class=\"code\">#{r.content}</div>"
        end       
      when :image
        raw "<img src=\"#{preview_path(r.class, r.id)}\" class=\"img-thumbnail\" />"
      when :application
        if :pdf == ext
          raw "<iframe src=\"#{preview_path(r.class, r.id)}\" width='860' height='800' border='0' style='border:none'></iframe>"
        else
          "#{r.content_type} => #{r}"
        end
      else
        "Binary File [#{r}]" 
      end
    end
  end
end