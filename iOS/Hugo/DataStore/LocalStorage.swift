//
//  LocalStorage.swift
//  Hugo
//
//  Created by Miranz  Technologies on 8/8/20.
//  Copyright © 2020 Ayaz Alavi. All rights reserved.
//

import Foundation

// Home data

let homeBannerData = HomeBannerViewModel(photo: "banner_photo", title: "El Clásico", subtitle: "¡Todo lo que necesitás para vivir el mejor partido del mundo!")

let homeBrandData = [
    HomeBrandViewModel(photo: "brand_photo", icon: "brand_icon", name: "Polo Raph Lauren", categories: "RETAIL, MENSWEAR", time: "30 min", subtext: "Lorem Ipsum", isfavorite: false),
    HomeBrandViewModel(photo: "brand_photo", icon: "brand_icon", name: "Polo Raph Lauren", categories: "RETAIL, MENSWEAR", time: "30 min", subtext: "Lorem Ipsum", isfavorite: false),
    HomeBrandViewModel(photo: "brand_photo", icon: "brand_icon", name: "Polo Raph Lauren", categories: "RETAIL, MENSWEAR", time: "30 min", subtext: "Lorem Ipsum", isfavorite: false),
    HomeBrandViewModel(photo: "brand_photo", icon: "brand_icon", name: "Polo Raph Lauren", categories: "RETAIL, MENSWEAR", time: "30 min", subtext: "Lorem Ipsum", isfavorite: false),
    HomeBrandViewModel(photo: "brand_photo", icon: "brand_icon", name: "Polo Raph Lauren", categories: "RETAIL, MENSWEAR", time: "30 min", subtext: "Lorem Ipsum", isfavorite: false)
]

let homeProductData = [
    HomeProductViewModel(photo: "product_photo", title: "Summer Classic", subtitle: "POLO"),
    HomeProductViewModel(photo: "product_photo", title: "Summer Classic", subtitle: "POLO"),
    HomeProductViewModel(photo: "product_photo", title: "Summer Classic", subtitle: "POLO"),
    HomeProductViewModel(photo: "product_photo", title: "Summer Classic", subtitle: "POLO"),
    HomeProductViewModel(photo: "product_photo", title: "Summer Classic", subtitle: "POLO")
]

let homeStoreData = [
    HomeStoreViewModel(photo: "store_photo", title: "hugo"),
    HomeStoreViewModel(photo: "store_photo", title: "hugo"),
    HomeStoreViewModel(photo: "store_photo", title: "hugo"),
    HomeStoreViewModel(photo: "store_photo", title: "hugo"),
    HomeStoreViewModel(photo: "store_photo", title: "hugo")
]

let homeStoreBrandData = [
    StoreViewModel(photo: "store_brand_photo", icon: "store_brand_icon", name: "Andían", categories: "BISTRO-HEALTHY", time: "30 min", subtext: "Lorem Ipsum", openTimings: "8AM-7PM", ratings: 4.5),
    StoreViewModel(photo: "store_brand_photo", icon: "store_brand_icon", name: "Andían", categories: "BISTRO-HEALTHY", time: "30 min", subtext: "Lorem Ipsum", openTimings: "8AM-7PM", ratings: 4.5),
    StoreViewModel(photo: "store_brand_photo", icon: "store_brand_icon", name: "Andían", categories: "BISTRO-HEALTHY", time: "30 min", subtext: "Lorem Ipsum", openTimings: "8AM-7PM", ratings: 4.5),
    StoreViewModel(photo: "store_brand_photo", icon: "store_brand_icon", name: "Andían", categories: "BISTRO-HEALTHY", time: "30 min", subtext: "Lorem Ipsum", openTimings: "8AM-7PM", ratings: 4.5),
    StoreViewModel(photo: "store_brand_photo", icon: "store_brand_icon", name: "Andían", categories: "BISTRO-HEALTHY", time: "30 min", subtext: "Lorem Ipsum", openTimings: "8AM-7PM", ratings: 4.5),
    StoreViewModel(photo: "store_brand_photo", icon: "store_brand_icon", name: "Andían", categories: "BISTRO-HEALTHY", time: "30 min", subtext: "Lorem Ipsum", openTimings: "8AM-7PM", ratings: 4.5)
]


