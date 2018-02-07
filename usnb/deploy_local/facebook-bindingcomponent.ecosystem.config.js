module.exports = {
    /**
     * Application configuration section
     * http://pm2.keymetrics.io/docs/usage/application-declaration/
     */
    apps: [

        // First application
        {
            name: 'facebook-bindingcomponent',
            script: 'start.js',
            /*env: {
              COMMON_VARIABLE: 'true'
            },
            env_production : {
              NODE_ENV: 'production'
            }*/
        }
    ],

    /**
     * Deployment section
     * http://pm2.keymetrics.io/docs/usage/deployment/
     */
    deploy: {
        production: {
            user: 'rangarit',
            host: 'localhost',
            ref: 'origin/master',
            repo: 'https://gitlab.inria.fr/usnb/facebook-bc.git',
            path: '/home/appcivist/production/usnb/facebook-bindingcomponent',
            'post-deploy': 'npm install && npm install git+https://gitlab.inria.fr/usnb/message-transformer && pm2 reload /home/appcivist/production/usnb/usnb/deploy_local/facebook-bindingcomponent.ecosystem.config.js --env dev',

            env: {
                NODE_ENV: 'production',

                RABBITMQ: 'amqp://user:pass@127.0.0.1:5672',

                USNB_FACEBOOK_PERSONA_PORT: 3027,
                USNB_FACEBOOK_PERSONA_EXCHANGE: 'facebookmessenger',
                USNB_FACEBOOK_USER: '',
                USNB_FACEBOOK_PASSWORD: ''
            }
        },
        dev: {
            user: '',
            host: 'localhost',
            ref: 'origin/master',
            repo: 'https://gitlab.inria.fr/usnb/facebook-bc.git',
            path: '/path/to/local/development/deployment/directory/facebook-bindingcomponent',
            'post-deploy': 'npm install && npm install git+https://gitlab.inria.fr/usnb/message-transformer && pm2 reload /path/to/local/deploy/scripts/facebook-bindingcomponent.ecosystem.config.js --env dev',
            env: {
                NODE_ENV: 'development',

                RABBITMQ: 'amqp://user:pass@127.0.0.1:5672',

                USNB_FACEBOOK_PERSONA_PORT: 3027,
                USNB_FACEBOOK_PERSONA_EXCHANGE: 'facebookmessenger',
                USNB_FACEBOOK_USER: 'S_FACEBOOK_USER',
                USNB_FACEBOOK_PASSWORD: 'S_FACEBOOK_PASS'
            }
        }
    }
};
