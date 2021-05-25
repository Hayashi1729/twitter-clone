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

import Index from './components/Index.vue'
import UserIndex from './components/UserIndex.vue'
import UserNew from './components/UserNew.vue'
import UserShow from './components/UserShow.vue'
import UserEdit from './components/UserEdit.vue'
import PostIndex from './components/PostIndex.vue'
import PostNew from './components/PostNew.vue'
import PostShow from './components/PostShow.vue'
import PostEdit from './components/PostEdit.vue'
import SessionNew from './components/SessionNew.vue'

new Vue({
    el: '#app',
    components: {
        Index,
        UserIndex,
        UserNew,
        UserShow,
        UserEdit,
        PostIndex,
        PostNew,
        PostShow,
        PostEdit,
        SessionNew
    }
});
