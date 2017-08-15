require 'omniauth-oauth2'
require 'builder'
require 'nokogiri'
require 'rest_client'

module OmniAuth
  module Strategies
    class Membersuite < OmniAuth::Strategies::OAuth2
      option :name, 'membersuite'

      option :app_options, { app_event_id: nil }

      option :client_options, {
        authorize_url: 'MUST BE SET',
        access_key_id: 'MUST BE SET',
        secret_access_key: 'MUST BE SET',
        association_id: 'MUST BE SET'
      }

      uid { @raw_info[:uid] }

      info do
        {
          id: @raw_info[:uid],
          first_name: @raw_info[:first_name],
          last_name: @raw_info[:last_name],
          email: @raw_info[:email],
          username: @raw_info[:username],
          subscriptions: @raw_info[:subscriptions],
          subscription_expiration_dates: @raw_info[:subscription_expiration_dates],
          membership: @raw_info[:membership],
          membership_expiration_date: @raw_info[:membership_expiration_date],
          membership_receives_member_benefits: @raw_info[:membership_receives_member_benefits]
        }
      end

      extra do
        { raw_info: @raw_info }
      end

      def request_phase
        slug = session['omniauth.params']['origin'].gsub(/\//, '')
        redirect "#{authorize_url}?redirectURL=#{callback_url}?slug=#{slug}"
      end

      def callback_phase
        slug = request.params['slug']
        account = Account.find_by(slug: slug)
        app_event = account.app_events.where(id: options.app_options.app_event_id).first_or_create(activity_type: 'sso')

        @raw_info ||= {
          uid: request.params['uid'],
          first_name: request.params['first_name'],
          last_name: request.params['last_name'],
          email: request.params['email'],
          username: request.params['username'],
          subscriptions: request.params['subscriptions'],
          subscription_expiration_dates: request.params['subscription_expiration_dates'],
          membership: request.params['membership'],
          membership_expiration_date: request.params['membership_expiration_date'],
          membership_receives_member_benefits: request.params['membership_receives_member_benefits']
        }

        self.env['omniauth.auth'] = auth_hash
        self.env['omniauth.origin'] = '/' + slug
        self.env['omniauth.app_event_id'] = app_event.id
        call_app!
      end

      def credentials
        {
          authorize_url: authorize_url,
          access_key_id: access_key_id,
          secret_access_key: secret_access_key,
          association_id: association_id
        }
      end

      def auth_hash
        hash = AuthHash.new(provider: name, uid: uid)
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

      def association_id
        options.client_options.association_id
      end
    end
  end
end
