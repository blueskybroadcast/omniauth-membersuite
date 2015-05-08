require 'omniauth-oauth2'
require 'builder'
require 'nokogiri'
require 'rest_client'

module OmniAuth
  module Strategies
    class Asms < OmniAuth::Strategies::OAuth2
      option :name, 'asms'

      option :client_options, {
        authorize_url: 'MUST BE SET',
        access_key_id: 'MUST BE SET',
        secret_access_key: 'MUST BE SET',
        tssociation_id: 'MUST BE SET',
        tssociation_key: 'MUST BE SET'
      }

      uid { info[:id] }

      info do
        raw_user_info
      end

      extra do
        { :raw_info => raw_user_info }
      end

      def credentials
        {credintals: ''}
      end

      def raw_user_info
        { id: 0 }
      end

      def request_phase
        slug = session['omniauth.params']['origin'].gsub(/\//,"")
        redirect authorize_url + "?redirectURL=" + callback_url + "?slug=#{slug}"
      end

      def callback_phase
        self.env['omniauth.auth'] = auth_hash
        self.env['omniauth.origin'] = '/' + request.params['slug']
        call_app!
      end

      def auth_hash
        hash = AuthHash.new(:provider => name, :uid => uid)
        hash.info = info
        hash.credentials = credentials
        hash.extra = extra
        hash
      end

      private

      def authorize_url
        options.client_options.authorize_url
      end

      def access_key_id
        options.client_options.access_key_id
      end

      def secret_access_key
        options.client_options.secret_access_key
      end

      def tssociation_id
        options.client_options.tssociation_id
      end

      def tssociation_key
        options.client_options.tssociation_key
      end
    end
  end
end
