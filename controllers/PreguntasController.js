const HttpError = require('../models/Error');
const { validationResult } = require('express-validator');
const db = require('../database/asociaciones');
const Sequelize= require('sequelize');



exports.getPreguntas = async (req, res, next) => {
    try {
        const preguntas = await db.Preguntas.findAll({        
            include: [{ model: db.Intensidades, as: 'Intensidades' }],
            order:[ ['orden', 'ASC'] , [Sequelize.literal('"Intensidades"."valor"'), 'ASC']]
        });
        res.status(200).json({
            preguntas
        })
    } catch (e) {
        console.log(e);
        const error = new HttpError('ocurrio un error al encontrar los paises', 500);
        return next(error)
    }
}