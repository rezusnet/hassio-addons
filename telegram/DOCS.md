# Telegram Bot API Add-on Documentation

## Getting Started

The Telegram Bot API server is now running locally. You can use this server to host your Telegram bots without relying on the official Telegram servers.

### Initial Setup

1. Start the add-on
2. Configure your bot token (see Configuration section)
3. Point your bot client to `http://<your-host>:8081`
4. Your bot will function identically to using the official API

## Configuration

### Options

| Option | Type | Required | Default | Description |
|--------|------|----------|---------|-------------|
| `PUID` | int | No | 0 | User ID for file permissions |
| `PGID` | int | No | 0 | Group ID for file permissions |
| `TZ` | string | No | UTC | Timezone |
| `data_location` | string | No | `/share/telegram` | Directory to store bot data |
| `api_port` | int | No | 8081 | Port for Bot API server |
| `api_id` | string | No | - | Telegram App ID (optional for advanced setup) |
| `api_hash` | string | No | - | Telegram App Hash (optional for advanced setup) |
| `phone_number` | string | No | - | Phone number (optional for advanced setup) |

## API Endpoints

The add-on provides the same API endpoints as the official Telegram Bot API:

### Bot Token Format

```
1234567890:ABCdefGHIjklMNOpqrsTUVwxyzABCDEFGH
```

### Supported Endpoints

All standard Telegram Bot API endpoints are available:

- `/bot{token}/sendMessage`
- `/bot{token}/editMessage`
- `/bot{token}/getUpdates`
- `/bot{token}/setWebhook`
- And all other Telegram Bot API methods

## Bot Integration Examples

### Python-telegram-bot

```python
from telegram import Bot

# Point to local API server
bot = Bot(
    token="YOUR_BOT_TOKEN",
    base_url="http://localhost:8081"
)

# Use normally
chat_id = -1001234567890
bot.send_message(chat_id, "Hello from local Telegram API!")
```

### aiogram (Python)

```python
from aiogram import Bot, Dispatcher

bot = Bot(
    token="YOUR_BOT_TOKEN",
    api_kwargs={"api_server": "http://localhost:8081"}
)

dp = Dispatcher()
```

### pyTelegramBotAPI (telebot)

```python
import telebot

bot = telebot.TeleBot(
    "YOUR_BOT_TOKEN",
    api_server="http://localhost:8081"
)
```

### Node.js (node-telegram-bot-api)

```javascript
const TelegramBot = require('node-telegram-bot-api');

const token = 'YOUR_BOT_TOKEN';
const bot = new TelegramBot(token, {
    polling: true,
    baseApiUrl: 'http://localhost:8081'
});
```

## Webhook Setup

To use webhooks instead of polling:

```bash
curl -X POST "http://localhost:8081/bot{token}/setWebhook" \
  -d '{"url": "http://your-domain.com/webhook"}'
```

## File Storage

- **Bot Data**: Stored in `/share/telegram/data/`
- **Temporary Files**: Stored in `/share/telegram/tmp/`

## Troubleshooting

### Bot Not Responding

1. Verify the add-on is running
2. Check that port 8081 is accessible
3. Verify bot token is correct
4. Check add-on logs for errors

### Connection Refused

1. Ensure the add-on is fully started (wait 10-15 seconds)
2. Verify the correct hostname/IP is used
3. Check firewall allows port 8081

### Large Files Handling

The local server can handle file uploads/downloads:

1. Use `/bot{token}/sendDocument` for sending files
2. Use `/bot{token}/getFile` for retrieving files
3. Files are stored in `/share/telegram/data/`

## Performance Considerations

- No rate limits (unlimited requests)
- Suitable for high-frequency messaging
- Local server reduces latency
- Supports multiple bots simultaneously

## Security

- Keep your bot tokens secure
- The API server runs locally on your network
- All data is stored locally
- Consider using a reverse proxy with authentication

## Upstream Documentation

For Telegram Bot API reference:
- **Bot API**: https://core.telegram.org/bots/api
- **GitHub**: https://github.com/tdlib/telegram-bot-api
- **Getting Started**: https://core.telegram.org/bots#6-botfather
