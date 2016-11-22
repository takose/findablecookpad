require 'open-uri'
require 'nokogiri'
require 'net/http'
require 'uri'
class HomeController < ApplicationController
  def top
  end
  def search
    @title=Array.new
    @links=Hash.new
    @images=Hash.new
    @ingredients=Array.new
    kitchens=Kitchen.all
    # スクレイピング先のURL
    if params[:keyword]
      kitchens.each do |kitchen|
        url = 'http://cookpad.com/recipe/list/47282?keyword='
        #url = kitchen.link + '?keyword='
        keyword = CGI.escape(params[:keyword])
        url += keyword
        charset = nil
        html = open(url) do |f|
          charset = f.charset # 文字種別を取得
          f.read # htmlを読み込んで変数htmlに渡す
        end
        # htmlをパース(解析)してオブジェクトを生成
        doc = Nokogiri::HTML.parse(html, nil, charset)
        doc.xpath('//div[@class="recipe-preview"]').each do |node|
          # tilte
          @title.push(node.css('a').inner_text)
          tmp=@title.last
          @links[tmp]=node.css('a').attribute('href').value
          @images[tmp]=node.css('img').attribute('src').value
=begin
          node.css('div').each do |div|
            if div.attribute('class').value=='material ingredients'
              @ingredients[tmp]=div.css('div').inner_text
            end
          end
=end
        end
        doc.xpath('//div[@class="material ingredients"]').each do |node|
          @ingredients.push(node.inner_text)
        end
      end
    end
  end
  
end
