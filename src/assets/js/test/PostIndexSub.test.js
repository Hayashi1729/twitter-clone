import { createLocalVue, shallowMount } from "@vue/test-utils";
import PostIndexSub from '../vue/PostIndexSub.vue'
import CompositionApi from "@vue/composition-api";
const localVue = createLocalVue();
localVue.use(CompositionApi);

import axios from 'axios';
jest.mock('axios');

import "regenerator-runtime/runtime";

//axios.get.mockResolvedValue({ data: { posts: [{ id: 1, tweet: 'test' }] } });

describe(`PostIndexSub.vue`, () => {
  const wrapper = shallowMount(PostIndexSub, {
    provide: {
      postList: {
        posts: {
          value: [
            {
              id: 1,
              tweet: "TestPost_1",
              user: {
                username: "TestUser_1"
              },
              inserted_at: "Test"
            }
          ]
        }
      }
    }
  })


  it('render PostIndexSub', () => {
    expect(wrapper.html()).toContain('ツイート一覧')
  })

  it('', () => {

  })
})