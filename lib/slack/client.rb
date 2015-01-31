require "net/http"

module Slack
  class Client
    RequestFailed = Class.new(StandardError)
    InviteFailed = Class.new(StandardError)

    def initialize(subdomain:, token:)
      @subdomain = subdomain
      @token = token
    end

    def invite(email:, channels: [])
      res = Net::HTTP.start("#{@subdomain}.slack.com", 443, use_ssl: true) do |http|
        req = Net::HTTP::Post.new("/api/users.admin.invite?t=#{Time.now.to_i}")
        req.set_form_data \
          email:       email,
          channels:    channels.join(","),
          token:       @token,
          set_active:  "true",
          _attempts:   1

        http.request(req)
      end

      raise RequestFailed unless res.is_a?(Net::HTTPSuccess)

      body = JSON.parse(res.body)
      raise InviteFailed unless body["ok"]

      true
    end
  end
e
