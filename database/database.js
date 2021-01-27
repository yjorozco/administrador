const Sequelize= require('sequelize');

const sequelize = new Sequelize(
    'administrador',
    'postgres',
    '123456',
    {
        host: "localhost",
        dialect:'postgres',
        pool: {
            max:5,
            min:0,
            require: 10000,
            idle: 10000
        },
        logging: false
    },
    
);

module.exports = sequelize;

