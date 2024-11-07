const { environment } = require('@rails/webpacker')
const webpack = require('webpack')

// jQuery と Popper.js の設定を維持
environment.plugins.prepend(
  'Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery',
    Popper: 'popper.js'
  })
)

// Stimulus の設定を追加
const stimulus = require('@hotwired/stimulus-webpack-helpers')
environment.plugins.append(
  'Stimulus',
  new webpack.ProvidePlugin({
    Stimulus: ['@hotwired/stimulus', 'Stimulus']
  })
)

module.exports = environment