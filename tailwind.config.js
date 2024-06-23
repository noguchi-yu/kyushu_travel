module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {
      fontFamily: {
        lato: ['Lato', 'sans-serif'],
        zenmaru: ['Zen Maru Gothic', 'serif'],
      }
    }
  },
  plugins: [require("daisyui")
  ],
  daisyui: {
    themes: [
      "lemonade"
    ],
    darkTheme: false,
  },
}
