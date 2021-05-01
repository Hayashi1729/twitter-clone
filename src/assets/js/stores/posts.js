const { reactive, readonly, toRefs } = VueCompositionAPI;

export default function postStore() {
    const state = reactive({
        posts: [],
    })

    axios.get('/api/posts').then(response => {
        state.posts = response.data
    })

    async function postDelete(id) {
        try {
            const response = await axios.delete(`/api/posts/${id}`);
            state.posts = state.posts.filter((post) => post.id !== id);
        } catch (error) {
            console.error(error);
        }
    }



    return {
        ...toRefs(state),
        postDelete
    }
}

