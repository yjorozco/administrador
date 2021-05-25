const passport = require('passport');
const passportJWT = require("passport-jwt");
const Usuarios = require('../models/Usuarios');
const ExtractJWT = passportJWT.ExtractJwt;
const bcrypt = require('bcrypt');
const LocalStrategy = require('passport-local').Strategy;
const JWTStrategy = passportJWT.Strategy;

passport.use(new LocalStrategy({
    usernameField: 'correo',
    passwordField: 'password'
},
    async (correo, password, cb) => {
        try {
            const user = await Usuarios.findOne({ where: { correo, activo: true } });

            if (!user) {
                return cb(null, false, { message: 'Correo invalido' });
            }

            const result = await bcrypt.compare(password, user.password);

            if (result) {
                return cb(null, user, {
                    message: 'Ingreso Satisfactoriamente'
                });
            } else {
                return cb(null, false, { message: 'Password incorrecto' });
            }          // 
        } catch (err) {
            return cb(err);
        }
    }

));

passport.use(new JWTStrategy({
    jwtFromRequest: ExtractJWT.fromAuthHeaderAsBearerToken(),
    secretOrKey: '76175d01f9577203f737e74485ece6f843fcbf75'
},
    async (jwtPayload, cb) => {
        try {
            const user = await Usuarios.findOne({ where: { id: jwtPayload.user.id } })
            return cb(null, user);
        } catch (err) {
            return cb(err);
        }
    }
));