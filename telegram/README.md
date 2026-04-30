# Telegram Bot API Add-on

[![Latest Release](https://img.shields.io/github/v/release/rezusnet/hassio-addons?label=Latest%20Release)](https://github.com/rezusnet/hassio-addons/releases)
[![Project Stage](https://img.shields.io/badge/project%20stage-production%20ready-brightgreen.svg)](https://github.com/rezusnet/hassio-addons#readme)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE.md)
[![Open your Home Assistant instance and show the add-on store page of the add-on.](https://my.home-assistant.io/badges/supervisor_addon.svg)](https://my.home-assistant.io/redirect/supervisor_addon/?addon=telegram)

![Telegram Banner](banner.svg)

## About

Telegram Bot API is a local Bot API server that allows you to run your own Telegram Bot API server. This gives you complete control over your bot infrastructure, removes rate limits, and eliminates dependency on external services. Perfect for home automation and self-hosted deployments.

## Key Features

- 🤖 **Local Bot Control**: Run your own Telegram Bot API server
- 🚀 **No Rate Limits**: Unlimited bot requests
- 🔒 **Private Deployment**: Complete data privacy
- 📱 **Full API Support**: All Telegram Bot API methods supported
- 💾 **Self-Hosted**: Keep all data on your hardware
- 🔧 **Custom Webhooks**: Set up webhooks for bot updates
- 📊 **Easy Integration**: Works with all Telegram bot frameworks

## Installation

1. Add the add-on repository (if not already added)
2. Install the Telegram Bot API add-on from the add-on store
3. Configure API credentials (see DOCS.md for details)
4. Start the add-on
5. Configure your bots to use the local API endpoint

## Quick Access

- **API Endpoint**: `http://<your-host>:8081`
- **Bot Token**: Use format `1234567890:ABCdefGHIjklMNOpqrsTUVwxyzABCDEFGH`

## Bot Integration

After starting the add-on, you can point your bot client to the local API:

```
# Using python-telegram-bot
bot = Bot(token="YOUR_BOT_TOKEN", base_url="http://localhost:8081")

# Using telebot
bot = telebot.TeleBot("YOUR_BOT_TOKEN", api_server="http://localhost:8081")
```

## Support & Documentation

For detailed configuration and bot integration examples, see [DOCS.md](DOCS.md).

For upstream documentation and source code, visit:
- **GitHub**: https://github.com/tdlib/telegram-bot-api
- **Telegram API**: https://core.telegram.org/bots/api
- **Telegram Documentation**: https://core.telegram.org/
