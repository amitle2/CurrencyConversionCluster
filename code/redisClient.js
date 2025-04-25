const redis = require('redis');
const client = redis.createClient({ url: 'redis://redis:6379' });

client.connect().catch(console.error);

module.exports = client;