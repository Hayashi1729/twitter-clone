import { provide, inject } from "@vue/composition-api";
import storeFavorite from "../stores/favorites";

const FavoriteKey = Symbol('Favorite')

function setupFavoriteList() {
  provide(FavoriteKey, storeFavorite());
  const favoriteList = inject(FavoriteKey);
  if (!favoriteList) {
    throw new Error(`favoriteList is not provided`);
  }

  return favoriteList
};

export { setupFavoriteList };