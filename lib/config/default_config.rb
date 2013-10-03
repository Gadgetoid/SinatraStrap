DEFAULT_CONFIG = {
    'admin' => {
        'email' => 'test@example.com',
        'pass'  => 'test',
        'first_name'  => 'Testington',
        'last_name'   => 'Testleroy'
    },

    'pass' => {
        'length' => 8,
        'require_digits' => true},

    'database'    => 'data.db',
    'database_action' => 'upgrade',
    'secret'      => SecureRandom.uuid,
    'expiry'      => 2592000,
    'secure_home' => '/secure'
}