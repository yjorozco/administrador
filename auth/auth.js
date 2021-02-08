const passport = require('passport');
const localStrategy = require('passport-local').Strategy;
const Usuarios = require('../models/Usuarios');


exports.passportAuth = passport.use(
    'login',
    new localStrategy(
        {
            usernameField: 'correo',
            passwordField: 'password'
        },
        async (email, password, done) => {
            try {
                
                const usuario = await Usuarios.findOne({ correo });

                if (!usuario) {
                    return done(null, false, { message: 'usuario no existe' });
                }

                const comparar = await bcrypt.compare(password, usuario.password);


                if (!comparar) {
                    return done(null, false, { message: 'Password Invalido' });
                }

                return done(null, usuario, { message: 'Acceso exitoso' });
            } catch (error) {
                return done(error);
            }
        }
    )
);


exports.verificar=passport.use(
    new JWTstrategy(
      {
        secretOrKey: 'TOP_SECRET',
        jwtFromRequest: ExtractJWT.fromUrlQueryParameter('secret_token')
      },
      async (token, done) => {
        try {
          return done(null, token.user);
        } catch (error) {
          done(error);
        }
      }
    )
  );

