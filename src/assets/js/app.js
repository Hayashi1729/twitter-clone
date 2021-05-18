// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "../css/app.scss"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import deps with the dep name or local files with a relative path, for example:
//
//     import {Socket} from "phoenix"
//     import socket from "./socket"
//
import "phoenix_html"
import babelPolyfill from '@babel/polyfill'

import Vue from 'vue'
import CompositionAPI from '@vue/composition-api'
Vue.use(CompositionAPI)

import Index from './vue/Index.vue'
import UserIndex from './vue/UserIndex.vue'
import UserNew from './vue/UserNew.vue'
import UserShow from './vue/UserShow.vue'
import UserEdit from './vue/UserEdit.vue'
import PostIndex from './vue/PostIndex.vue'
import PostNew from './vue/PostNew.vue'
import PostShow from './vue/PostShow.vue'
import PostEdit from './vue/PostEdit.vue'
import SessionNew from './vue/SessionNew.vue'

new Vue({
    el: '#app',
    components: { Index, UserIndex, UserNew, UserShow, UserEdit, PostIndex, PostNew, PostShow, PostEdit, SessionNew }
});
