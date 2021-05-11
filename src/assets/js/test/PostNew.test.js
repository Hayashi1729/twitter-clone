import { createLocalVue, shallowMount } from "@vue/test-utils";
import PostNew from '../vue/PostNew.vue'
import CompositionApi from "@vue/composition-api";
const localVue = createLocalVue();
localVue.use(CompositionApi);

import axios from 'axios';
jest.mock('axios')

import "regenerator-runtime/runtime";

global.window = Object.create(window);
const pathname = "/posts/new";
Object.defineProperty(window, 'location', {
  value: {
    pathname: pathname
  },
})

axios.post.mockResolvedValue({ data: { post: [{ tweet: 'new post' }] } });

describe(`PostNew.vue`, () => {
  const options = { localVue }
  const wrapper = shallowMount(PostNew, options)

  it('render PostNew', () => {
    expect(wrapper.html()).toContain('New Post')
  })

  it('set post', async () => {
    const textInput = wrapper.find('input[type="text"]')
    await textInput.setValue('test_post')

    expect(wrapper.find('input[type="text"]').element.value).toBe('test_post')
  })

  it('createPost', async () => {
    await wrapper.vm.createPost()
    expect(window.location.href).toBe("/posts")
  })
})