import { createLocalVue, shallowMount } from "@vue/test-utils";
import PostNew from '../vue/PostNew.vue'
import CompositionApi from "@vue/composition-api";
const localVue = createLocalVue();
localVue.use(CompositionApi);

import "regenerator-runtime/runtime";

describe(`PostNew.vue`, () => {
  const options = { localVue }
  const wrapper = shallowMount(PostNew, options)

  it('render PostNew', () => {
    expect(wrapper.html()).toContain('New Post')
  })

  it('', async () => {
    const textInput = wrapper.find('input[type="text"]')
    await textInput.setValue('test_post')

    expect(wrapper.find('input[type="text"]').element.value).toBe('test_post')
  })
})