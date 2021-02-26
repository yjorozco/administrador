const db = require('../database/asociaciones');

const ACL = (permiso) => {
    return async (req, res, next) => {
        let usuario = req.user;
        usuario = await db.Usuarios.findOne({ where: { id: usuario.id }, include: [{ model: db.Roles, as: 'Roles' }] });
               
        next()
    };
}

module.exports = ACL;