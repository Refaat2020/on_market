class CartModel{

 final String image;
 final String name;
 final String description;
 final int qty;
 final String price;
 final String discount;

 CartModel(
      {required this.image,
        required this.name,
        required this.description,
        required this.qty,
        required this.price,
        required this.discount});
}