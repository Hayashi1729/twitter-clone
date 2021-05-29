import { createLocalVue, shallowMount } from "@vue/test-utils";
import PostNew from '../components/PostNew.vue'
import CompositionApi from "@vue/composition-api";
const localVue = createLocalVue();
localVue.use(CompositionApi);

import axios from 'axios';
jest.mock('axios')

import "regenerator-runtime/runtime";

describe(`PostNew.vue`, () => {
  let wrapper;

  beforeAll(() => {
    const pathname = "/posts/new";
    Object.defineProperty(window, 'location', {
      value: {
        pathname: pathname
      },
    })

    const options = { localVue }
    wrapper = shallowMount(PostNew, options)
  })

  it('render PostNew', () => {
    expect(wrapper.html()).toContain('New Post')
  })

  it('set post', async () => {
    const textInput = wrapper.find('input[type="text"]')
    await textInput.setValue('test_post')

    expect(wrapper.find('input[type="text"]').element.value).toBe('test_post')
  })

  it('createPost', async () => {
    axios.post.mockResolvedValue({ data: { post: { tweet: 'new post' } } });
    await wrapper.vm.createPost()
    expect(window.location.href).toBe("/posts")
  })

  it('error in createPost ', async () => {
    expect.assertions(1);
    try {
      axios.post.mockResolvedValue({ data: { post: { tweet: '' } } });
      await wrapper.vm.createPost()
      const msg = { response: { data: { errors: { tweet: ["can't be blank"] } } } }
      throw msg
    } catch (error) {
      expect(error.response.data.errors.tweet[0]).toEqual("can't be blank");
    }
  });
})