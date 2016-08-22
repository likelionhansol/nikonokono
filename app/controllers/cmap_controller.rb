class CmapController < ApplicationController

  def map

    ########## 사용할 함수들 정의 ##########
    # 현재위치 좌표를 주소로 변환하는 함수 (ㅜNaver reverse Geocode API)
    def latlngToAddress(lat, lng)
      # 요청 URL 설정
      queryUrl = "https://openapi.naver.com/v1/map/reversegeocode?query="+lat+","+lng

      # 요청 URL encoding
      uri = URI(URI.encode(queryUrl))

      # 요청 객체 생성 (req)
      req = Net::HTTP::Get.new(uri)

      # 요청 Parameter 설정
      req['Content-Type'] = "application/json"
      req['X-Naver-Client-Id'] = "h40urbpdCMGXC07cN0rf"
      req['X-Naver-Client-Secret'] = "UafuNNDgZ6"

      # 요청 및 요청에 대한 응답 변수 선언 (res)
      res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https' ) {|http|
        http.request(req)
      }

      # 응답으로 내려온 JSON을 parsing하여 json_doc 객체로
      json_doc = JSON.parse(res.body)

      # 파싱된 객체(json_doc)로부터 주소 추출
      address = json_doc['result']['items'].at(0)['address']

      # 주소 리턴
      return address
    end

    # 주소를 위/경도 좌표로 변환하는 함수 (Naver Geocode API)
    def addressToLatLng(address)   # 주소를 인자로 받는다
      # 요청 URL 설정
      queryUrl = "https://openapi.naver.com/v1/map/geocode?query="+address

      # 요청 URL encoding
      uri = URI(URI.encode(queryUrl))

      # 요청 객체 생성 (req)
      req = Net::HTTP::Get.new(uri)

      # 요청 Parameter 설정
      req['Content-Type'] = "application/json"
      req['X-Naver-Client-Id'] = "h40urbpdCMGXC07cN0rf"
      req['X-Naver-Client-Secret'] = "UafuNNDgZ6"

      # 요청 및 요청에 대한 응답 변수 선언 (res)
      res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https' ) {|http|
        http.request(req)
      }

      # 응답으로 내려온 JSON을 parsing하여 json_doc 객체로
      json_doc = JSON.parse(res.body)

      # 파싱된 객체(json_doc)로부터 위/경도 좌표(x, y) 추출
      x = json_doc['result']['items'].at(0)['point']['x']
      y = json_doc['result']['items'].at(0)['point']['y']

      # 위/경도 좌표값 (x, y) 리턴
      return x, y
    end


    ##### 검색 API 사용 > 노래방 검색 #####
    #query = params[:query]
    queryUrl = "https://openapi.naver.com/v1/search/local.xml?query=코인노래방"

    uri = URI(URI.encode(queryUrl))

    req = Net::HTTP::Get.new(uri)
    req['Content-Type'] = "application/json"
    req['X-Naver-Client-Id'] = "h40urbpdCMGXC07cN0rf"
    req['X-Naver-Client-Secret'] = "UafuNNDgZ6"

    res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https' ) {|http|
      http.request(req)
    }

    # XML Parsing
    xml_doc = Nokogiri::XML(res.body)

    title = xml_doc.xpath("//title")
    address = xml_doc.xpath("//address")

    @resultArrayHash = Array.new
    address.each_with_index do |a, index|
      hashTest = Hash.new
      hashTest[:title] = title.at(index).inner_text
      hashTest[:x] = addressToLatLng(a.inner_text).at(0)
      hashTest[:y] = addressToLatLng(a.inner_text).at(1)
      @resultArrayHash.push(hashTest)
    end
  end



  # Search ACTION (삭제예정)
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

    # XML Parsing
    xml_doc = Nokogiri::XML(res.body)

    @title = xml_doc.xpath("//title")
    @address = xml_doc.xpath("//address")

    # 주소 > 위/경도 좌표로 변환하는 함수 (Naver Geocode API)
    def addressToLatLng(address)   # 주소를 인자로 받는다

      # 요청 URL 설정
      queryUrl = "https://openapi.naver.com/v1/map/geocode?query="+address

      # 요청 URL encoding
      uri = URI(URI.encode(queryUrl))

      # 요청 객체 생성 (req)
      req = Net::HTTP::Get.new(uri)

      # 요청 Parameter 설정
      req['Content-Type'] = "application/json"
      req['X-Naver-Client-Id'] = "h40urbpdCMGXC07cN0rf"
      req['X-Naver-Client-Secret'] = "UafuNNDgZ6"

      # 요청 및 요청에 대한 응답 변수 선언 (res)
      res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https' ) {|http|
        http.request(req)
      }

      # 응답으로 내려온 JSON을 parsing하여 json_doc 객체로
      json_doc = JSON.parse(res.body)

      # 파싱된 객체(json_doc)로부터 위/경도 좌표(x, y) 추출
      x = json_doc['result']['items'].at(0)['point']['x']
      y = json_doc['result']['items'].at(0)['point']['y']

      return x, y

    end

    @test = addressToLatLng(@address.at(0).inner_text)

    @resultArrayHash = Array.new

    @address.each_with_index do |a, index|
      hashTest = Hash.new
      hashTest[:title] = @title.at(index).inner_text
      hashTest[:x] = addressToLatLng(a.inner_text).at(0)
      hashTest[:y] = addressToLatLng(a.inner_text).at(1)
      @resultArrayHash.push(hashTest)
    end


  end


end
