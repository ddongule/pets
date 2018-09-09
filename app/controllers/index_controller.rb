# require 'nokogiri'
require 'rubygems'
require 'rest_client'
require 'cgi'
require 'json'
require 'open-uri'
require 'csv'

class IndexController < ApplicationController
  def api
    # @response = RestClient.get 'http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/abandonmentPublic?bgnde=20180101&endde=20180630&pageNo=1&numOfRows=10&ServiceKey=ULZFRqaxmMQoKpfSmd%2FPRUc58FbF2dGlvnb59BWsMneN6WOLVNBH29kxDGrOPU64gXJ04uyGGJMgDiq4NA7O%2BQ%3D%3D'
    # @results = Nokogiri::XML(RestClient.get("http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/abandonmentPublic?bgnde=20180101&endde=20180630&pageNo=1&numOfRows=10&ServiceKey=ULZFRqaxmMQoKpfSmd%2FPRUc58FbF2dGlvnb59BWsMneN6WOLVNBH29kxDGrOPU64gXJ04uyGGJMgDiq4NA7O%2BQ%3D%3D"))

    url = 'http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/abandonmentPublic?serviceKey=xGlQTeuJgMXQ6MuW6u00yGB%2B5L5CSFVh1DDrGI4eMq8vKhQpilRPIrDK9%2F3HY26ufoks4n%2Bdv0B7FqkPigJcSQ%3D%3D'
    @response = RestClient::Request.execute(
                  :method => 'GET',
                  :url => url,
                  :headers => {
                    'bgnde' => '20140601',
                    'endde' => '20140630',
                    'upkind' => '417000',
                    'kind' => '',
                    'upr_cd' => '',
                    'org_cd' => '',
                    'care_reg_no' => '',
                    'state' => 'notice',
                    'pageNo' => '1',
                    'numOfRows' => '10',
                    'neuter_yn' => 'Y' 
                  }
                )
    @result = Hash.from_xml(@response)
    # @results = JSON.parse(@result)
    
    @item = @result.fetch("response").fetch("body").fetch("items").fetch("item")
    # @age = @results[:response][:body][:items][:item][:age]
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

    i = 448533201800000
  
    until i > 448533201800452 do 
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
            :dog_number =>  @posts.css('td')[11].text.strip,
            :processState =>  @posts.css('td')[12].text.strip,
            :careName =>  @posts.css('td')[13].text.strip,
            :careNumber =>  @posts.css('td')[14].text.strip,
            # :carePlace =>  @posts.css('td')[15].text.strip
            :image => @posts.css('img .photoArea')        
          )
          end
      i += 1
    end


  end

  
end
