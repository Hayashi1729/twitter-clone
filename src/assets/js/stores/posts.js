const { reactive } = VueCompositionAPI;

export default function postStore() {
    const state = reactive({
        posts: [],
    })

    axios.get('/api/posts').then(response => {
        state.posts = response.data
    })


    function post_delete(id) {
        console.log(id)
        state.posts = state.posts.filter((post) => post.id !== id);
    }

    return {
        get post() {
            return state.posts
        },
        post_delete
    }
}

