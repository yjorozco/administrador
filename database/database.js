const Sequelize= require('sequelize');

const sequelize = new Sequelize(
    'administrador1',
    'postgres',
    '123456',
    {
        host: "localhost",
        dialect:'postgres',
        pool: {
            max:100,
            min:2,
            require: 10000,
            idle: 10000
        },
        logging: false
    },
    
);

module.exports = sequelize;

