const path = require('path')

require("esbuild").context({
  entryPoints: ["application.js", "active_admin.js"],
  bundle: true,
  sourcemap: true,
  publicPath: 'assets',
  outdir: path.join(process.cwd(), "app/assets/builds"),
  absWorkingDir: path.join(process.cwd(), "app/javascript/"),
  plugins: [],
  loader: {
    ".png": "dataurl",
    ".woff": "dataurl",
    ".woff2": "dataurl",
    ".eot": "dataurl",
    ".ttf": "dataurl",
    ".svg": "dataurl",
  },
  minify: process.argv.includes("--minify")
}).then(context => {
  if (process.argv.includes("--watch")) {
    context.watch()
  } else {
    context.rebuild().then(result => {
      context.dispose()
    })
  }
}).catch(() => process.exit(1))
