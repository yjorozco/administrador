const HttpError = require('../models/Error');
const { validationResult } = require('express-validator');
const bcrypt = require('bcrypt');
const fs = require('fs');
const db = require('../database/asociaciones');

exports.getTodosUsuarios = async (req, res, next) => {
    try {
        const usuarios = await db.Usuarios.findAll({ attributes: { exclude: ['password'] }, include: [{ model: db.Roles, as: 'Roles' }] });
        res.status(200).json({
            usuarios
        })
    } catch (e) {
        console.log(e);
        const error = new HttpError('Ocurrio un error al encontrar los usuarios', 500);
        return next(error);
    }
}

exports.agregarUsuario = async (req, res, next) => {
    const errors = validationResult(req);
    const t = await db.sequelize.transaction();
    try {
        if (!errors.isEmpty()) {
            console.log(errors);
            next(new HttpError('Datos invalidos', 422));
        }
        let {
            nombre,
            apellido,
            foto,
            direccion,
            telefono,
            correo,
            password,
            roles } = await req.body;

        const passwordHash = await bcrypt.hash(password, 10);
        if(foto) foto='avatar.png';
        const usuario = await db.Usuarios.create({
            nombre,
            apellido,
            foto,
            direccion,
            telefono,
            correo,
            activo: true,
            'password': passwordHash,

        }, {
            include: [{ model: db.Roles, as: 'Roles' }],
            fields: [
                'nombre',
                'apellido',
                'foto',
                'direccion',
                'telefono',
                'correo',
                'activo',
                'password'
            ], transaction: t
        })
        if (roles)
            await usuario.setRoles(roles, { fields: ["id_usuarios", "id_roles"], transaction: t });
        await t.commit();
        res.status(201).json({ mensaje: 'usuario creado' });
    } catch (e) {
        console.log(e);
        try {
            await t.rollback();
        } catch (e) {
            console.log(e);
        }
        const error = new HttpError('No se puede crear el usuario', 500);
        return next(error)

    }

}

exports.getUsuarioPorId = async (req, res, next) => {
    const id = await req.params.id;
    let usuario;
    try {
        usuario = await db.Usuarios.findOne({
            attributes: { exclude: ['password'] },
            include: [{ model: db.Roles, as: 'Roles' }],
            where: {
                id
            }
        })
    } catch (err) {
        console.log(err);
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
    const t = await db.sequelize.transaction();

    const {
        nombre,
        apellido,
        foto,
        direccion,
        telefono,
        correo,
        password,
        roles } = req.body;
    let usuario;
    let fotoVieja;
    const passwordHash = await bcrypt.hash(password, 10);
    try {
        if (!errors.isEmpty()) {
            console.log(errors);
            next(new HttpError('Datos invalidos', 422));
        }
        usuario = await db.Usuarios.findOne({
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
        fotoVieja = usuario.foto;

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
            'password': passwordHash
        }

        if (password === '') delete cuerpo['password'];
        await db.Usuarios.update(cuerpo,
            {
                where: { id },
                transaction: t
            });
        const usuario = await db.Usuarios.findOne({ where: { id: id }, include: [{ model: db.Roles, as: 'Roles' }], transaction: t })
        await usuario.removeRoles(usuario.Roles, { transaction: t });
        if (roles)
            await usuario.addRoles(roles, { fields: ["id_usuarios", "id_roles"], transaction: t });
        await t.commit();
        if (foto && foto != fotoVieja && foto!='avatar.png') fs.unlinkSync('../upload/' + fotoVieja);
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
    const t = await db.sequelize.transaction();
    try {
        const { id } = await req.params;
        if (!id) new Error("el id no debe estar nulo");
        const usuario = await db.Usuarios.findOne({
            attributes: [
                'id',
                'nombre',
                'apellido',
                'foto',
            ],
            where: {
                id
            },
            include: [{ model: db.Roles, as: 'Roles' }],
        });


        const fotoVieja = await usuario.foto;
        await usuario.removeRoles(usuario.Roles, { transaction: t });
        await db.Usuarios.destroy({
            where: {
                id
            }
            , transaction: t
        })
        await t.commit();
        if (fotoVieja && fotoVieja != 'avatar.png') fs.unlinkSync('../upload/' + fotoVieja);
        res.status(201).json({
            message: 'Usuario eliminado de forma satisfactoria'
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


exports.cambiarPassword = async (req, res, next) => {
    const errors = validationResult(req);
    const t = await db.sequelize.transaction();
    try {
        if (!errors.isEmpty()) {
            console.log(errors);
            next(new HttpError('Datos invalidos', 422));
        }

        const {
            correo,
            password
        } = req.body;
        const usuario = await db.Usuarios.findOne({
            where: {
                correo
            }
        })
        if (!usuario) {
            const error = new HttpError('usuaro no existe', 404);
            return next(error);
        }
        const nuevoPasswordHash = await bcrypt.hash(password, 10);
        await db.Usuarios.update({ password: nuevoPasswordHash },
            {
                where: { id: usuario.id },
                transaction: t
            });
        await t.commit();
        return res.status(200).json({
            message: "Password cambiado",

        })
    } catch (e) {
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

exports.actualizarPerfil = async (req, res, next) => {
    const { id } = await req.params;
    const errors = validationResult(req);
    const t = await db.sequelize.transaction();

    const {
        nombre,
        apellido,
        foto,
        direccion,
        telefono,
        correo,
        password
     } = req.body;
    let usuario;
    let fotoVieja;
    const passwordHash = await bcrypt.hash(password, 10);
    try {
        if (!errors.isEmpty()) {
            console.log(errors);
            next(new HttpError('Datos invalidos', 422));
        }
        usuario = await db.Usuarios.findOne({
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
        fotoVieja = usuario.foto;

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
            'password': passwordHash
        }

        if (password === '') delete cuerpo['password'];
        await db.Usuarios.update(cuerpo,
            {
                where: { id },
                transaction: t
            });
        await t.commit();
        if (foto && foto != fotoVieja && foto!='avatar.png') fs.unlinkSync('../upload/' + fotoVieja);
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

exports.salvarImagen = async (req, res, next) => {
    try {

        return res.status(200).json({
            message: "Imagen almacenada",
            nombre: req.file.filename
        })

    } catch (e) {
        console.log(e);
        const error = new HttpError('No se puede guardar la imagen', 422);
        return next(error)
    }
}