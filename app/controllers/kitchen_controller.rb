class KitchenController < ApplicationController
  def new
    #これあとでなんとかする
    @kitchen=Kitchen.last
  end
  
  def create
    # URLにアクセスするためのライブラリの読み込み
    require 'open-uri'
    # Nokogiriライブラリの読み込み
    require 'nokogiri'
    
    require 'net/http'
    require 'uri'
    #updateと同じ動きなのでメソッドまとめたい
    @kitchen=Kitchen.new
    @kitchen.name=params[:name]
    
    url = 'http://cookpad.com/recipe/list/'+params[:link]
    charset = nil
    html = open(url) do |f|
      charset = f.charset # 文字種別を取得
      f.read # htmlを読み込んで変数htmlに渡す
    end
    doc = Nokogiri::HTML.parse(html, nil, charset)
    doc.xpath('//div[@class="user_name"]').each do |node|
      # tilte
      @kitchen.name=(node.css('a').attribute('data-user-name').value)
    end
        
    @kitchen.link='http://cookpad.com/recipe/list/'+params[:link]
    if @kitchen.save
      redirect_to kitchen_path
    else
      render :new
    end
  end
  
  def list
    @kitchens=Kitchen.all
  end
  
  def edit
    @kitchen=Kitchen.find(params[:id])
  end
  
  def update
    @kitchen=Kitchen.find(params[:id])
    @kitchen.name=params[:name]
    @kitchen.link='http://cookpad.com/recipe/list/'+params[:link]
    if @kitchen.save
      redirect_to kitchen_path
    else
      render :new
    end
  end
  
  def delete
    @kitchen=Kitchen.find(params[:id])
    @kitchen.destroy
    redirect_to kitchen_path
  end
  
  
  
end