let productCategoryData = [
    ["category":"SPECIALTY COFFEE", "products": [
            ProductViewModel(photo: "product_brand_photo", title: "Holliday Blend", subtitle: "Lorem Ipsum", icon: "product_brand_icon", price: "$4.90", ageLimit: 18),
            ProductViewModel(photo: "product_brand_photo", title: "Holliday Blend", subtitle: "Lorem Ipsum", icon: "product_brand_icon", price: "$4.90", ageLimit: 18),
            ProductViewModel(photo: "product_brand_photo", title: "Holliday Blend", subtitle: "Lorem Ipsum", icon: "product_brand_icon", price: "$4.90", ageLimit: 18),
            ProductViewModel(photo: "product_brand_photo", title: "Holliday Blend", subtitle: "Lorem Ipsum", icon: "product_brand_icon", price: "$4.90", ageLimit: 18)
        ]
    ],
    ["category":"ELECTRÓNICOS", "products": [
            ProductViewModel(photo: "product_brand_photo", title: "Holliday Blend", subtitle: "Lorem Ipsum", icon: "product_brand_icon", price: "$4.90", ageLimit: 18),
            ProductViewModel(photo: "product_brand_photo", title: "Holliday Blend", subtitle: "Lorem Ipsum", icon: "product_brand_icon", price: "$4.90", ageLimit: 18),
            ProductViewModel(photo: "product_brand_photo", title: "Holliday Blend", subtitle: "Lorem Ipsum", icon: "product_brand_icon", price: "$4.90", ageLimit: 18),
            ProductViewModel(photo: "product_brand_photo", title: "Holliday Blend", subtitle: "Lorem Ipsum", icon: "product_brand_icon", price: "$4.90", ageLimit: 18)
        ]
    ],
    ["category":"PARA TUS MASCOTAS", "products": [
            ProductViewModel(photo: "product_brand_photo", title: "Holliday Blend", subtitle: "Lorem Ipsum", icon: "product_brand_icon", price: "$4.90", ageLimit: 18),
            ProductViewModel(photo: "product_brand_photo", title: "Holliday Blend", subtitle: "Lorem Ipsum", icon: "product_brand_icon", price: "$4.90", ageLimit: 18),
            ProductViewModel(photo: "product_brand_photo", title: "Holliday Blend", subtitle: "Lorem Ipsum", icon: "product_brand_icon", price: "$4.90", ageLimit: 18),
            ProductViewModel(photo: "product_brand_photo", title: "Holliday Blend", subtitle: "Lorem Ipsum", icon: "product_brand_icon", price: "$4.90", ageLimit: 18)
        ]
    ]
]


// Search data

let searchListData = [
    ["category": "RECOMENDADOS", "results": [
                SearchListViewModel(photo: "search_icon_1", title: "Alitas", subtitle: "Comida"),
                SearchListViewModel(photo: "search_icon_1", title: "Alitas", subtitle: "Comida"),
                SearchListViewModel(photo: "search_icon_1", title: "Alitas", subtitle: "Comida"),
                SearchListViewModel(photo: "search_icon_1", title: "Alitas", subtitle: "Comida"),
                SearchListViewModel(photo: "search_icon_1", title: "Alitas", subtitle: "Comida")
            ]
        ], ["category": "MÁS RECIENTES", "results":[
            SearchListViewModel(photo: "search_icon_2", title: "La esquina de Kurt", subtitle: "Salud"),
            SearchListViewModel(photo: "search_icon_2", title: "La esquina de Kurt", subtitle: "Salud"),
            SearchListViewModel(photo: "search_icon_2", title: "La esquina de Kurt", subtitle: "Salud"),
            SearchListViewModel(photo: "search_icon_2", title: "La esquina de Kurt", subtitle: "Salud"),
            SearchListViewModel(photo: "search_icon_2", title: "La esquina de Kurt", subtitle: "Salud")
            ]
        ]
]

let searchresultData = [
    ["category": "RESULTADO DE BÚSQUEDA", "results": [
                SearchListViewModel(photo: "search_icon_1", title: "Supermercado", subtitle: "Categoria"),
                SearchListViewModel(photo: "search_icon_1", title: "Alitas", subtitle: "Comida"),
                SearchListViewModel(photo: "search_icon_1", title: "Alitas", subtitle: "Comida"),
                SearchListViewModel(photo: "search_icon_1", title: "Alitas", subtitle: "Comida"),
                SearchListViewModel(photo: "search_icon_1", title: "Alitas", subtitle: "Comida")
            ]
        ]
]

