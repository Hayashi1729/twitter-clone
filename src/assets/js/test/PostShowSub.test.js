import { createLocalVue, shallowMount } from "@vue/test-utils";
import PostShowSub from '../vue/PostShowSub.vue'
import CompositionApi from "@vue/composition-api";
const localVue = createLocalVue();
localVue.use(CompositionApi);

describe(`PostShowSub.vue`, () => {
  const wrapper = shallowMount(PostShowSub, {
    provide: {
      foo() {
        return 'bar'
      }
    }
  })

  it('render PostShowSub', () => {
    expect(wrapper.html()).toContain('Show Post')
  })

  it('', () => {

  })
})