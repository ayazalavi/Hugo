package com.hugo.viewmodels;

import android.content.Context;

import androidx.lifecycle.LiveData;
import androidx.lifecycle.MutableLiveData;
import androidx.lifecycle.ViewModel;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class StoreHomeViewModel extends ViewModel {
    private Context ctx = null;
    private final MutableLiveData<List<StorePromotions>> storePromotions = new MutableLiveData<List<StorePromotions>>();
    private final MutableLiveData<Store> store = new MutableLiveData<Store>();
    private final MutableLiveData<HashMap<String, List<Product>>> storeData = new MutableLiveData<HashMap<String, List<Product>>>();

    public void setContext(Context context) {
        this.ctx = context;
    }

    public LiveData<List<StorePromotions>> getPromotions() {
        if (ctx != null) {
            List<StorePromotions> list = new ArrayList<StorePromotions>() {
                {
                    add(new StorePromotions("promotion_photo"));
                    add(new StorePromotions("promotion_photo"));
                    add(new StorePromotions("promotion_photo"));
                    add(new StorePromotions("promotion_photo"));
                    add(new StorePromotions("promotion_photo"));
                }
            };
            storePromotions.setValue(list);
        }
        return storePromotions;
    }

    public LiveData<Store> getStore() {
        if (ctx != null) {
            Store store = new Store("store_main", "store_icon", "La Torre", "SUPERMERCADO", "30 min", "Lorem Ipsum","8AM-7PM", 4.5);
            this.store.setValue(store);
        }
        return this.store;
    }

    public LiveData<HashMap<String, List<Product>>> getStoreData() {
        if (ctx != null) {
            final List<Product> list = new ArrayList<Product>() {
                {
                    add(new Product ("store_product_photo", "Holliday Blend", "Lorem Ipsum", "product_brand_icon",  "$4.90",  18));
                    add(new Product ("store_product_photo", "Holliday Blend", "Lorem Ipsum", "product_brand_icon",  "$4.90",  18));
                    add(new Product ("store_product_photo", "Holliday Blend", "Lorem Ipsum", "product_brand_icon",  "$4.90",  18));
                    add(new Product ("store_product_photo", "Holliday Blend", "Lorem Ipsum", "product_brand_icon",  "$4.90",  18));
                }
            };
            HashMap<String, List<Product>> hashMap = new HashMap<String, List<Product>>() {
                {
                    put("ABARROTES", new ArrayList<Product>(list));
                    put("LÁCTEOS Y HUEVOS", new ArrayList<Product>(list));
                    put("CARNES, AVES Y PESCADOS", new ArrayList<Product>(list));
                    put("ABARROTES12", new ArrayList<Product>(list));
                    put("LÁCTEOS Y HUEVOS112", new ArrayList<Product>(list));
                    put("CARNES, AVES Y PESCADOS12", new ArrayList<Product>(list));
                }
            };
            storeData.setValue(hashMap);
        }
        return storeData;
    }

}
