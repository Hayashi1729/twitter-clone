import { createLocalVue, shallowMount } from "@vue/test-utils";
import PostIndexSub from '../vue/PostIndexSub.vue'
import CompositionApi from "@vue/composition-api";
const localVue = createLocalVue();
localVue.use(CompositionApi);

import axios from 'axios';
jest.mock('axios');

import "regenerator-runtime/runtime";

axios.get.mockResolvedValue({ data: [1] })
axios.post.mockResolvedValue({})
axios.delete.mockResolvedValue({})

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

  it('countFavorites', () => {
    const post = { favorites: [{ user_id: 1, post_id: 1 }, { user_id: 2, post_id: 1 }, { user_id: 3, post_id: 1 }] }
    expect(wrapper.vm.countFavorites(post)).toBe(3)
  })

  it('isFavorited', () => {
    expect(wrapper.vm.isFavorited(1)).toBeTruthy()
  })

  it("createFavorite", async () => {
    const post = { id: 100, favorites: [{ user_id: 1, post_id: 1 }] }
    await wrapper.vm.createFavorite(post)
    expect(wrapper.vm.state.postsFavoritedByCurrentUser).toEqual([1, 100])
    expect(post.favorites.length).toBe(2)
  })

  it("deleteFavorite", async () => {
    await wrapper.vm.deleteFavorite(wrapper.vm.postList.posts.value[0])
    expect(wrapper.vm.state.postsFavoritedByCurrentUser).toEqual([100])
    expect(wrapper.vm.postList.posts.value[0].favorites.length).toBe(0)
  })
})

