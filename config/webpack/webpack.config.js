// See the shakacode/shakapacker README and docs directory for advice on customizing your webpackConfig.
// this code change for troubleshooting react error
const { generateWebpackConfig } = require('shakapacker')
const ReactRefreshWebpackPlugin = require('@pmmmwh/react-refresh-webpack-plugin')
const isDevelopment = process.env.NODE_ENV !== 'production'

const customConfig = {
  resolve: {
    extensions: ['.js', '.jsx', '.ts', '.tsx'],
  },
  plugins: [
    isDevelopment && new ReactRefreshWebpackPlugin(),
  ].filter(Boolean),
}
const webpackConfig = generateWebpackConfig(customConfig)

module.exports = webpackConfig
