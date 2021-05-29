import { createLocalVue, shallowMount } from "@vue/test-utils";
import PostEdit from '../components/PostEdit.vue'
import CompositionApi from "@vue/composition-api";
const localVue = createLocalVue();
localVue.use(CompositionApi);

import axios from 'axios';
jest.mock('axios');

import { usePostListStore } from '../components/postKey'
jest.mock('../components/postKey')

import "regenerator-runtime/runtime";

describe(`PostEdit.vue`, () => {
  let wrapper;

  beforeAll(() => {
    const pathname = "/posts/1/edit";
    Object.defineProperty(window, 'location', {
      value: {
        pathname: pathname
      },
    });

    const testPosts = [{
      id: 1, tweet: 'testpost', user: { username: 'testuser' }, favorites: [{ user_id: 1, post_id: 1 }]
    }, {
      id: 2, tweet: 'test2', user: { username: 'testuser' }, favorites: [{ user_id: 1, post_id: 2 }]
    }]

    usePostListStore.mockReturnValue({
      posts: {
        value: testPosts
      },
      getPost() {
        return 'hoge'
      },
      deletePost() {
        this.posts.value.pop()
      }
    })

    wrapper = shallowMount(PostEdit, {
      localVue
    })
  })

  it('render PostEdit', () => {
    expect(wrapper.html()).toContain('Edit Post')
  })

  it('currentPostTweet', () => {
    expect(wrapper.vm.currentPostTweet).toEqual("testpost")
  })

  it('editPost', async () => {
    axios.put.mockResolvedValue({ id: 1, post: { tweet: "edit tweet" } });
    await wrapper.vm.editPost(1)
    expect(window.location.href).toBe("/posts")
  })

  it('error in editPost ', async () => {
    expect.assertions(1);
    try {
      axios.put.mockResolvedValue({ id: 1, post: { tweet: "" } });
      await wrapper.vm.editPost(1)
      const msg = { response: { data: { errors: { tweet: ["can't be blank"] } } } }
      throw msg
    } catch (error) {
      expect(error.response.data.errors.tweet[0]).toEqual("can't be blank");
    }
  });
})