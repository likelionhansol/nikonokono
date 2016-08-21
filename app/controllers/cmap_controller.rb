class CmapController < ApplicationController

  def loca
  end

  def search
    query = params[:query]
    queryUrl = "https://openapi.naver.com/v1/search/local.xml?query="+query

    uri = URI(URI.encode(queryUrl))

    req = Net::HTTP::Get.new(uri)
    req['Content-Type'] = "application/json"
    req['X-Naver-Client-Id'] = "h40urbpdCMGXC07cN0rf"
    req['X-Naver-Client-Secret'] = "UafuNNDgZ6"

    res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https' ) {|http|
      http.request(req)
    }

    # @ddd = res.body

    xml_doc = Nokogiri::XML(res.body)
    # @links = xml_doc.xpath("//title")

    @links = Array.new
    @links = xml_doc.xpath("//address")

    # Geocode Method 추가 (주소 > 위/경도 좌표 변환)
    def toLatLng (address)
      # ...

    end





  end


  def map_search

      query = params[:query]
      queryUrl = "https://openapi.naver.com/v1/map/geocode?query="+query

      uri = URI(URI.encode(queryUrl))

      req = Net::HTTP::Get.new(uri)

      req['Content-Type'] = "application/json"
      req['X-Naver-Client-Id'] = "h40urbpdCMGXC07cN0rf"
      req['X-Naver-Client-Secret'] = "UafuNNDgZ6"

      res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https' ) {|http|
        http.request(req)
      }


      xml_doc = Nokogiri::XML(res.body)
      @json_doc = Hash.from_xml(xml_doc).to_json

#      @links = xml_doc.xpath("//title")


  end



end
