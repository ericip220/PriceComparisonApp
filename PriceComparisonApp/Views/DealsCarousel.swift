//
//  DealsCarousel.swift
//  PriceComparisonApp
//
//  Created by Eric IP on 07/02/2025.
//
import SwiftUI

struct DealsCarousel: View {
    let deals = [
        ("Deal 1", "tag.fill"),
        ("Deal 2", "tag.circle.fill"),
        ("Deal 3", "star.fill"),
        ("Deal 4", "heart.fill"),
        ("Deal 5", "cart.fill")
    ]
    
    @State private var isPressed: Bool = false
    
    var body: some View {
        VStack {
            //ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .center, spacing: -15) {
                    ForEach(deals, id: \.0) { deal, icon in
                        VStack(spacing: 8) {
                            ZStack {
                                Circle ()
                                    .fill(Color(hue: 0.571, saturation: 0.251, brightness: 0.981))
                                    .frame(width: 50, height: 50)
                                    .overlay(
                                        Circle ()
                                            .stroke(Color.black, lineWidth: 5) // Add border
                                    )
                                    .opacity(isPressed ? 0.2 : 1.0)
                                Image(systemName: icon)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                }
                            Text(deal)
                                .font(.caption)
                                .multilineTextAlignment(.center)
                        }
                        .frame(width: 55)
                        }
                        .padding()
                    }
                .padding(.horizontal, 13.0)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                //.background(Color(.systemGray6))
            }
        }

struct DealsCarousel_Previews: PreviewProvider {
    static var previews: some View {
        DealsCarousel()
    }
}
