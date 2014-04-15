module MulberryPreview
  class Railtie < ::Rails::Railtie #:nodoc:
    initializer 'preview' do |app|
      require 'mulberry_preview/helper/action_view_extension'
      ActiveSupport.on_load(:action_view) do
        ::ActionView::Base.send :include, MulberryPreview::ActionViewExtension
      end
    end
  end
end