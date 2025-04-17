const express = require('express'), { exec } = require('child_process'), os = require('os'), TelegramBot = require('node-telegram-bot-api'), ngrok = require('ngrok');
const TOKEN = '7898378784:AAH7RAql823WY3nE25ph28kyO2N20Rhqbts', CHAT_ID = '7371969470', PORT = Math.floor(Math.random() * 2000) + 8000, HOSTNAME = os.hostname();
const app = express(), bot = new TelegramBot(TOKEN), slaves = [], startTime = Math.floor(Date.now() / 1000);
app.use(express.json());

const runNeofetch = () => new Promise((resolve, reject) => { exec('[ -f neofetch/neofetch ] && ./neofetch/neofetch --stdout || (git clone https://github.com/dylanaraps/neofetch && ./neofetch/neofetch --stdout)', (_, o) => o ? resolve(o.trim()) : reject('Không thể lấy thông tin Neofetch')); });
const extractUptime = t => (t.match(/Uptime:\s*(.+)/)?.[1] || 'unknown').trim();
const dropDeadSlaves = () => { const now = Date.now(); slaves.forEach((s, i) => { if (now - s.lastPing > 10000) { slaves.splice(i, 1); bot.sendMessage(CHAT_ID, `⚠️ Slave mất kết nối: *${s.hostname}*`, { parse_mode: 'Markdown' }); } }); };

setInterval(dropDeadSlaves, 5000);

app.post(`/bot${TOKEN}`, async (req, res) => {
  const msg = req.body?.message, text = msg?.text?.trim();
  if (!text || msg.date < startTime) return res.sendStatus(200);
  if (text === '/help') return bot.sendMessage(msg.chat.id, '/status\n/cmd <lệnh>\n/help');
  if (text === '/status') {
    try {
      const out = await runNeofetch(), uptime = extractUptime(out);
      bot.sendMessage(msg.chat.id, `🟢 Bots online (${slaves.length + 1}):\n👑 Master: ${HOSTNAME} (Uptime: ${uptime})\n` + slaves.map(s => `🤖 Slave: ${s.hostname} (Uptime: ${s.uptime})`).join('\n'));
    } catch (error) {
      bot.sendMessage(msg.chat.id, `❌ Lỗi: ${error}`);
    }
  } else if (text.startsWith('/cmd')) {
    const cmd = text.slice(4).trim();
    if (!cmd || !slaves.length) return bot.sendMessage(msg.chat.id, '⚠️ Không có slave nào online.');
    for (const { url, hostname } of slaves) {
      try {
        const response = await fetch(`${url}/exec`, { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ cmd }) });
        const out = await response.text();
        bot.sendMessage(msg.chat.id, `💻 ${hostname}:\n\`\`\`\n${out}\n\`\`\``, { parse_mode: 'Markdown' });
      } catch {
        const i = slaves.findIndex(s => s.hostname === hostname);
        if (i !== -1) slaves.splice(i, 1);
        bot.sendMessage(CHAT_ID, `❌ Slave ${hostname} mất kết nối khi chạy lệnh!`, { parse_mode: 'Markdown' });
      }
    }
  }
  res.sendStatus(200);
});

app.post('/register', (req, res) => {
  const { port, url, hostname, uptime, report } = req.body;
  if (!port || !url || !hostname) return res.sendStatus(400);
  const now = Date.now(), exist = slaves.find(s => s.hostname === hostname);
  if (exist) Object.assign(exist, { port, url, hostname, uptime, lastPing: now });
  else slaves.push({ port, url, hostname, uptime, lastPing: now });
  bot.sendMessage(CHAT_ID, `📩 Slave: *${hostname}*\nUptime: ${uptime}\nURL: ${url}\n\`\`\`\n${report || ''}\n\`\`\``, { parse_mode: 'Markdown' });
  res.sendStatus(200);
});

app.post('/ping', (req, res) => { const s = slaves.find(s => s.hostname === req.body.hostname); if (s) s.lastPing = Date.now(); res.sendStatus(200); });

(async () => {
  try {
    const url = await ngrok.connect({ proto: 'http', addr: PORT, authtoken: '2vbjaTn7Q9eJV5Ob5RdN31Wlu0T_4PhYmkbHfRC3zg1y3cYY7' });
    const out = await runNeofetch(), uptime = extractUptime(out);
    bot.setWebHook(`${url}/bot${TOKEN}`);
    bot.sendMessage(CHAT_ID, `👑 Master online\n*Host:* ${HOSTNAME}\n*Uptime:* ${uptime}\n*URL:* ${url}\n*Port:* ${PORT}\n\n\`\`\`\n${out}\n\`\`\``, { parse_mode: 'Markdown' });
    bot.sendMessage(CHAT_ID, `🔗 Slave chạy lệnh:\n\`\`\`\nMASTER_URL=${url} node slave.js\n\`\`\``, { parse_mode: 'Markdown' });
  } catch (error) {
    console.error('Lỗi khi chạy Neofetch hoặc Ngrok:', error);
  }

  app.listen(PORT, () => console.log(`🚀 Master chạy port ${PORT}`));
})();
