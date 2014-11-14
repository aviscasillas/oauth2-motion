module OAuth2Motion
  class Client
    attr_accessor :id, :secret, :site, :token_url,
                  :username, :password, :access_token

    def initialize(options = {})
      @id = options[:client_id]
      @secret = options[:client_secret]
      @access_token = options[:access_token]
      @site = options[:site]
      @token_url = '/oauth/token'
    end

    def authorized(payload, &block)
      unless access_token
        BubbleWrap::HTTP.post(site + token_url, payload: payload) do |response|
          if response.ok?
            json = BW::JSON.parse(response.body.to_str)
            block.call(json['access_token'])
          else
            block.call(nil)
          end
        end
      end

      block(access_token) if access_token
    end

    def client_credentials_request(method, path, params, &block)
      payload = {
        grant_type: 'client_credentials',
        client_id: id,
        client_secret: secret
      }

      authorized(payload) do |access_token|
        request(path, method, access_token, params) do |response|
          block.call(response)
        end
      end
    end

    def password_request(path = '')
    end

    def request(path, method, token, params, &block)
      BubbleWrap::HTTP.send(method, site + path,
                            headers: { authorization: "Bearer #{token}" },
                            payload: params) do |response|
        block.call(response)
      end
    end

    def post(path, params, &block)
      send("#{strategy}_request", :post, path, params, &block)
    end

    def strategy
      if username && password
        :password
      else
        :client_credentials
      end
    end
  end
end
