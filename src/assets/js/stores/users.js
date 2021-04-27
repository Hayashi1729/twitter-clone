const { reactive } = VueCompositionAPI;

export default function userStore() {
    const state = reactive({
        users: [],
    })

    axios.get('/api/users').then(response => {
        state.users = response.data
    })

    return {
        get user() {
            return state.users
        },

    }
}
