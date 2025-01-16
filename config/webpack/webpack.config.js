// See the shakacode/shakapacker README and docs directory for advice on customizing your webpackConfig.
// this code change for troubleshooting react error
const { generateWebpackConfig } = require('shakapacker')
const isDevelopment = process.env.NODE_ENV !== 'production'

const customConfig = {
  resolve: {
    extensions: ['.js', '.jsx', '.ts', '.tsx'],
  }
}

if (isDevelopment) {
  const ReactRefreshWebpackPlugin = require('@pmmmwh/react-refresh-webpack-plugin')
  customConfig.plugins = [
    new ReactRefreshWebpackPlugin()
  ]
}
const webpackConfig = generateWebpackConfig(customConfig)

module.exports = webpackConfig
