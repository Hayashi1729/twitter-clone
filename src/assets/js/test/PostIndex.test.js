import { createLocalVue, shallowMount } from "@vue/test-utils";
import PostIndex from '../components/PostIndex.vue'
import CompositionApi from "@vue/composition-api";
const localVue = createLocalVue();
localVue.use(CompositionApi);

import { setupPostList } from '../components/postKey'
jest.mock('../components/postKey')

import { setupFavoriteList } from '../components/favoriteKey'
jest.mock('../components/favoriteKey')

import "regenerator-runtime/runtime";

describe(`PostIndex.vue`, () => {
  let wrapper;

  beforeAll(() => {
    const pathname = "/posts/1";
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

    setupPostList.mockReturnValue({
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

    setupFavoriteList.mockReturnValue({
      favorites: {
        value: [1, 2]
      },
      getFavorite() {
        return 'hoge'
      },
      createFavorite() {
        this.favorites.value.push(100)
      },
      deleteFavorite() {
        this.favorites.value.pop()
      }
    })

    wrapper = shallowMount(PostIndex, {
      localVue
    })
  })

  it('render PostIndex', () => {
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

  it('pushFavorite', () => {
    const post = { id: 100, tweet: 'post', user: { username: 'testuser' } }
    wrapper.vm.pushFavorite(post)
    expect(wrapper.vm.favoriteList.favorites.value).toEqual([1, 2, 100])
  })

  it('filterFavorite', () => {
    const post = { id: 100, tweet: 'post', user: { username: 'testuser' } }
    wrapper.vm.filterFavorite(post)
    expect(wrapper.vm.favoriteList.favorites.value).toEqual([1, 2])
  })
})

