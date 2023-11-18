abstract final class ApiConst {
  static const baseUrl = String.fromEnvironment(
    "base_url",
    defaultValue: "123",
  );

  static const apiKey = String.fromEnvironment(
    "api_key",
    defaultValue: "123",
  );

  static const allProductsPath = "/products";
  static const userCartsPath = "/carts/user/";
  static const getProductPath = "/products/";
  static const getUserPath = "/users";
  static const searchProducts = "/products/category/";

  static String getPostFromId(int id) => "/products/$id";
}