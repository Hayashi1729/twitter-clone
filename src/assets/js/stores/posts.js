const { reactive, readonly, toRefs } = VueCompositionAPI;

export default function postStore() {
    const state = reactive({
        posts: [],
    })

    axios.get('/api/posts').then(response => {
        state.posts = response.data
    })

    function postDelete(id) {
        state.posts = state.posts.filter((post) => post.id !== id);
    }

    return {
        ...toRefs(state),
        postDelete
    }
}

