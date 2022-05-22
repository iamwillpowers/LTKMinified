//
//  ContentView.swift
//  LTKMinified
//
//  Created by William Powers on 5/19/22.
//

import SwiftUI

struct DetailsView: View {
    let ltkModel: LtkModel

    let columns = [
        GridItem(.adaptive(minimum: 60, maximum: 90)),
        GridItem(.adaptive(minimum: 60, maximum: 90)),
        GridItem(.adaptive(minimum: 60, maximum: 90)),
        GridItem(.adaptive(minimum: 60, maximum: 90))
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center, spacing: 8) {
                AsyncImage(url: URL(string: ltkModel.avatarUrl)) { phase in
                    switch phase {
                    case .empty:
                        RoundedRectangle(cornerRadius: 5.0)
                            .foregroundColor(Color.gray)
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .frame(width: 40, height: 40)
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                    case .failure:
                        RoundedRectangle(cornerRadius: 5.0)
                            .foregroundColor(Color.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
                .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                Text(ltkModel.displayName)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            .background(Color(red: 230.0/255, green: 230.0/255.0, blue: 230.0/255.0))
            .padding(EdgeInsets(top: 1, leading: 0, bottom: 0, trailing: 0))

            ScrollView(.vertical) {
                VStack {
                    Image(uiImage: ltkModel.heroImage ?? UIImage())
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    HStack {
                        Text(ltkModel.caption)
                        Spacer()
                    }
                    LazyVGrid(columns: columns) {
                        ForEach(ltkModel.products, id: \.self) { product in
                            ProductView(product: product)
                                .frame(width: 80, height: 80)
                                .onTapGesture {
                                    let url = URL.init(string: product.hyperlink)
                                    guard let productURL = url, UIApplication.shared.canOpenURL(productURL) else { return }
                                    UIApplication.shared.open(productURL)
                                }
                        }
                    }
                }
            }
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct ProductView: View {
    let product: ProductModel

    var body: some View {
        AsyncImage(url: URL(string: product.imageUrl)) { phase in
            switch phase {
            case .empty:
                RoundedRectangle(cornerRadius: 5.0)
                    .foregroundColor(Color.gray)
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .border(Color(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0), width: 1.0)
                    .cornerRadius(5.0)
            case .failure:
                RoundedRectangle(cornerRadius: 5.0)
                    .foregroundColor(Color.gray)
            @unknown default:
                EmptyView()
            }
        }
    }
}
