class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private
  def slack_client
    @slack_client ||= Slack::Client.new \
      ENV.fetch("SLACK_SUBDOMAIN"),
      ENV.fetch("SLACK_TOKEN")
  end
end
