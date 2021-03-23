const HttpError = require('../models/Error');
const { validationResult } = require('express-validator');
const db = require('../database/asociaciones')
const bcrypt = require('bcrypt');
const cryptoRandomString = require('crypto-random-string');
const enviarCorreo = require('../helpers/email');


exports.registrarUsuario = async (req, res, next) => {
    const errors = validationResult(req);
    const t = await db.sequelize.transaction();
    try {
        if (!errors.isEmpty()) {
            console.log(errors);
            next(new HttpError('Datos invalidos', 422));
        }
        const {
            nombre,
            apellido,
            direccion,
            telefono,
            correo,
            password
        } = req.body;

        const foto='avatar.png';

        const passwordHash = await bcrypt.hash(password, 10);
        const codigo_activacion = cryptoRandomString({ length: 10 });
        const usuario = await db.Usuarios.create({
            nombre,
            apellido,
            direccion,
            telefono,
            correo,
            foto,
            activo: false,
            codigo_activacion,
            'password': passwordHash
        }, {
            fields: [
                'nombre',
                'apellido',
                'direccion',
                'telefono',
                'correo',
                'activo',
                'codigo_activacion',
                'password'
            ], transaction: t
        })
        const roles = await db.Roles.findOne({
            where: {
                nombre: 'Usuario'
            }
        })
        await usuario.setRoles(roles, { fields: ["id_usuarios", "id_roles"], transaction: t });
        const asunto = "Activación de usuario";
        const cuerpo = "Su codigo de activación es " + codigo_activacion;
        await enviarCorreo(usuario.correo, asunto, cuerpo);

        await t.commit();
        res.status(201).json({ mensaje: 'usuario creado, verifique por correo su codigo de activación' });
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


exports.recuperarPassword = async (req, res, next) => {
    const errors = validationResult(req);
    const t = await db.sequelize.transaction();
    try {
        if (!errors.isEmpty()) {
            console.log(errors);
            next(new HttpError('Datos invalidos', 422));
        }

        const nuevoPassword = cryptoRandomString({ length: 10 });
        const {
            correo
        } = req.body;
        const usuario = await db.Usuarios.findOne({
            where: {
                correo
            }
        })
        if (!usuario) {
            const error = new HttpError('usuario no existe', 404);
            return next(error);
        }
        const nuevoPasswordHash = await bcrypt.hash(nuevoPassword, 10);
        await db.Usuarios.update({ password: nuevoPasswordHash },
            {
                where: { id: usuario.id },
                transaction: t
            });
        const asunto = "Recuperación de Contraseña";
        const cuerpo = "Su nueva contraseña es " + nuevoPassword;
        await enviarCorreo(usuario.correo, asunto, cuerpo);
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
        const error = new HttpError('No se puede actualizar el password', 500);
        return next(error)
    }
}

exports.activarUsuario = async (req, res, next) => {
    const errors = validationResult(req);
    const t = await db.sequelize.transaction();

    try {
        if (!errors.isEmpty()) {
            console.log(errors);
            next(new HttpError('Datos invalidos', 422));
        }


        const { codigo_activacion } = req.body;

        const usuario = await db.Usuarios.findOne({
            where: {
                codigo_activacion
            }
        })

        if (usuario && usuario.codigo_activacion != '') {
            await db.Usuarios.update({ activo: true, codigo_activacion: '' },
                {
                    where: { codigo_activacion, activo: false },
                    transaction: t
                });
        } else {
            throw Error('Error al activar el usuario');
        }
        const asunto = "Activación de usuario";
        const cuerpo = "Su usuario ha sido activado";
        await enviarCorreo(usuario.correo, asunto, cuerpo);
        await t.commit();
        return res.status(200).json({
            message: "Usuario activado"
        })
    } catch (e) {
        console.log(e);
        try {
            await t.rollback();
        } catch (e) {
            console.log(e);
        }
        const error = new HttpError('No se pudo realizar el proceso de activación', 422);
        return next(error)
    }
}