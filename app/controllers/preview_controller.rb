class PreviewController < ActionController::Base

  Languages = [:ruby, :python, :java, :js, :scss, :sass, :haml, :json, 
    :go, :sql, :yaml, :c, :coffee, :properties]  
  
  def index
    clazz, id = params[:type].classify.constantize, params[:id] 
    r = clazz.find(id)
    type, ext = r.content_type[/^[^\/]+/].to_sym, r.content_type[/(?<=\/)(x-)?(.+)/, 2].to_sym
    if Languages.include?(ext)
      @code = CodeRay.scan(r.content, ext).div(:line_numbers => :table, :css => :class)
      render 'code', layout: 'coderay'
    elsif [:pdf, :html].include?(ext)
      render_native(r.content, r.content_type)
    else
      case type
      when :text
        render_native(r.content, 'text/plain')
      when :image
        render_native(r.content, r.content_type)
      else
        @resource = r
        render 'download', layout: 'coderay'
      end
    end
  end
  
  def open
    case RUBY_PLATFORM
    when /darwin/i
      open_osx_file
    when /linux/i
      open_linux_file
    when /cygwin|mswin|mingw|bccwin|wince|emx/
      open_windows_file
    else
      #other
    end
    head :no_content
  end
  
  def download
    clazz, id = params[:type].classify.constantize, params[:id] 
    r = clazz.find(id)
    render_native(r.content, r.content_type)
  end
  
  private
    def open_osx_file
      path = params[:path]
      app = 'Preview'
      if /^text\/.+$/ =~ params[:mime]
        app = 'TextMate'
      end
      system %Q{open -a #{app} "#{path}"}
    end
    
    def render_native(content, content_type)
      response.headers['Cache-Control'] = "public, max-age=#{12.hours.to_i}"
      response.headers['Content-Type'] = content_type
      response.headers['Content-Disposition'] = 'inline'
      render text: content, content_type: content_type
    end
  
end