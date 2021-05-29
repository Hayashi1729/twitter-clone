import { createLocalVue, shallowMount } from "@vue/test-utils";
import MainIndex from '../components/MainIndex.vue'
import CompositionApi from "@vue/composition-api";
const localVue = createLocalVue();
localVue.use(CompositionApi);

describe(`ManiIndex.vue`, () => {
  it('render Index', () => {
    const options = { localVue }
    const wrapper = shallowMount(MainIndex, options)
    expect(wrapper.html()).toContain('Welcome to Twitter!')
  })
})