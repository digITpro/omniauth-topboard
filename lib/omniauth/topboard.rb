require "omniauth/topboard/version"
require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Topboard < OmniAuth::Strategies::OAuth2
      option :name, :topboard

      option :client_options, {
        site: "https://app.topboard.ch",
        authorize_path: "/oauth/authorize"
      }

      uid { raw_info["id"] }

      info do
        {
          email: raw_info["email"],
          name: raw_info["name"],
          first_name: raw_info["lastname"],
          last_name: raw_info["lastname"],
        }
      end

      def callback_url
        full_host + callback_path
      end

      def raw_info
        @raw_info ||= access_token.get('/api/v1/me.json').parsed
      end
    end
  end
end