let searchStoreData = [
    StoreViewModel(photo: "store_main", icon: "store_icon", name: "La Torre", categories: "SUPERMERCADO", time: "30 min", subtext: "Lorem Ipsum", openTimings: "8AM-7PM", ratings: 4.5),
    StoreViewModel(photo: "store_main", icon: "store_icon", name: "La Torre", categories: "SUPERMERCADO", time: "30 min", subtext: "Lorem Ipsum", openTimings: "8AM-7PM", ratings: 4.5),
    StoreViewModel(photo: "store_main", icon: "store_icon", name: "La Torre", categories: "SUPERMERCADO", time: "30 min", subtext: "Lorem Ipsum", openTimings: "8AM-7PM", ratings: 4.5),
    StoreViewModel(photo: "store_main", icon: "store_icon", name: "La Torre", categories: "SUPERMERCADO", time: "30 min", subtext: "Lorem Ipsum", openTimings: "8AM-7PM", ratings: 4.5),
    StoreViewModel(photo: "store_main", icon: "store_icon", name: "La Torre", categories: "SUPERMERCADO", time: "30 min", subtext: "Lorem Ipsum", openTimings: "8AM-7PM", ratings: 4.5),
    StoreViewModel(photo: "store_main", icon: "store_icon", name: "La Torre", categories: "SUPERMERCADO", time: "30 min", subtext: "Lorem Ipsum", openTimings: "8AM-7PM", ratings: 4.5)
]

var searchFieldInputText: String = ""


// Search Result

let productSearchData =  [
            ProductViewModel(photo: "product_brand_photo", title: "Holliday Blend", subtitle: "Lorem Ipsum", icon: "product_brand_icon", price: "$4.90", ageLimit: 18),
            ProductViewModel(photo: "product_brand_photo", title: "Holliday Blend", subtitle: "Lorem Ipsum", icon: "product_brand_icon", price: "$4.90", ageLimit: 18),
            ProductViewModel(photo: "product_brand_photo", title: "Holliday Blend", subtitle: "Lorem Ipsum", icon: "product_brand_icon", price: "$4.90", ageLimit: 18),
            ProductViewModel(photo: "product_brand_photo", title: "Holliday Blend", subtitle: "Lorem Ipsum", icon: "product_brand_icon", price: "$4.90", ageLimit: 18)
        ]

let productFilterData =  [
    SearchResultFilterViewModel(title: "Carnes"),
    SearchResultFilterViewModel(title: "Promociones"),
    SearchResultFilterViewModel(title: "Promociones"),
    SearchResultFilterViewModel(title: "Carnes"),
    SearchResultFilterViewModel(title: "Carnes"),
    SearchResultFilterViewModel(title: "Carnes"),
    SearchResultFilterViewModel(title: "Promociones"),
    SearchResultFilterViewModel(title: "Promociones"),
    SearchResultFilterViewModel(title: "Carnes"),
]


let promotionsData = [
    StorePromotionsViewModel(photo: "promotion_photo"),
    StorePromotionsViewModel(photo: "promotion_photo"),
    StorePromotionsViewModel(photo: "promotion_photo"),
    StorePromotionsViewModel(photo: "promotion_photo"),
    StorePromotionsViewModel(photo: "promotion_photo")
]

