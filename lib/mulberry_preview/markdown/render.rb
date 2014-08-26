# encoding: UTF-8
module Markdown
  module Render
    class HTML < Redcarpet::Render::HTML  #MdEmoji::Render
      def block_code(code, language)
        sha = Digest::SHA1.hexdigest(code)
        lang = santize language
        Rails.cache.fetch ['code', lang, sha].join('-') do
          CodeRay.scan(code, lang).div#(:line_numbers => :table)
        end
      end

      def santize(language)
        language ||= :default
        if CodeRay::Scanners.list.include?(language.to_sym)
          language
        elsif CodeRay::Scanners.plugin_hash.key?(language)
          CodeRay::Scanners.plugin_hash[language]
        else
          :default
        end
      end
    end
  end
end