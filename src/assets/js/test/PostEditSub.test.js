import { createLocalVue, shallowMount } from "@vue/test-utils";
import PostEditSub from '../vue/PostEditSub.vue'
import CompositionApi from "@vue/composition-api";
const localVue = createLocalVue();
localVue.use(CompositionApi);

import axios from 'axios';
jest.mock('axios');

import "regenerator-runtime/runtime";

global.window = Object.create(window);
const pathname = "/users/1/edit";
Object.defineProperty(window, 'location', {
  value: {
    pathname: pathname
  },
});

axios.put.mockResolvedValue({ id: 1, post: { tweet: "edit tweet" } });

describe(`PostEditSub.vue`, () => {
  const wrapper = shallowMount(PostEditSub, {
    provide: {
      postList: {
        posts: {
          value: [{
            id: 1, tweet: 'testpost', user: { username: 'testuser' }, favorites: [{ user_id: 1, post_id: 1 }]
          }, {
            id: 2, tweet: 'test2', user: { username: 'testuser' }, favorites: [{ user_id: 1, post_id: 2 }]
          }]
        },
        postGet() {
          return 'hoge'
        },
        postDelete() {
          this.posts.value.pop()
        }
      }
    },
    localVue
  })

  it('render PostEditSub', () => {
    expect(wrapper.html()).toContain('Edit Post')
  })

  it('postIndex', () => {
    expect(wrapper.vm.postIndex).toBe(0)
  })

  it('currentPostTweet', () => {
    expect(wrapper.vm.currentPostTweet).toEqual("testpost")
  })

  it('editPost', async () => {
    await wrapper.vm.editPost(1)
    expect(window.location.href).toBe("/posts")
  })
})