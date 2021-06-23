const db = require('../database/asociaciones');
const HttpError = require('../models/Error');

const ACL = (permiso) => {
    return async (req, res, next) => {
        let usuario = await req.user;
        usuario = await db.Usuarios.findOne({ where: { id: usuario.id }, include: [{ model: db.Roles, as: 'Roles', include: [{ model: db.Permisos, as: 'Permisos' }] }] });  
        const permiso_usuario = usuario.Roles.find(r => r.Permisos.find(p =>  { return p.nombre === permiso}));
        if(!permiso_usuario) return next(new HttpError('No esta autorizado', 403));
        next()
    };
}


module.exports = ACL;