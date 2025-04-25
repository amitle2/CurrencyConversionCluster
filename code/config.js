const updateRates = require('./fetchRates');

setInterval(updateRates, 60 * 1000);
updateRates();
