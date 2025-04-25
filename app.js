const express = require('express');
const redisClient = require('./code/redisClient');

const app = express();
const PORT = process.env.PORT || 3000;

app.get('/convert/:currency', async (req, res) => {
    const currency = req.params.currency.toUpperCase();
    try {
        const rate = await redisClient.get(currency);
        if (rate) {
            res.json({ currency, rate: parseFloat(rate) });
        } else {
            res.status(404).json({ error: 'Currency not found in cache' });
        }
    } catch(err) {
        res.status(500).json({ error: 'Internal Server Error'});
    }
});

app.listen(PORT, () => {
    console.log(`Currency API rinning on port: ${PORT}`);
})
