import { createLocalVue, shallowMount } from "@vue/test-utils";
import UserNew from '../vue/UserNew.vue'
import CompositionApi from "@vue/composition-api";
const localVue = createLocalVue();
localVue.use(CompositionApi);

import "regenerator-runtime/runtime";

describe(`UserNew.vue`, () => {
  const options = { localVue }
  const wrapper = shallowMount(UserNew, options)

  it('render UserNew', () => {
    expect(wrapper.html()).toContain('New User')
  })

  it('set username and password', async () => {
    const textInput = wrapper.find('input[type="text"]')
    await textInput.setValue('test_name')

    expect(wrapper.find('input[type="text"]').element.value).toBe('test_name')

    const passwordInput = wrapper.find('input[type="password"]')
    await passwordInput.setValue('password')

    expect(wrapper.find('input[type="password"]').element.value).toBe('password')
  })
})