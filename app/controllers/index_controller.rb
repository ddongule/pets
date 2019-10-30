# require 'nokogiri'
require 'rubygems'
require 'rest_client'
require 'cgi'
require 'json'
require 'open-uri'
require 'csv'

class IndexController < ApplicationController
  def image_api
    ago = Time.now - 6.months
    begin_date = ago.strftime("%Y%m%d")
    end_date = Time.now.strftime("%Y%m%d")
    numberOfRows = "500"
    upkind = "417000"
    url = 'http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/abandonmentPublic?serviceKey=xGlQTeuJgMXQ6MuW6u00yGB%2B5L5CSFVh1DDrGI4eMq8vKhQpilRPIrDK9%2F3HY26ufoks4n%2Bdv0B7FqkPigJcSQ%3D%3D&bgnde='+ String(begin_date)+'&endde='+String(end_date)+'&numOfRows='+String(numberOfRows)+'&upkind='+String(upkind)
    @response = RestClient::Request.execute(
                  :method => 'GET',
                  :url => url)

    @result = Hash.from_xml(@response)
    


    @item = @result.fetch("response").fetch("body").fetch("items").fetch("item")

    puts end_date 
    puts begin_date
    # puts @headers
    # puts @response
    # puts @result
    # puts @item

  end

  def api
    # @response = RestClient.get 'http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/abandonmentPublic?bgnde=20180101&endde=20180630&pageNo=1&numOfRows=10&ServiceKey=ULZFRqaxmMQoKpfSmd%2FPRUc58FbF2dGlvnb59BWsMneN6WOLVNBH29kxDGrOPU64gXJ04uyGGJMgDiq4NA7O%2BQ%3D%3D'
    # @results = Nokogiri::XML(RestClient.get("http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/abandonmentPublic?bgnde=20180101&endde=20180630&pageNo=1&numOfRows=10&ServiceKey=ULZFRqaxmMQoKpfSmd%2FPRUc58FbF2dGlvnb59BWsMneN6WOLVNBH29kxDGrOPU64gXJ04uyGGJMgDiq4NA7O%2BQ%3D%3D"))
    begin_date = "20140101"
    end_date = "20140201"
    numberOfRows = "100"
    upkind = "417000"
    url = 'http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/abandonmentPublic?serviceKey=xGlQTeuJgMXQ6MuW6u00yGB%2B5L5CSFVh1DDrGI4eMq8vKhQpilRPIrDK9%2F3HY26ufoks4n%2Bdv0B7FqkPigJcSQ%3D%3D&bgnde='+ String(begin_date)+'&endde='+String(end_date)+'&numOfRows='+String(numberOfRows)+'&upkind='+String(upkind)
    @response = RestClient::Request.execute(
                  :method => 'GET',
                  :url => url
                #   ,
                #   :headers => {
                #     '&bgnde' => '20140601',
                #     '&endde' => '20180630',
                #     '&upkind' => '417000',
                #     '&kind' => '',
                #     '&upr_cd' => '',
                #     '&org_cd' => '',
                #     '&care_reg_no' => '',
                #     '&state' => 'notice',
                #     '&pageNo' => '',
                #     '&numOfRows' => '100',
                #     '&neuter_yn' => 'Y' 
                #   }
                )
    # @response = RestClient::Request.execute(:method => 'GET', 
    #                                         :url => url)

    # @headers = { 
    #   :params => { 
    #     CGI::unescape('bgnde') => '20140601',
    #     CGI::unescape('endde') => '20171231',
    #     CGI::unescape('upkind') => '417000',
    #     CGI::unescape('kind') => '',
    #     CGI::unescape('upr_cd') => '',
    #     CGI::unescape('org_cd') => '',
    #     CGI::unescape('care_reg_no') => '',
    #     CGI::unescape('state') => 'notice',
    #     CGI::unescape('pageNo') => '',
    #     CGI::unescape('numOfRows') => '100',
    #     CGI::unescape('neuter_yn') => 'Y' 
    #   }
    # }
    # @response = RestClient::Request.execute(:method => 'GET', 
    #                                         :url => url ,
    #                                         :headers => @headers[:params])

 

    @result = Hash.from_xml(@response)
    ## @results = JSON.parse(@result)
    
    @item = @result.fetch("response").fetch("body").fetch("items").fetch("item")
    ## @age = @results[:response][:body][:items][:item][:age]

    puts @headers
    puts @response
    puts @result
    puts @item
  end


  def crawler 
    @pr = Pet.all
    respond_to do |format|
      format.html
      format.csv { send_data @pr.to_csv }
    end


    i = 448528201800800
    until i > 448528201800827 do 
      url = "http://www.animal.go.kr/portal_rnl/abandonment/protection_view.jsp?desertion_no="+String(i)+"&s_date=&e_date=&s_upr_cd=&s_org_cd=&s_up_kind_cd=&s_kind_cd=&pagecnt=&s_title=&s_sex_cd=&s_call_name=&s_shelter_cd="
      doc = Nokogiri::HTML(open(url).read.encode('utf-8'))
      @posts = doc.css('tr')
      
        if @posts.css('td')[1].text.strip.blank?
          print("값이 존재하지 않습니다.")
        else 
          Pet.create(
            :kind => @posts.css('td')[1].text.strip,
            :color =>  @posts.css('td')[2].text.strip,
            :sex =>  @posts.css('td')[3].text.strip,
            :age_weight =>  @posts.css('td')[4].text.strip,
            :happenPlace =>  @posts.css('td')[5].text.strip,
            :happenDate =>  @posts.css('td')[6].text.strip,
            :neuter =>  @posts.css('td')[7].text.strip,
            :character =>  @posts.css('td')[8].text.strip,
            :dog_number =>  @posts.css('td')[9].text.strip,
            :orgName =>  @posts.css('td')[10].text.strip,
            :processState =>  @posts.css('td')[11].text.strip,
            :careName =>  @posts.css('td')[12].text.strip,
            :careNumber =>  @posts.css('td')[13].text.strip,
            :carePlace =>  @posts.css('td')[14].text.strip,
            # :carePlace =>  @posts.css('td')[15].text.strip
            :image => @posts.css('img .photoArea')        
          )
          end
      i += 1
    end


  end

  
end
