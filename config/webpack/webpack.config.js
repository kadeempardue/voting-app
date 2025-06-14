// See the shakacode/shakapacker README and docs directory for advice on customizing your webpackConfig.
const { generateWebpackConfig } = require('shakapacker')

const webpackConfig = generateWebpackConfig()

const { sassLoader } = require('./sass.rules')

// Apply the patch
webpackConfig.module.rules.forEach(rule => {
  if (rule.test && rule.test.toString().includes('scss')) {
    rule.use.push(sassLoader)
  }
})

module.exports = webpackConfig
