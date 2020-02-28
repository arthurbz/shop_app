import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartItemProduct extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  CartItemProduct(
      this.id, this.productId, this.price, this.quantity, this.title);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Remove the item from the cart?'),
            actions: <Widget>[
              FlatButton(child: Text('Yes', style: TextStyle(color: Colors.green),), onPressed: () {
                Navigator.of(context).pop(true);
              },),
              FlatButton(child: Text('No', style: TextStyle(color: Colors.red),), onPressed: () {
                Navigator.of(context).pop(false);
              },),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 45,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 15,
        ),
      ),
      child: Card(
          margin: EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 15,
          ),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: ListTile(
              leading: CircleAvatar(
                  radius: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: FittedBox(child: Text('\$$price')),
                  )),
              title: Text(title),
              subtitle: Text('Total: \$${(price * quantity)}'),
              trailing: Text('Quantity: $quantity x'),
            ),
          )),
    );
  }
}
