const HttpError = require('../models/Error');
const { validationResult } = require('express-validator');
const db = require('../database/asociaciones');



exports.getPaises = async (req, res, next) => {
    try {
        const paises = await db.Paises.findAll();
        res.status(200).json({
            paises
        })
    } catch (e) {
        console.log(e);
        const error = new HttpError('ocurrio un error al encontrar los paises', 500);
        return next(error)
    }
}

exports.getEstadosPorPais = async (req, res, next) => {
    const { pais } = await req.params;
    console.log(pais)
    let estado;
    try {
        estado = await db.Estados.findAll({
            where: {
                pais
            }
        })
    } catch (err) {
        const error = new HttpError('hay un error, no se pueden encontrar los estados', 500);
        return next(error);
    }
    if (!estado) {
        const error = next(new HttpError('no se puede encontrar el estado con el id suministrado', 404));
        return next(error);
    }
    res.status(200).json({ estado });
}

exports.getCiudadesPorPaisEstado = async (req, res, next) => {
    const { provincia, pais } = await req.params;
    let ciudades;
    console.log(provincia, pais)
    try {
        ciudades = await db.Ciudades.findAll({
            where: {
                pais,
                provincia
            }
        })
    } catch (err) {
        console.log(err);
        const error = new HttpError('hay un error, no se puede encontrar el estado', 500);
        return next(error);
    }
    if (!ciudades) {
        const error = next(new HttpError('no se puede encontrar el estado con el id suministrado', 404));
        return next(error);
    }
    res.status(200).json({ ciudades });
}