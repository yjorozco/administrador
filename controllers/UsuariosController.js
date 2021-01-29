const Usuarios = require('../models/Usuarios');
const HttpError = require('../models/Error');
const { validationResult } = require('express-validator');


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
            correo } = req.body;
        const usuario = await Usuarios.create({
            nombre,
            apellido,
            foto,
            direccion,
            telefono,
            correo
        }, {
            fields: [
                'nombre',
                'apellido',
                'foto',
                'direccion',
                'telefono',
                'correo'
            ]
        })
        res.status(201).json({ mensaje: 'usuario creado', usuario });
    } catch (e) {
        console.log(e);
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
    const {
        nombre,
        apellido,
        foto,
        direccion,
        telefono,
        correo } = req.body;
    let usuario
    try {
        usuario = await Usuarios.findOne({
            attributes: [
                'id',
                'nombre',
                'apellido',
                'foto',
                'direccion',
                'telefono',
                'correo'
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
        usuario = await Usuarios.update({
            nombre,
            apellido,
            foto,
            direccion,
            telefono,
            correo
        },
            {
                where: { id }
            })
        console.log(usuario);
        return res.status(200).json({
            message: "Usuario actualizado",
            usuario
        })
    } catch (err) {
        const error = new HttpError('hay un error, no se puede encontrar el usuario', 500);
        return next(error);
    }
}

exports.eliminarUsuario = async (req, res, next) => {
    try {
        const { id } = await req.params;
        const cantidadEliminada = await Usuarios.destroy({
            where: {
                id
            }
        })
        res.json({
            message: 'Usuario eliminado de forma satisfactoria',
            count: cantidadEliminada
        })
    } catch (e) {
        console.log(e);
        const error = new HttpError('el usuario no se puede eliminar', 500);
        return next(error);
    }
}


