class PreviewController < ActionController::Base

  LANGUAGES = [:ruby, :python, :java, :js, :scss, :sass, :haml, :json,
    :go, :sql, :yaml, :c, :coffee, :properties, :clojure]
  
  def index
    clazz, id = params[:type].classify.constantize, params[:id] 
    r = clazz.find(id)
    if r
      mime = r.content_type
      type, ext = mime[/^[^\/]+/].to_sym, mime[/(?<=\/)(x-)?(.+)/, 2].to_sym
      if LANGUAGES.include?(ext)
        @code = CodeRay.scan(r.content, ext).div(:line_numbers => :table, :css => :class)
        render 'code', layout: 'coderay'
      elsif :markdown == ext
        render text: markdown(r.content), content_type: 'text/html'
      elsif [:pdf, :html].include?(ext)
        render_native(r.content, mime)
      else
        case type
        when :text
          render_native(r.content, 'text/plain')
        when :image, :video, :audio
          render_native(r.content, mime)
        else
          @resource = r
          render 'download', layout: 'coderay'
        end
      end
    else
      render text: "#{r} or #{r.content_type} is not acceptable.", content_type: 'text/plain'
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
    if r
      render_native(r.content, r.content_type || 'application/octet-stream')
    else
      head :no_content
    end
  end
  
  private
    def markdown(content)
      renderer = Markdown::Render::HTML.new(hard_wrap: true, filter_html: true)
      options = {
          autolink: true,
          no_intra_emphasis: true,
          fenced_code_blocks: true,
          lax_html_blocks: true,
          strikethrough: true,
          superscript: true
      }
      Redcarpet::Markdown.new(renderer, options).render(content).html_safe
    end

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