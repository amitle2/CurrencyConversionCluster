const redisClient = require('./redisClient');
const axios = require('axios');

async function updateRates() {
  try {
    const response = await axios.get('https://api.exchangerate-api.com/v4/latest/ILS');
    const rates = response.data.rates;

    for (const [currency, rate] of Object.entries(rates)) {
      await redisClient.set(currency, rate);
    }

    console.log('Rates updated successfully');
  } catch (error) {
    console.error('Failed to update rates:', error.message);
  }
}

module.exports = updateRates;
