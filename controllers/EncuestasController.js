const HttpError = require('../models/Error');
const { validationResult } = require('express-validator');
const db = require('../database/asociaciones');
const dateFormat = require('dateformat');
const { Op } = require("sequelize");
const Sequelize = require('sequelize');

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

        const intensidadesObject = await db.Intensidades.findAll({
            atributes: ['id', 'nombre','valor'],
            where: {
                id: { [Op.in]: intensidades }
            }        
        })

        console.log(intensidadesObject);

        const total = intensidadesObject.reduce((a, b) => a + b.valor, 0);

        console.log(total);
        /* const numero = await respuestas.length;
         const intensidadValor = Math.round(intensidadesSuma/numero);
         const intensidad = await db.Intensidades.findAll(
             { where: { 'valor': intensidadValor } }
         )
         let fechaSismo = await fecha + ' ' + hora;
         console.log(intensidad);
         fechaSismo = dateFormat(fechaSismo, "yyyy-mm-dd h:MM:ss");
         const encuestas = await db.Encuestas.create({
             'id_usuarios': usuario.id,
             'fecha': fechaSismo,
             'intensidad': intensidad.nombre
 
         }, {
             fields: [
                 'id_usuarios',
                 'fecha',
                 'intensidad'
             ], transaction: t
         })
 
         for (respuesta of respuestas) {
             let intensidad = await db.Intensidades.findOne({
                 where: {
                     id_intensidad
                 }
             })
             await db.EncuestasDetalles.create({
                 'id_encuestas': encuestas.id,
                 'id_preguntas': fechaSismo,
                 'id_intensidades': intensidad.id
 
             }, {
                 fields: [
                     'id_encuestas',
                     'id_preguntas',
                     'id_intensidades'
                 ], transaction: t
             })
         }
 
         //await usuario.setEncuestasDetalles(roles, { fields: ["id_encuestas", "id_preguntas","id_intesidades"], transaction: t });
         await t.commit();*/
        res.status(201).json({ mensaje: 'usuario creado' });
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