const sassLoader = {
  loader: 'sass-loader',
  options: {
    sassOptions: {
      quietDeps: true,
    },
  },
};

module.exports = {
  sassLoader,
};