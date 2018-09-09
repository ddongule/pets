# require 'nokogiri'
require 'rubygems'
require 'rest_client'
require 'cgi'
require 'json'

class IndexController < ApplicationController

  def crawler
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

end
