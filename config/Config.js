const config = require('config');


const configuracion = (conexion) => {

    if (conexion == "DB") {
        return configuracionBD();
    } else {
        return configuracionEmail();
    }
}

const configuracionBD = () => {
    const dbConfig = config.get('Config.dbConfig');
    return dbConfig;
}

const configuracionEmail =  () => {
    const Email = config.get('Config.Email');
    return Email; 
}

module.exports = configuracion;


