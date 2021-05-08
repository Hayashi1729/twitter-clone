import { createLocalVue, shallowMount } from "@vue/test-utils";
import UserShowSub from '../vue/UserShowSub.vue'
import CompositionApi from "@vue/composition-api";
const localVue = createLocalVue();
localVue.use(CompositionApi);

describe(`UserShowSub.vue`, () => {
  const wrapper = shallowMount(UserShowSub, {
    provide: {
      foo() {
        return 'bar'
      }
    }
  })

  it('render UserShowSub', () => {
    expect(wrapper.html()).toContain('Show User')
  })

  it('', () => {

  })
})