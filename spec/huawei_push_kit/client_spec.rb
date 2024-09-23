# frozen_string_literal: true

require "spec_helper"
require "huawei_push_kit"

RSpec.describe HuaweiPushKit::Client do
  let(:client_id) { "test_client_id" }
  let(:client_secret) { "test_client_secret" }
  let(:client) { described_class.new(client_id, client_secret) }
  let(:device_token) { "test_device_token" }
  let(:title) { "Hello" }
  let(:body) { "World" }

  let(:response) do
    {
      "code" => "80000000",
      "errors" => nil
    }
  end

  before do
    stub_request(:post, "https://oauth-login.cloud.huawei.com/oauth2/v3/token")
      .to_return(status: 200, body: { access_token: "access_token", expires_in: 3600 }.to_json)
  end

  describe "#send_push_notification" do
    before do
      stub_request(:post, "https://push-api.cloud.huawei.com/v1/#{client_id}/messages:send")
        .to_return(status: 200, body: response.to_json)
    end

    it "sends a push notification to a single device and returns an ApiResponse object" do
      result = client.send_push_notification(device_token, title, body)
      expect(result).to be_a(HuaweiPushKit::ApiResponse)
      expect(result.successful?).to be true
      expect(result.error).to be_nil
    end
  end

  describe "#send_push_notification_to_topic" do
    let(:topic_name) { "test_topic" }

    before do
      stub_request(:post, "https://push-api.cloud.huawei.com/v1/#{client_id}/messages:send")
        .to_return(status: 200, body: response.to_json)
    end

    it "sends a push notification to a topic and returns an ApiResponse object" do
      result = client.send_push_notification_to_topic(topic_name, title, body)
      expect(result).to be_a(HuaweiPushKit::ApiResponse)
      expect(result.successful?).to be true
      expect(result.error).to be_nil
    end
  end

  describe "#subscribe_to_topic" do
    let(:topic_name) { "test_topic" }
    let(:device_tokens) { %w[token1 token2] }

    before do
      stub_request(:post, "https://push-api.cloud.huawei.com/v1/#{client_id}/topic:subscribe")
        .to_return(status: 200, body: response.to_json)
    end

    it "subscribes devices to a topic and returns an ApiResponse object" do
      result = client.subscribe_to_topic(topic_name, device_tokens)
      expect(result).to be_a(HuaweiPushKit::ApiResponse)
      expect(result.successful?).to be true
      expect(result.error).to be_nil
    end
  end

  describe "#unsubscribe_from_topic" do
    let(:topic_name) { "test_topic" }
    let(:device_tokens) { %w[token1 token2] }

    before do
      stub_request(:post, "https://push-api.cloud.huawei.com/v1/#{client_id}/topic:unsubscribe")
        .to_return(status: 200, body: response.to_json)
    end

    it "unsubscribes devices from a topic and returns an ApiResponse object" do
      result = client.unsubscribe_from_topic(topic_name, device_tokens)
      expect(result).to be_a(HuaweiPushKit::ApiResponse)
      expect(result.successful?).to be true
      expect(result.error).to be_nil
    end
  end

  describe "#topic_list" do
    let(:device_token) { "token1" }

    before do
      stub_request(:post, "https://push-api.cloud.huawei.com/v1/#{client_id}/topic:list")
        .to_return(status: 200, body: response.to_json)
    end

    it "receives topic list and returns an ApiResponse object" do
      result = client.topic_list(device_token)
      expect(result).to be_a(HuaweiPushKit::ApiResponse)
      expect(result.successful?).to be true
      expect(result.error).to be_nil
    end
  end
end
