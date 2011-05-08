Neighborly::Application.config.middleware.use ExceptionNotifier,
:email_prefix => '[EXCEPTION] ',
:sender_address => '"Notifier" <uswap@uswap.it>'
:exception_recipients => ['jyro215@gmail.com','rocketman768@gmail.com']
