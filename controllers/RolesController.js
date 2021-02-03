const Roles = require('../models/Roles');
const HttpError = require('../models/Error');
const { validationResult } = require('express-validator');
const RolesPermisos = require('./../models/RolesPermisos')
const sequelize = require('../database/database');

exports.getTodosRoles = async (req, res, next) => {
    try {
        const roles = await Roles.findAll();
        res.status(200).json({
            roles
        })
    } catch (e) {
        console.log(e);
        const error = new HttpError('Ocurrio un error al encontrar los roles', 422);
        return next(error)
    }
}

exports.agregarRol = async (req, res, next) => {
    const errors = validationResult(req);
    const t = await sequelize.transaction();
    try {
        if (!errors.isEmpty()) {
            console.log(errors);
            next(new HttpError('Datos invalidos', 422));
        }
        const { nombre, permisos } = req.body;
        const nuevoRol = await Roles.create({
            nombre
        }, {
            fields: [
                'nombre'
            ]
        })
        if (permisos) {
            for (const permiso of permisos) {
                let rolesPermisos = await RolesPermisos.create({
                    id_permisos: permiso,
                    id_roles: nuevoRol.id
                }, {
                    fields: [
                        'id_permisos',
                        'id_roles'
                    ], transaction: t
                })
            }
        }

        await t.commit();
        res.status(201).json({ mensaje: 'rol creado', rol: nuevoRol });
    } catch (e) {
        console.log(e);
        try {
            await t.rollback();
        } catch (e) {
            console.log(e);
        }
        const error = new HttpError('No se puede crear el rol', 422);
        return next(error)

    }

}

exports.getRolPorId = async (req, res, next) => {
    const id = await req.params.id;
    let rol;
    try {
        rol = await Roles.findOne({
            where: {
                id
            }
        })
    } catch (err) {
        const error = new HttpError('hay un error, no se puede encontrar el rol', 500);
        return next(error);
    }
    if (!rol) {
        const error = next(new HttpError('no se puede encontrar el rol con el id suministrado', 404));
        return next(error);
    }
    res.status(200).json({ rol });
}

exports.actualizarRol = async (req, res, next) => {
    const { id } = await req.params;
    const { nombre, permisos } = await req.body;
    const errors = validationResult(req);
    const t = await sequelize.transaction();
    let rol
    try {
        if (!errors.isEmpty()) {
            console.log(errors);
            next(new HttpError('Datos invalidos', 422));
        }
        rol = await Roles.findOne({
            attributes: ['nombre', 'id'],
            where: {
                id
            }, transaction: t
        })
    } catch (e) {
        const error = new HttpError('hay un error, no se puede encontrar el rol', 500);
        return next(error);
    }
    if (!rol) {
        const error = next(new HttpError('no se puede encontrar el rol con el id suministrado', 404));
        return next(error);
    }
    try {
        await Roles.update({
            nombre
        },
            {
                where: { id },
                transaction: t
            })
        await RolesPermisos.destroy({
            where: {
                id_roles: rol.id
            }
            , transaction: t
        });
        if (permisos) {
            for (const permiso of permisos) {
                let rolesPermisos = await RolesPermisos.create({
                    id_permisos: permiso,
                    id_roles: rol.id
                }, {
                    fields: [
                        'id_permisos',
                        'id_roles'
                    ], transaction: t
                })
            }
        }
        await t.commit();
        return res.status(200).json({
            message: "Rol actualizado"
        })
    } catch (e) {
        console.log(e);
        try {
            await t.rollback();
        } catch (e) {
            console.log(e);
        }
        const error = new HttpError('hay un error, no se puede encontrar el rol', 500);
        return next(error);
    }
}

exports.eliminarRol = async (req, res, next) => {
    const t = await sequelize.transaction();
    try {
        const { id } = await req.params;

        await RolesPermisos.destroy({
            where: {
                id_roles: id
            }
            , transaction: t
        });
        await Roles.destroy({
            where: {
                id
            }, transaction: t
        })
        await t.commit();
        res.json({
            message: 'Rol eliminado de forma satisfactoria',
        })
    } catch (err) {      
        console.log(err); 
        try {
            await t.rollback();
        } catch (e) {
            console.log(e);
        }
      
        const error = new HttpError('el rol no se puede eliminar', 500);
        return next(error);
    }
}


