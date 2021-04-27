const { reactive } = VueCompositionAPI;

export default function postStore() {
    const state = reactive({
        posts: [],
    })

    axios.get('/api/posts').then(response => {
        state.posts = response.data
    })

    return {
        get post() {
            return state.posts
        },

    }
}

