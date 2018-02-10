module.exports = {
    /**
     * Application configuration section
     * http://pm2.keymetrics.io/docs/usage/application-declaration/
     */
    apps: [

        // First application
        {
            name: 'email-bindingcomponent',
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
            user: 'yolile',
            host: 'localhost',
            ref: 'origin/master',
            repo: 'https://gitlab.inria.fr/usnb/email-bc',
            path: '/home/appcivist/production/usnb/email-bindingcomponent',
            'post-deploy': 'npm install && npm install git+https://gitlab.inria.fr/usnb/message-transformer && pm2 reload /home/appcivist/production/usnb/usnb/deploy_local/email-bindingcomponent.ecosystem.config.js --env dev',
            env: {
                NODE_ENV: 'production',
                RABBITMQ: 'amqp://user:pass@127.0.0.1:5672',
                USNB_EMAIL_PERSONA_PORT: 3026,
                USNB_EMAIL_HOST: 'smtp.gmail.com',
                USNB_EMAIL_PORT: 465,
                USNB_EMAIL_USER: '',
                USNB_EMAIL_PASSWORD: '',
                USNB_EMAIL_PERSONA_EXCHANGE: 'email'
            }
        },
        dev: {
            user: 'rangarit',
            host: 'localhost',
            ref: 'origin/master',
            repo: 'https://gitlab.inria.fr/usnb/email-bc',
            path: '/path/to/local/development/deployment/directory/email-bindingcomponent',
            'post-deploy': 'npm install && npm install git+https://gitlab.inria.fr/usnb/message-transformer && pm2 reload /path/to/local/deploy/scripts/email-bindingcomponent.ecosystem.config.js --env dev',
            env: {
                NODE_ENV: 'development',
                RABBITMQ: 'amqp://user:pass@127.0.0.1:5672',
                USNB_EMAIL_PERSONA_PORT: 3026,
                USNB_EMAIL_HOST: 'smtp.gmail.com',
                USNB_EMAIL_PORT: 465,
                USNB_EMAIL_USER: 'S_EMAIL_USER',
                USNB_EMAIL_PASSWORD: 'S_EMAIL_PASS',
                USNB_EMAIL_PERSONA_EXCHANGE: 'email'
            }
        }
    }
};
