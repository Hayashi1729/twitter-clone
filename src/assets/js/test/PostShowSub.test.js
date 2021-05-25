import { createLocalVue, shallowMount } from "@vue/test-utils";
import PostShowSub from '../components/PostShowSub.vue'
import CompositionApi from "@vue/composition-api";
const localVue = createLocalVue();
localVue.use(CompositionApi);

describe(`PostShowSub.vue`, () => {
  let wrapper;

  beforeAll(() => {
    const pathname = "/posts/1";
    Object.defineProperty(window, 'location', {
      value: {
        pathname: pathname
      },
    });

    wrapper = shallowMount(PostShowSub, {
      provide: {
        postList: {
          posts: {
            value: [{
              id: 1, tweet: 'testpost', user: { username: 'testuser' }, favorites: [{ user_id: 1, post_id: 1 }]
            }, {
              id: 2, tweet: 'test2', user: { username: 'testuser' }, favorites: [{ user_id: 1, post_id: 2 }]
            }]
          },
          getPost() {
            return 'hoge'
          },
          deletePost() {
            this.posts.value.pop()
          }
        }
      },
      localVue
    })
  })

  it('render PostShowSub', () => {
    expect(wrapper.html()).toContain('Show Post')
    expect(wrapper.html()).toContain('testpost')
  })

  it('currentPost', () => {
    expect(wrapper.vm.currentPost.tweet).toEqual("testpost")
  })
})