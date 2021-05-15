import { createLocalVue, shallowMount } from "@vue/test-utils";
import PostIndexSub from '../vue/PostIndexSub.vue'
import CompositionApi from "@vue/composition-api";
const localVue = createLocalVue();
localVue.use(CompositionApi);

import "regenerator-runtime/runtime";

describe(`PostIndexSub.vue`, () => {
  const wrapper = shallowMount(PostIndexSub, {
    provide: {
      postList: {
        posts: {
          value: [{
            id: 1, tweet: 'test', user: { username: 'testuser' }, favorites: [{ user_id: 1, post_id: 1 }]
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

  it('render PostIndexSub', () => {
    expect(wrapper.html()).toContain('ツイート一覧')
  })

  it('reversePosts', () => {
    expect(wrapper.vm.reversePosts[0].id).toBe(2)
    expect(wrapper.vm.reversePosts[1].id).toBe(1)
  })

  it('deletePost', () => {
    wrapper.vm.deletePost(1)
    expect(wrapper.vm.postList.posts.value.length).toBe(1)
  })
})

