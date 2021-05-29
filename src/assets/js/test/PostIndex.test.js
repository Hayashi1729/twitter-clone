import { createLocalVue, shallowMount } from "@vue/test-utils";
import PostIndex from '../components/PostIndex.vue'
import CompositionApi from "@vue/composition-api";
const localVue = createLocalVue();
localVue.use(CompositionApi);

import { usePostListStore } from '../components/postKey'
jest.mock('../components/postKey')

import { useFavoriteListStore } from '../components/favoriteKey'
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

    useFavoriteListStore.mockReturnValue({
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

  it('isFavorited', () => {
    expect(wrapper.vm.isFavorited(1)).toBeTruthy()
  })

  it("createFavorite", async () => {
    const post = { id: 100, favorites: [{ user_id: 1, post_id: 100 }] }
    await wrapper.vm.createFavorite(post)
    expect(wrapper.vm.favoriteList.favorites.value.length).toBe(3)
  })

  it("deleteFavorite", async () => {
    await wrapper.vm.deleteFavorite(wrapper.props().post)
    expect(wrapper.vm.favoriteList.favorites.value.length).toBe(2)
  })

  it('error in createFavorite ', async () => {
    expect.assertions(1);
    try {
      const post = { id: 100, favorites: [{ user_id: 1, post_id: 100 }] }
      await wrapper.vm.createFavorite(post)
      const msg = { response: { data: { errors: { user_id: ["このツイートはすでにお気に入り登録されています。"] } } } }
      throw msg
    } catch (error) {
      expect(error.response.data.errors.user_id[0]).toEqual("このツイートはすでにお気に入り登録されています。");
    }
  });

  it('error in deleteFavorite ', async () => {
    expect.assertions(1);
    try {
      await wrapper.vm.deleteFavorite({ id: 2 })
      const msg = { response: { data: { errors: { favorite: ["このツイートはお気に入り登録されていません"] } } } }
      throw msg
    } catch (error) {
      expect(error.response.data.errors.favorite[0]).toEqual("このツイートはお気に入り登録されていません");
    }
  });
})

