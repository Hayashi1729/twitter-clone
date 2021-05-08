import { createLocalVue, shallowMount } from "@vue/test-utils";
import PostEditSub from '../vue/PostEditSub.vue'
import CompositionApi from "@vue/composition-api";
const localVue = createLocalVue();
localVue.use(CompositionApi);

describe(`PostEditSub.vue`, () => {
  const wrapper = shallowMount(PostEditSub, {
    provide: {
      foo() {
        return 'bar'
      }
    }
  })

  it('render PostEditSub', () => {
    expect(wrapper.html()).toContain('Edit Post')
  })

  it('', () => {

  })
})