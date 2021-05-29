import { provide, inject } from "@vue/composition-api";
import storePost from "../stores/posts";

const PostKey = Symbol('Post')

function usePostListStore() {
  provide(PostKey, storePost());
  const postList = inject(PostKey);
  if (!postList) {
    throw new Error(`postList is not provided`);
  }

  return postList
};

export { usePostListStore };