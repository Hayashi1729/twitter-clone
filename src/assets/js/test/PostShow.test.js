import { createLocalVue, shallowMount } from "@vue/test-utils";
import PostShow from '../components/PostShow.vue'
import CompositionApi from "@vue/composition-api";
const localVue = createLocalVue();
localVue.use(CompositionApi);

import { usePostListStore } from '../components/postKey'
jest.mock('../components/postKey')

describe(`PostShow.vue`, () => {
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

    wrapper = shallowMount(PostShow, {
      localVue
    })
  })

  it('render PostShow', () => {
    expect(wrapper.html()).toContain('Show Post')
    expect(wrapper.html()).toContain('testpost')
  })

  it('currentPost', () => {
    expect(wrapper.vm.currentPost.tweet).toEqual("testpost")
  })
})