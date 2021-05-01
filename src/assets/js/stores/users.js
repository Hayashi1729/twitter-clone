const { reactive, toRefs } = VueCompositionAPI;

export default function userStore() {
    const state = reactive({
        users: [],
    })

    axios.get('/api/users').then(response => {
        state.users = response.data
    })

    function user_delete(id) {
        state.users = state.users.filter((user) => user.id !== id);
    }

    return {
        ...toRefs(state),
        user_delete
    }
}
