# 📬 Huawei Push Kit Ruby Client

Welcome to the unofficial Ruby client for [Huawei Push Kit](https://developer.huawei.com/consumer/en/hms/huawei-pushkit/), designed to seamlessly integrate Huawei Push Kit capabilities into your Ruby applications.

## 🌟 Features

- Send notifications to devices using a simple Ruby interface.
- Support for major features provided by the Huawei Push Kit API.

## 🛠 Installation

To start using this gem in your Ruby application, add this line to your Gemfile:

```ruby
gem 'huawei_push_kit'
```
Then execute:

```ruby
bundle install
```

Or install it yourself as:
```ruby
gem install huawei_push_kit
```

# ⚙ Configuration
Before using the client, you need to configure your access keys obtained from the Huawei Developer Console and add it to the `.env` file.

```
HUAWEI_PUSH_KIT_CLIENT_ID=<HUAWEI_PUSH_KIT_CLIENT_ID>
HUAWEI_PUSH_KIT_CLIENT_SECRET=<HUAWEI_PUSH_KIT_CLIENT_SECRET>
```

# 🚀 Usage

```ruby
require 'huawei_push_kit'

device_token = "<huawei_device_token>"
client = HuaweiPushKit::Client.new

# Send notification to a single Huawei device with custom payload
client.send_push(
  {
    'validate_only' => false,
    'message' =>
    {
      'android' => {
        'notification' => {
          'title' => 'message title',
          'body' => 'message body'
          'click_action' => { 'type' => 3 },
          'badge' => {
            'add_num' => 1,
            'class' => 'com.huawei.codelabpush.MainActivity',
            'set_num' => 10
          }
        },
        'ttl' => '1000'
      },
      'token' => [device_token]
    }
  }
)

# Send notification to a single Huawei device
client.send_push_notification(device_token, "Title", "Message")

# Subscribe to a topic
client.subscribe_to_topic("topic_name", device_token)

# Show all topics
client.topic_list(device_token)

# Send notification to a topic
client.send_push_notification_to_topic(topic_name, "Title", "Message", "topic_name")

# Unsubscribe from a topic
client.unsubscribe_from_topic("topic_name", device_token)

```

# 🤝 Contributing
Contributions are welcome! If you would like to contribute to this gem, please fork the repository and submit a pull request. Make sure to follow the existing code style and include tests for your changes.

# 🔗 RubyGems
You can find the gem on RubyGems: [huawei-push-kit](https://rubygems.org/gems/huawei-push-kit).

# 🔓 License
This gem is available as open source under the terms of the MIT License. See the LICENSE file for more details.
