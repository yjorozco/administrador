const HttpError = require('../models/Error');
const nodemailer = require("nodemailer");
const configuracion = require('../config/Config');


const enviarCorreo = async (correo, asunto, cuerpo) => {
    try {
        const config = await configuracion('Email');
        console.log(config);
        process.env.NODE_TLS_REJECT_UNAUTHORIZED = "0";

        let transporter = nodemailer.createTransport({
            host: config.host,
            port: config.port,
            secure: config.secure, // upgrade later with STARTTLS          
            auth: {
                user: config.auth.user,
                pass: config.auth.pass
            },
        });

        let info = await transporter.sendMail({
            from: config.from,
            to: correo,
            subject: asunto,
            text: cuerpo
        });
        console.log(info)
    } catch (e) {
        console.log(e);
        return new Error('Error al enviar el correo');

    }
}

module.exports = enviarCorreo;