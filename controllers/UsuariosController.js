const Usuarios = require('../models/Usuarios');
const HttpError = require('../models/Error');
const { validationResult } = require('express-validator');
const UsuariosRoles = require('./../models/UsuariosRoles')
const sequelize = require('../database/database');
const bcrypt = require('bcrypt');


exports.getTodosUsuarios = async (req, res, next) => {
    try {
        const usuarios = await Usuarios.findAll();
        res.status(200).json({
            usuarios
        })
    } catch (e) {
        console.log(e);
        const error = new HttpError('Ocurrio un error al encontrar los usuarios', 422);
        return next(error)
    }
}

exports.agregarUsuario = async (req, res, next) => {
    const errors = validationResult(req);
    const t = await sequelize.transaction();
    try {
        if (!errors.isEmpty()) {
            console.log(errors);
            next(new HttpError('Datos invalidos', 422));
        }
        const {
            nombre,
            apellido,
            foto,
            direccion,
            telefono,
            correo,
            password,
            roles } = req.body;
        
        const passwordHash = await bcrypt.hash(password, 10);
        console.log(passwordHash);
        const usuario = await Usuarios.create({
            nombre,
            apellido,
            foto,
            direccion,
            telefono,
            correo,
            'password':passwordHash
        }, {
            fields: [
                'nombre',
                'apellido',
                'foto',
                'direccion',
                'telefono',
                'correo',
                'password'
            ], transaction: t
        })

        if (roles) {
            for (const rol of roles) {
                let usuariosRoles = await UsuariosRoles.create({
                    id_usuarios: usuario.id,
                    id_roles: rol
                }, {
                    fields: [
                        'id_usuarios',
                        'id_roles'
                    ], transaction: t
                })
            }
        }

        await t.commit();
        res.status(201).json({ mensaje: 'usuario creado', usuario });
    } catch (e) {
        console.log(e);
        try {
            await t.rollback();
        } catch (e) {
            console.log(e);
        }
        const error = new HttpError('No se puede crear el usuario', 422);
        return next(error)

    }

}

exports.getUsuarioPorId = async (req, res, next) => {
    const id = await req.params.id;
    let usuario;
    try {
        usuario = await Usuarios.findOne({
            where: {
                id
            }
        })
    } catch (err) {
        const error = new HttpError('hay un error, no se puede encontrar el usuario', 500);
        return next(error);
    }
    if (!usuario) {
        const error = next(new HttpError('no se puede encontrar el usuario con el id suministrado', 404));
        return next(error);
    }
    res.status(200).json({ usuario });
}

exports.actualizarUsuario = async (req, res, next) => {
    const { id } = await req.params;
    const errors = validationResult(req);
    const t = await sequelize.transaction();
    const {
        nombre,
        apellido,
        foto,
        direccion,
        telefono,
        correo,
        password,
        roles } = req.body;
    let usuario

    const passwordHash = await bcrypt.hash(password, 10);
    try {
        if (!errors.isEmpty()) {
            console.log(errors);
            next(new HttpError('Datos invalidos', 422));
        }
        usuario = await Usuarios.findOne({
            attributes: [
                'id',
                'nombre',
                'apellido',
                'foto',
                'direccion',
                'telefono',
                'correo', 
                'password'
            ],
            where: {
                id
            }
        })

    } catch (e) {
        const error = new HttpError('hay un error, no se puede encontrar el usuario', 500);
        return next(error);
    }
    if (!usuario) {
        const error = next(new HttpError('no se puede encontrar el usuario con el id suministrado', 404));
        return next(error);
    }
    try {
        
        let cuerpo = {
            nombre,
            apellido,
            foto,
            direccion,
            telefono,
            correo,
            'password':passwordHash
        }
        
        if (password==='') delete cuerpo['password'];
        await Usuarios.update(cuerpo,
            {
                where: { id },
                transaction: t
            });
        await UsuariosRoles.destroy({
            where: {
                id_usuarios: usuario.id
            }
            , transaction: t
        });
        if (roles) {
            for (const rol of roles) {
                let usuariosRoles = await UsuariosRoles.create({
                    id_usuarios: usuario.id,
                    id_roles: rol
                }, {
                    fields: [
                        'id_usuarios',
                        'id_roles'
                    ], transaction: t
                })
            }
        }

        await t.commit();
        return res.status(200).json({
            message: "Usuario actualizado",
            
        })
    } catch (e) {
        try {
            await t.rollback();
        } catch (e) {
            console.log(e);
        }
        console.log(e);
        const error = new HttpError('hay un error, no se puede encontrar el usuario', 500);
        return next(error);
    }
}

exports.eliminarUsuario = async (req, res, next) => {
    const t = await sequelize.transaction();
    try {
        const { id } = await req.params;
        await UsuariosRoles.destroy({
            where: {
                id_usuarios: id
            }
            , transaction: t
        });
        await Usuarios.destroy({
            where: {
                id
            }
            , transaction: t
        })
        await t.commit();
        res.status(201).json({
            message: 'Usuario eliminado de forma satisfactoria',
            // count: cantidadEliminada
        })
    } catch (e) {
        console.log(e);
        try {
            await t.rollback();
        } catch (e) {
            console.log(e);
        }
        const error = new HttpError('el usuario no se puede eliminar', 500);
        return next(error);
    }
}


exports.cambiarPassword =  async (req, res, next) => {
    const errors = validationResult(req);
    const t = await sequelize.transaction();
    console.log(req.user);
    try {
        if (!errors.isEmpty()) {
            console.log(errors);
            next(new HttpError('Datos invalidos', 422));
        }

        const {
            correo,
            password
        } = req.body;
        const usuario = await Usuarios.findOne({
            where: {
                correo
            }
        })
        if(!usuario){
            const error = new HttpError('usuaro no existe', 404);
            return next(error);
        }
        const nuevoPasswordHash = await bcrypt.hash(password, 10);
        await Usuarios.update({password:nuevoPasswordHash},
            {
                where: { id:usuario.id },
                transaction: t
            });
        

        await t.commit();
        return res.status(200).json({
            message: "Password cambiado",
            
        })
        
    }catch (e) {
        console.log(e);
        try {
            await t.rollback();
        } catch (e) {
            console.log(e);
        }
        const error = new HttpError('No se puede actualizar el password', 422);
        return next(error)
    }
}