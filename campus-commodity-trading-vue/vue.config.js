module.exports = {
  publicPath: './',
  outputDir: 'dist',
  assetsDir: 'static',
  devServer: {
    host: 'localhost',
    port: 14002,
    https: false
  },
  chainWebpack: config => {
    config.resolve.alias
        .set('_c', resolve('src/components')) // key,value自行定义，比如.set('@@', resolve('src/components'))
  },
}
const path = require('path')
const resolve = dir => {
  return path.join(__dirname, dir)
}