let storeData = [
    ["category":"ABARROTES", "products": [
            ProductViewModel(photo: "store_product_photo", title: "Holliday Blend", subtitle: "Lorem Ipsum", icon: "product_brand_icon", price: "$4.90", ageLimit: 18),
            ProductViewModel(photo: "store_product_photo", title: "Holliday Blend", subtitle: "Lorem Ipsum", icon: "product_brand_icon", price: "$4.90", ageLimit: 18),
            ProductViewModel(photo: "store_product_photo", title: "Holliday Blend", subtitle: "Lorem Ipsum", icon: "product_brand_icon", price: "$4.90", ageLimit: 18),
            ProductViewModel(photo: "store_product_photo", title: "Holliday Blend", subtitle: "Lorem Ipsum", icon: "product_brand_icon", price: "$4.90", ageLimit: 18),
            ProductViewModel(photo: "store_product_photo", title: "Holliday Blend", subtitle: "Lorem Ipsum", icon: "product_brand_icon", price: "$4.90", ageLimit: 18),
            ProductViewModel(photo: "store_product_photo", title: "Holliday Blend", subtitle: "Lorem Ipsum", icon: "product_brand_icon", price: "$4.90", ageLimit: 18),
            ProductViewModel(photo: "store_product_photo", title: "Holliday Blend", subtitle: "Lorem Ipsum", icon: "product_brand_icon", price: "$4.90", ageLimit: 18)
        ]
    ],
    ["category":"LÁCTEOS Y HUEVOS", "products": [
            ProductViewModel(photo: "store_product_photo", title: "Holliday Blend", subtitle: "Lorem Ipsum", icon: "product_brand_icon", price: "$4.90", ageLimit: 18),
            ProductViewModel(photo: "store_product_photo", title: "Holliday Blend", subtitle: "Lorem Ipsum", icon: "product_brand_icon", price: "$4.90", ageLimit: 18),
            ProductViewModel(photo: "store_product_photo", title: "Holliday Blend", subtitle: "Lorem Ipsum", icon: "product_brand_icon", price: "$4.90", ageLimit: 18),
            ProductViewModel(photo: "store_product_photo", title: "Holliday Blend", subtitle: "Lorem Ipsum", icon: "product_brand_icon", price: "$4.90", ageLimit: 18),
            ProductViewModel(photo: "store_product_photo", title: "Holliday Blend", subtitle: "Lorem Ipsum", icon: "product_brand_icon", price: "$4.90", ageLimit: 18),
            ProductViewModel(photo: "store_product_photo", title: "Holliday Blend", subtitle: "Lorem Ipsum", icon: "product_brand_icon", price: "$4.90", ageLimit: 18),
            ProductViewModel(photo: "store_product_photo", title: "Holliday Blend", subtitle: "Lorem Ipsum", icon: "product_brand_icon", price: "$4.90", ageLimit: 18)
        ]
    ],
    ["category":"CARNES, AVES Y PESCADOS", "products": [
            ProductViewModel(photo: "store_product_photo", title: "Holliday Blend", subtitle: "Lorem Ipsum", icon: "product_brand_icon", price: "$4.90", ageLimit: 18),
            ProductViewModel(photo: "store_product_photo", title: "Holliday Blend", subtitle: "Lorem Ipsum", icon: "product_brand_icon", price: "$4.90", ageLimit: 18),
            ProductViewModel(photo: "store_product_photo", title: "Holliday Blend", subtitle: "Lorem Ipsum", icon: "product_brand_icon", price: "$4.90", ageLimit: 18),
            ProductViewModel(photo: "store_product_photo", title: "Holliday Blend", subtitle: "Lorem Ipsum", icon: "product_brand_icon", price: "$4.90", ageLimit: 18),
            ProductViewModel(photo: "store_product_photo", title: "Holliday Blend", subtitle: "Lorem Ipsum", icon: "product_brand_icon", price: "$4.90", ageLimit: 18),
            ProductViewModel(photo: "store_product_photo", title: "Holliday Blend", subtitle: "Lorem Ipsum", icon: "product_brand_icon", price: "$4.90", ageLimit: 18),
            ProductViewModel(photo: "store_product_photo", title: "Holliday Blend", subtitle: "Lorem Ipsum", icon: "product_brand_icon", price: "$4.90", ageLimit: 18)
        ]
    ]
]


let productStoreData =  [
    ProductViewModel(photo: "store_product_photo", title: "Holliday Blend", subtitle: "Lorem Ipsum", icon: "product_brand_icon", price: "$4.90", ageLimit: 18),
    ProductViewModel(photo: "store_product_photo", title: "Holliday Blend", subtitle: "Lorem Ipsum", icon: "product_brand_icon", price: "$4.90", ageLimit: 18),
    ProductViewModel(photo: "store_product_photo", title: "Holliday Blend", subtitle: "Lorem Ipsum", icon: "product_brand_icon", price: "$4.90", ageLimit: 18),
    ProductViewModel(photo: "store_product_photo", title: "Holliday Blend", subtitle: "Lorem Ipsum", icon: "product_brand_icon", price: "$4.90", ageLimit: 18),
    ProductViewModel(photo: "store_product_photo", title: "Holliday Blend", subtitle: "Lorem Ipsum", icon: "product_brand_icon", price: "$4.90", ageLimit: 18),
    ProductViewModel(photo: "store_product_photo", title: "Holliday Blend", subtitle: "Lorem Ipsum", icon: "product_brand_icon", price: "$4.90", ageLimit: 18),
    ProductViewModel(photo: "store_product_photo", title: "Holliday Blend", subtitle: "Lorem Ipsum", icon: "product_brand_icon", price: "$4.90", ageLimit: 18)
]
