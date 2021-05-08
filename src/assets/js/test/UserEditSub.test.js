import { createLocalVue, shallowMount } from "@vue/test-utils";
import UserEditSub from '../vue/UserEditSub.vue'
import CompositionApi from "@vue/composition-api";
const localVue = createLocalVue();
localVue.use(CompositionApi);

describe(`UserEditSub.vue`, () => {
  const wrapper = shallowMount(UserEditSub, {
    provide: {
      foo() {
        return 'bar'
      }
    }
  })

  it('render UserEditSub', () => {
    expect(wrapper.html()).toContain('Edit User')
  })

  it('', () => {

  })
})