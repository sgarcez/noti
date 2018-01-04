module.exports = {
  database: {
    uri: process.env.DB
  },
  http_server: {
    host: '0.0.0.0',
    port: 3000,
    log_level: 'debug',
  }
}
