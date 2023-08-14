

import SwiftUI

struct SwiftUIView: View {
    var availableUtems:[ShopItem]
    @State var cartItems: Dictionary<Int,ShopItem> = [:]
    var body: some View {
        NavigationView {
            List(availableUtems){ items in
                ShopItemRow(inCart: inCart(shopItem: items),shopItem: items)
                    .onTapGesture {
                        self.toggleCart(item: items)
                    }
            }
            .navigationTitle("Shopping list")
            .toolbar {
                ToolbarItem {
                    Cart(cartItems:cartItems.count)
                }
            }
            
        }
    }
    
    private func inCart(shopItem:ShopItem)->Bool{
        return cartItems[shopItem.id] != nil
        
    }
    
    private func toggleCart(item:ShopItem){
        if(cartItems[item.id] == nil){
            return cartItems[item.id] = item
        }else{
            return cartItems[item.id] = nil
        }
        
    }
}


struct Cart:View{
    var cartItems: Int
    var body:some View{
        ZStack{
            Image("cart")
                .resizable()
                .frame(width: 30, height: 30, alignment: .center)
            ZStack{
                Circle()
                    .foregroundColor(.red)
                    .frame(maxWidth:20)
                Text("\(cartItems)")
                    .font(.body)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .frame(width:8, height: 5)
                    .zIndex(1)
                    
                    
            }.frame(width: 15.0, height: 15.0)
                .offset(x: 8,y: 13)
                .opacity(cartItems>0 ? 1.0 : 0)
            
        }
        
        
            
    }
}


struct ShopItemRow:View{
    var inCart:Bool
    var shopItem:ShopItem
    var body: some View{
        HStack{
            Text(shopItem.name)
            Text(String(format:"%.2f",shopItem.price))
            Spacer()
            Image(inCart ? "checked":"unchecked")
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .frame(width: 50)
        }.frame(minWidth: 0, maxWidth:.infinity)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView(
            availableUtems: [ ShopItem(id: 1, price: 9.89, name: "Nike Air"),
                              ShopItem(id: 2, price: 959, name: "Nike Air 1"),
                              ShopItem(id: 3, price: 56.7, name: "Nike Air 2"),
                              ShopItem(id: 5, price: 9.89, name: "Nike Air 3")]
            
        )

}
}
