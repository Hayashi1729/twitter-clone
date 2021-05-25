import { reactive, toRefs } from "@vue/composition-api";
import axios from 'axios'

export default function storePost() {
  const state = reactive({
    posts: [],
  })

  async function getPost() {
    const response = await axios.get('/api/posts')
    state.posts = response.data
  }

  async function deletePost(id) {
    try {
      await axios.delete(`/api/posts/${id}`);
      state.posts = state.posts.filter((post) => post.id !== id);
    } catch (error) {
      console.error(error);
    }
  }

  return {
    ...toRefs(state),
    getPost,
    deletePost
  }
}

