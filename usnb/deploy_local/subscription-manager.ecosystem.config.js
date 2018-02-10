module.exports = {
    /**
     * Application configuration section
     * http://pm2.keymetrics.io/docs/usage/application-declaration/
     */
    apps: [

        // First application
        {
            name: 'subscription-manager',
            script: 'server.js',
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
            repo: 'https://github.com/socialappslab/subscription-manager',
            path: '/home/appcivist/production/usnb/subscription-manager',
            'post-deploy': 'npm install && npm install git+https://gitlab.inria.fr/usnb/message-transformer && pm2 reload /home/appcivist/production/usnb/usnb/deploy_local/subscription-manager.ecosystem.config.js --env dev',
            env: {
                NODE_ENV: 'production',
                RABBITMQ: 'amqp://user:pass@127.0.0.1:5672',
                USNB_NOTIFICATIONS_PORT: 3023,
                USNB_MONGO_URI_NOTIFICATIONS: 'mongodb://localhost:27017/notificationservice',
            }
        },
        dev: {
            user: '',
            host: 'localhost',
            ref: 'origin/master',
            repo: 'https://gitlab.inria.fr/usnb/subscription-manager',
            path: '/path/to/local/development/deployment/directory/subscription-manager',
            'post-deploy': 'npm install && npm install git+https://gitlab.inria.fr/usnb/message-transformer && pm2 reload /path/to/local/deploy/scripts/subscription-manager.ecosystem.config.js --env dev',
            env: {
                NODE_ENV: 'development',
                RABBITMQ: 'amqp://user:pass@127.0.0.1:5672',
                USNB_NOTIFICATIONS_PORT: 3023,
                USNB_MONGO_URI_NOTIFICATIONS: 'mongodb://localhost:27017/notificationservice',
            }
        }
    }
};
