const HttpError = require('../models/Error');
const { validationResult } = require('express-validator');
const db = require('../database/asociaciones');
const dateFormat = require('dateformat');
const { Op } = require("sequelize");
const { QueryTypes } = require('sequelize');

exports.procesarEncuesta = async (req, res, next) => {
    const errors = validationResult(req);
    const t = await db.sequelize.transaction();
    const { fecha, hora, respuestas } = req.body;
    let usuario = await req.user;

    const intensidades = Object.values(respuestas);

    try {
        if (!errors.isEmpty()) {
            console.log(errors);
            next(new HttpError('Datos invalidos', 422));
        }

        let suma=0;
        for (const respuesta in respuestas) {
            let intensidad = await db.Intensidades.findOne({
                where: {
                    id: respuestas[respuesta]
                }
            })
            suma+=await intensidad.valor;
        }

        const promedio = Math.round(suma/intensidades.length);
 
        const intentidadObject =  await db.Intensidades.findOne({
            where:{
                valor: promedio
            }
        })

   
         const encuestas = await db.Encuestas.create({
             'id_usuarios': usuario.id,
             'fecha':dateFormat(fecha, "yyyy-mm-dd h:MM:ss"),
             'intensidad': intentidadObject.nombre
 
         }, {
             fields: [
                 'id_usuarios',
                 'fecha',
                 'intensidad'
             ], transaction: t
         })
        const id_encuestas = await encuestas.id;
        for (const respuesta in respuestas) {
             await db.EncuestasDetalles.create({
                  id_encuestas,
                 'id_preguntas': parseInt(respuesta),
                 'id_intensidades': parseInt(respuestas[respuesta])
 
             }, {
                 fields: [
                     'id_encuestas',
                     'id_preguntas',
                     'id_intensidades'
                 ], transaction: t
             })
         }
 
         await t.commit();
        res.status(201).json({ mensaje: 'encuesta creada' });
    } catch (e) {
        console.log(e);
        try {
            await t.rollback();
        } catch (e) {
            console.log(e);
        }
        const error = new HttpError('No se puede crear la encuesta', 500);
        return next(error)
    }

}