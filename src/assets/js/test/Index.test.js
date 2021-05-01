import { createLocalVue, shallowMount } from "@vue/test-utils";
import Index from '../vue/Index.vue'
import Vue from 'vue'
import CompositionApi from "@vue/composition-api";
const localVue = createLocalVue();
localVue.use(CompositionApi);

describe(`Index.vue`, () => {
  it('render Index', () => {
    const options = { localVue }
    const wrapper = shallowMount(Index, options)
    expect(2 + 2).toBe(4)
  })
})