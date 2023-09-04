const AutoImport = require("unplugin-auto-import/webpack");
const Components = require("unplugin-vue-components/webpack");
const { ElementPlusResolver } = require("unplugin-vue-components/resolvers");

const path = require("path");
require("webpack");
function resolve(dir) {
  return path.join(__dirname, dir);
}

module.exports = {
  configureWebpack: {
    plugins: [
      AutoImport({
        resolvers: [ElementPlusResolver()],
      }),
      Components({
        resolvers: [ElementPlusResolver()],
      }),
    ],
    resolve: {
      alias: {
        "@": resolve("src"),
      },
    },
  },
  lintOnSave: false,
  devServer: {
    proxy: {
      "/image": {
        target: "http://localhost:8081/file",
        pathRewrite: { "^/image": "" },
      },
      "/v1/api": {
        target: "http://localhost:8081",
        changeOrigin: true,
        pathRewrite: {
          "^/v1/api": "",
        },
      },
    },
  },
};
