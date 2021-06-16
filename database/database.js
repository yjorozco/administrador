const Sequelize= require('sequelize');
const configuracion = require('../config/Config');


const config = configuracion("DB");


const sequelize = new Sequelize(
    config.database,
    config.user,
    config.password,
    {
        host: config.host,
        dialect:config.dialect,
        pool: {
            max:config.pool.max,
            min:config.pool.min,
            require: config.pool.require,
            idle: config.idle
        },
        logging: config.logging
    },
    
);

module.exports = sequelize;

