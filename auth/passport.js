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
    function (correo, password, cb) {
        return Usuarios.findOne({ where: { correo, activo:true } })
            .then(user => {

                if (!user) {
                    return cb(null, false, { message: 'Incorrect email' });
                }

                bcrypt.compare(password, user.password).then(function (result) {
                    if (result) {
                        return cb(null, user, {
                            message: 'Logged In Successfully'
                        });
                    } else {
                        return cb(null, false, { message: 'Incorrect password.' });
                    }
                });

            })
            .catch(err => {
                return cb(err);
            });

    }
));

passport.use(new JWTStrategy({
    jwtFromRequest: ExtractJWT.fromAuthHeaderAsBearerToken(),
    secretOrKey: 'your_jwt_secret'
},
    function (jwtPayload, cb) {
        return Usuarios.findOne(jwtPayload.id)
            .then(user => {
                return cb(null, user);
            })
            .catch(err => {
                return cb(err);
            });
    }
));